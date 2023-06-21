
import UIKit

final class AddReviewController: VMController<AddReviewPresentable, AddReviewViewModelInput> {
    
    //MARK: - Properties
    
    
    //MARK: - LifeCycle
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParent {
            viewModel.viewDidDisappear()
        }
    }
    
    //MARK: - Override methods
    
    override func onConfigureController() {
        navigationItem.title = "Пикир жазуу"
        navigationItem.leftBarButtonItem = content.navigation.cancelButton
        content.reviewTextView.setTextViewDelegate(delegate: self)
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleCancelButtonTapAction = viewModel.cancelAddingVideo
        content.handleStarButtonTapAction = viewModel.setAssesment(index:)
        content.handleAddButtonTapAction = viewModel.addReview
    }

}


//MARK: - extension
extension AddReviewController: AddReviewViewModelOutput {
    
    func customizeOutput() {
        
    }
    
    func setRating(with assesment: Int) {
        content.rateTutor(with: assesment)
    }
}


extension AddReviewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard let currentText = textView.text else { return false }
        let text = currentText + text
        
        viewModel.updateReviewTextView(with: text)
        return true
    }
}
