
import UIKit

//MARK: - Protocols

protocol DetailAdViewModelInput {
    var coordinator: DetailAdCoordinator? { get set }
    var output: DetailAdViewModelOutput? { get set }
    var advertisement: AdvertisementData? { get set }
    
    func viewDidDisappear()
}

protocol DetailAdViewModelOutput: NSObject {
    func customizeOutput()
}

//MARK: - Class

final class DetailAdViewModel {
    var coordinator: DetailAdCoordinator?
    weak var output: DetailAdViewModelOutput? {
        didSet {
            output?.customizeOutput()
        }
    }
    var advertisement: AdvertisementData?
}

//MARK: - Extension

extension DetailAdViewModel: DetailAdViewModelInput {
    func viewDidDisappear(){
        coordinator?.didFinish()
    }
}
