
import UIKit

class AddAdvertisementPresentable: BaseView {
    
    //MARK: - Properties
    
    struct Navigation {
        let cancelButton: UIBarButtonItem = .init(image: Asset.cancelIcon.image.withTintColor(Asset.normalTextColor.color, renderingMode: .alwaysOriginal))
    }

    let navigation: Navigation = .init()
    private let addButton: PrimaryButton = .init()

    var handleCancelButtonTapAction: (() -> Void)?

    
    //MARK: - Override Methods
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color
        
        addButton.setTitle("Добавить", for: .normal)
        addButton.backgroundColor = Asset.primaryButtonsBlue.color
    }
    
    override func onAddSubviews() {
        addSubviews(
            addButton
        )
    }
    
    override func onSetupConstraints() {
        addButton.snp.makeConstraints{ maker in
            maker.bottom.equalToSuperview().offset(-40)
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.height.equalTo(70)
        }
    }
    
    override func onSetupTargets() {
        navigation.cancelButton.target = self
        navigation.cancelButton.action = #selector(cancelButtonTapAction)
        
    }

}

//MARK: - Extension

extension AddAdvertisementPresentable {
    @objc func cancelButtonTapAction(){
        handleCancelButtonTapAction?()
    }
}
