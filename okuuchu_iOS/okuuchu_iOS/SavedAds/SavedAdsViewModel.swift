
import Foundation

//MARK: - Protocols

protocol SavedAdsViewModelInput: AnyObject{
    var coordinator: SavedAdsCoordinator? { get set }
    var output: SavedAdsViewModelOutput? { get set }
}

protocol SavedAdsViewModelOutput: AnyObject {
    func customizeOutput()
}
//MARK: - Class

final class SavedAdsViewModel {
    var coordinator: SavedAdsCoordinator?
    var output: SavedAdsViewModelOutput? {
        didSet {
            output?.customizeOutput()
        }
    }
}
//MARK: - Preperties

extension SavedAdsViewModel: SavedAdsViewModelInput {
    
}
