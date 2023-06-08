
import UIKit

class RecordedVideoPresentable: BaseView {
    
    //MARK: - Properties
    struct Navigation {
        let deleteButton: UIBarButtonItem = .init(title: "Удалить")
        let selectButton: UIBarButtonItem = .init(title: "Выделить")
    }
    var navigation: Navigation = .init()
 
    var searchField: SearchTextField = .init()
    lazy var tableView: UITableView = .init()
    private var addButton: PrimaryButton = .init()
    
    private var isSelectiongMode = false
    
    var handleSelectButtonTapAction: (() -> Void)?
    var handleDeleteButtonTapAction: (() -> Void)?
    var handleAddButtonTapAction: (() -> Void)?
    
    //MARK: - Override methods
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color
        
        let font = UIFont.systemFont(ofSize: 17)
        let fontDescriptor = font.fontDescriptor.withSymbolicTraits(.traitBold)!

        navigation.deleteButton.title = "Удалить"
        navigation.deleteButton.setTitleTextAttributes([.font: UIFont(descriptor: fontDescriptor, size: font.pointSize)], for: .normal)
        navigation.deleteButton.tintColor = Asset.redButton.color
        
        navigation.deleteButton.isHidden = true

        
        navigation.selectButton.title = "Выделить"
        navigation.selectButton.setTitleTextAttributes([.font: UIFont(descriptor: fontDescriptor, size: font.pointSize)], for: .normal)
        navigation.selectButton.tintColor = Asset.textButton.color
        
        searchField.returnKeyType = .search

        tableView.register(TitleSubtitleCell.self, forCellReuseIdentifier: String(describing: TitleSubtitleCell.self))
                
        addButton.backgroundColor = Asset.primaryButtonsBlue.color
        addButton.setTitle("Добавить", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
    }
    
    override func onAddSubviews() {
        addSubviews(
            searchField,
            tableView,
            addButton
        )
    }
    
    override func onSetupConstraints() {
        searchField.snp.makeConstraints{ maker in
            maker.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.height.equalTo(32)
        }
        
        tableView.snp.makeConstraints{ maker in
            maker.top.equalTo(searchField.snp.bottom).offset(20)
            maker.horizontalEdges.equalToSuperview().inset(15)
            maker.bottom.equalTo(addButton.snp.top).offset(-10)
        }
        
        addButton.snp.makeConstraints{ maker in
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.height.equalTo(60)
            maker.bottom.equalToSuperview().offset(-40)
        }
    }
    
    override func onSetupTargets() {
        navigation.selectButton.target = self
        navigation.selectButton.action = #selector(selectButtonTapAction)
        
        navigation.deleteButton.target = self
        navigation.deleteButton.action = #selector(deleteButtonTapAction)
        
        addButton.addTarget(self, action: #selector(addButtonTapAction), for: .touchUpInside)
        
    }
    
}

//MARK: - Extension

extension RecordedVideoPresentable{
    @objc private func addButtonTapAction(){
        handleAddButtonTapAction?()
    }
    
    @objc private func selectButtonTapAction(){
        handleSelectButtonTapAction?()
    }
    
    @objc private func deleteButtonTapAction(){
        handleDeleteButtonTapAction?()
    }
    
    func toggleButtons(){
        if isSelectiongMode{
            navigation.deleteButton.isHidden = true
            navigation.selectButton.isHidden = false
            isSelectiongMode = false
        } else {
            navigation.selectButton.isHidden = true
            navigation.deleteButton.isHidden = false
            isSelectiongMode = true
        }
    }
    
    func nonEditableView(){
        addButton.isHidden = true
        navigation.selectButton.isHidden = true
    }
}
