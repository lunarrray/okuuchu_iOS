
import UIKit

class SchedulePresentable: BaseView {
    
    //MARK: - Properties
    
    struct Navigation {
        let deleteButton: UIBarButtonItem = .init(title: "Удалить")
        
    }
    var navigation: Navigation = .init()
    var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс", ])
        segmentedControl.contentVerticalAlignment = .center
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    lazy var tableView: RoundedTableView = .init()
    var addButton: PrimaryButton = .init()
    var saveButton: PrimaryButton = .init()

    private let whiteView: UIView = .init()

    
    var handleSegmentedControlValueChanged: ((Int) -> Void)?
    var handleDeleteButtonTapAction: (() -> Void)?
    var handleAddButtonTapAction: (()-> Void)?
    var handleSaveButtonAction: (() -> Void)?
    
    //MARK: - Methods
    
    override func onConfigureView() {
        backgroundColor = Asset.secondaryBlueBackground.color
        
        let font = UIFont.systemFont(ofSize: 17)
        let fontDescriptor = font.fontDescriptor.withSymbolicTraits(.traitBold)!

        navigation.deleteButton.title = "Удалить"
        navigation.deleteButton.setTitleTextAttributes([.font: UIFont(descriptor: fontDescriptor, size: font.pointSize)], for: .normal)
        navigation.deleteButton.tintColor = Asset.redButton.color
        
        segmentedControl.layer.backgroundColor = Asset.white.color.cgColor
        segmentedControl.selectedSegmentTintColor = Asset.darkBlue.color
        segmentedControl.clipsToBounds = false
        segmentedControl.addShadow()
        fixBackgroundSegmentControl(segmentedControl)

        for _ in 0..<segmentedControl.numberOfSegments {
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        }
    
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: String(describing: SubtitleCell.self))
        
        addButton.backgroundColor = Asset.darkBlue.color
        addButton.setTitleColor(Asset.white.color, for: .normal)
        addButton.setTitle("Добавить", for: .normal)
        
        saveButton.backgroundColor = Asset.darkBlue.color
        saveButton.setTitleColor(Asset.white.color, for: .normal)
        saveButton.setTitle("Сохранить", for: .normal)
        
        whiteView.backgroundColor = Asset.white.color
        

    }
    
    override func onAddSubviews() {
        addSubviews(segmentedControl, tableView, whiteView, addButton, saveButton)
    }
    
    override func onSetupConstraints() {
        segmentedControl.snp.makeConstraints{ maker in
            maker.top.equalTo(safeAreaLayoutGuide.snp.top).offset(15)
            maker.horizontalEdges.equalToSuperview().inset(10)
        }
        tableView.snp.makeConstraints{ maker in
            maker.top.equalTo(segmentedControl.snp.bottom).offset(25)
            maker.width.equalToSuperview()
            maker.bottom.equalTo(addButton.snp.top).offset(-10)
        }
        
        whiteView.snp.makeConstraints{ maker in
            maker.top.equalTo(tableView.snp.bottom)
            maker.right.left.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        addButton.snp.makeConstraints{ maker in
            maker.bottom.equalToSuperview().offset(-35)
            maker.left.equalToSuperview().offset(25)
            maker.width.equalTo(160)
            maker.height.equalTo(60)
        }
        
        saveButton.snp.makeConstraints{ maker in
            maker.bottom.equalToSuperview().offset(-35)
            maker.right.equalToSuperview().offset(-25)
            maker.width.equalTo(addButton.snp.width)
            maker.height.equalTo(60)
        }
    }
    
    override func onSetupTargets() {
        navigation.deleteButton.target = self
        navigation.deleteButton.action = #selector(deleteButtonTapAction)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        addButton.addTarget(self, action: #selector(addButtonTapAction), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapAction), for: .touchUpInside)
    }
}

//MARK: - Extension


extension SchedulePresentable {
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl){
        handleSegmentedControlValueChanged?(sender.selectedSegmentIndex)
    }
    
    @objc func deleteButtonTapAction(){
        handleDeleteButtonTapAction?()
    }
    
    @objc func addButtonTapAction(){
        handleAddButtonTapAction?()
    }
    
    @objc func saveButtonTapAction(){
        handleSaveButtonAction?()
    }
    
    func fixBackgroundSegmentControl( _ segmentControl: UISegmentedControl){
        if #available(iOS 13.0, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for i in 0...(segmentControl.numberOfSegments-1)  {
                    let backgroundSegmentView = segmentControl.subviews[i]
                    backgroundSegmentView.isHidden = true
                }
            }
        }
    }
}
