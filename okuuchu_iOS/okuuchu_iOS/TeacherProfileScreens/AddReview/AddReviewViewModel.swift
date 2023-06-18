
import UIKit

//MARK: - Protocols

protocol AddReviewViewModelInput {
    var coordinator: AddReviewCoordinator? { get set }
    var output: AddReviewViewModelOutput? { get set }
    
    func cancelAddingVideo()
    func viewDidDisappear()
    func setAssesment(index: String)
    func updateReviewTextView(with text: String)
    func addReview()
}

protocol AddReviewViewModelOutput: AnyObject {
    func customizeOutput()
    func setRating(with assesment: Int)
}


//MARK: - Class

final class AddReviewViewModel: NSObject {
    var coordinator: AddReviewCoordinator?
    weak var output: AddReviewViewModelOutput?
    
    private var assesment: Int = 0
    private var reviewText: String = ""
}


//MARK: - Extension
extension AddReviewViewModel: AddReviewViewModelInput {
    
    func cancelAddingVideo() {
        coordinator?.didFinish()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func setAssesment(index: String){
        if let indexInt = Int(index){
            assesment = indexInt + 1
            output?.setRating(with: assesment)
        }
    }
    
    func updateReviewTextView(with text: String) {
        reviewText = text
    }
    
    func addReview() {
        let reviewData = ReviewData(reviewer: User(name: "Ann", age: 14, image: Asset.menAvatar.image), assessment: Double(assesment), reviewText: reviewText)
        print("name: \(reviewData.reviewer ?? User())")
        print("assesment: \(reviewData.assessment ?? -1)")
        print("text: \(reviewData.reviewText ?? "")")

        coordinator?.didFinish()
    }
    
}
