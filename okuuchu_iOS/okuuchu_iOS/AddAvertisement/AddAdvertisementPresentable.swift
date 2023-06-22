
import UIKit

class AddAdvertisementPresentable: BaseView {
    
    //MARK: - Properties
    
    struct Navigation {
        let cancelButton: UIBarButtonItem = .init(image: Asset.cancelIcon.image.withTintColor(Asset.normalTextColor.color, renderingMode: .alwaysOriginal))
        let addButton: UIBarButtonItem = .init(title: "Кошуу")
    }

    let navigation: Navigation = .init()
    private let addButton: PrimaryButton = .init()
    private let rectangleImageView: RectangleImageView = .init(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
    lazy var tableView: UITableView = .init()

    var handleCancelButtonTapAction: (() -> Void)?

    
    //MARK: - Override Methods
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color
        
        let font = UIFont.systemFont(ofSize: 17)
        let fontDescriptor = font.fontDescriptor.withSymbolicTraits(.traitBold)!

        navigation.addButton.title = "Кошуу"
        navigation.addButton.setTitleTextAttributes([.font: UIFont(descriptor: fontDescriptor, size: font.pointSize)], for: .normal)
        navigation.addButton.tintColor = Asset.darkBlue.color

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.register(LabeledTextViewCell.self, forCellReuseIdentifier: String(describing: LabeledTextViewCell.self))
        
        addButton.setTitle("Кошуу", for: .normal)
        addButton.backgroundColor = Asset.primaryButtonsBlue.color
    }
    
    override func onAddSubviews() {
        addSubviews(
            rectangleImageView,
            tableView,
            addButton
        )
    }
    
    override func onSetupConstraints() {
        rectangleImageView.snp.makeConstraints{ maker in
            maker.top.equalTo(safeAreaLayoutGuide.snp.top)
            maker.centerX.equalToSuperview()
            maker.width.height.equalTo(120)
        }
        addButton.snp.makeConstraints{ maker in
            maker.bottom.equalToSuperview().offset(-40)
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.height.equalTo(70)
        }
        
        tableView.snp.makeConstraints{ maker in
            maker.horizontalEdges.equalToSuperview()
            maker.top.equalTo(rectangleImageView.snp.bottom).offset(20)
            maker.bottom.equalTo(addButton.snp.top).offset(-10)
        }
    }
    
    override func onSetupTargets() {
        navigation.cancelButton.target = self
        navigation.cancelButton.action = #selector(cancelButtonTapAction)
//        navigation

    }

}

//MARK: - Extension

extension AddAdvertisementPresentable {
    @objc func cancelButtonTapAction(){
        handleCancelButtonTapAction?()
    }
}
