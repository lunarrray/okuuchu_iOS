
import UIKit

class MainScreenPresentable: BaseView {
    
    //MARK: - Properties
    
    lazy var collectionView: UICollectionView = .init()
    
    //MARK: - Override Methods
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color
    }
    
    override func onAddSubviews() {
        
    }
    
    override func onSetupConstraints() {
        
    }

}

//MARK: - Extension

