
import UIKit

final class DetailAdPresentable: BaseView {
    
    //MARK: - Properties
    struct Navigation {
        var saveButton = UIBarButtonItem(image: Asset.saveIcon.image.withTintColor(Asset.darkBlue.color, renderingMode: .alwaysOriginal))
    }
    
    var navigation: Navigation = .init()
    var imageView: UIImageView = .init()
    
    //MARK: - Override methods
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color
    }

}

//MARK: - Extension
