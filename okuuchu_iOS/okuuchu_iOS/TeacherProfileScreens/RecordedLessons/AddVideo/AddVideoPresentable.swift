
import UIKit

class AddVideoPresentable: BaseView {
    
    //MARK: - Properties
    
    struct Navigation {
        let cancelButton: UIBarButtonItem = .init(image: Asset.cancelIcon.image.withTintColor(Asset.normalTextColor.color, renderingMode: .alwaysOriginal))
    }
    
    let navigation: Navigation = .init()
    lazy var tableView: UITableView = .init()
    private let addButton: PrimaryButton = .init()
    
    var handleCancelButtonTapAction: (() -> Void)?
    var handleAddButtonTapAction: (() -> Void)?
    
    //MARK: - Override Methods
    
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color
        
        tableView.register(LabeledTextViewCell.self, forCellReuseIdentifier: String(describing: LabeledTextViewCell.self))
        
        let view = PrimaryView()
        view.backgroundColor = .clear
        view.addVidoPublishingImage()
        tableView.backgroundColor = .clear
        tableView.backgroundView = view
        tableView.separatorStyle = .none
        
        addButton.setTitle("Добавить", for: .normal)
        addButton.backgroundColor = Asset.primaryButtonsBlue.color
    }
    
    override func onAddSubviews() {
        addSubviews(
            tableView,
            addButton
        )
    }
    
    override func onSetupConstraints() {
        
        addButton.snp.makeConstraints{ maker in
            maker.bottom.equalToSuperview().offset(-40)
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.height.equalTo(70)
        }
        
        tableView.snp.makeConstraints{ maker in
            maker.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            maker.horizontalEdges.equalToSuperview().inset(10)
            maker.bottom.equalTo(addButton.snp.top)
        }
    }
    
    override func onSetupTargets() {
        navigation.cancelButton.target = self
        navigation.cancelButton.action = #selector(cancelButtonTapAction)
        
        addButton.addTarget(self, action: #selector(addButtonTapAction), for: .touchUpInside)
    }

}

//MARK: - Extension

extension AddVideoPresentable {
    @objc private func cancelButtonTapAction(){
        handleCancelButtonTapAction?()
    }
    
    @objc private func addButtonTapAction(){
        handleAddButtonTapAction?()
    }
}
