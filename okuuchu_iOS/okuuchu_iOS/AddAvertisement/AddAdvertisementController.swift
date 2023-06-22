
import UIKit

class AddAdvertisementController: VMController<AddAdvertisementPresentable, AddAdvertisementViewModelInput> {
    
    //MARK: - Properties
    
    private var tableViewManager: AddAdvertisementTableViewManager?
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewManager = AddAdvertisementTableViewManager()
        content.tableView.dataSource = tableViewManager
        content.tableView.delegate = tableViewManager
        
        viewModel.setAdvertisement()
        tableViewManager?.delegate = self
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isMovingFromParent {
            viewModel.viewDidDisappear()
        }
    }
    
    
    //MARK: - Override methods
    
    override func onConfigureController() {
        navigationItem.title = "Жарнама кошуу"
        navigationItem.leftBarButtonItem = content.navigation.cancelButton
        navigationItem.rightBarButtonItem = content.navigation.addButton
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleCancelButtonTapAction = viewModel.cancelAddingVideo
        content.handleAddButtonTapAction = viewModel.addAdvertisement
    }
}

//MARK: - Extension

extension AddAdvertisementController: AddAdvertisementViewModelOutput {
    func customizeOutput(with advertisementData: [TitleSubtitleViewModel], image: TitleSubtitleViewModel, activeTabBar: Bool) {
        tableViewManager?.setData(advertisementData, tableView: content.tableView)
        content.setImage(with: image)
        content.tabBarMode(isActive: activeTabBar)
    }
    
    func setImage(image: TitleSubtitleViewModel){
        content.setImage(with: image)
    }
    
    func choseLocation(_ locations: [Location]) {
        let ac = UIAlertController(title: "Жайгашкан жер тандоо", message: nil, preferredStyle: .actionSheet)
        for location in locations {
            ac.addAction(UIAlertAction(title: location.title, style: .default, handler: setLocation))
        }
        ac.addAction(UIAlertAction(title: "Баш тартуу", style: .cancel))
        present(ac, animated: true)
    }
    
    func selectItems(from items: [String], selection: Selection) {
        let ac = UIAlertController(title: selection.title, message: nil, preferredStyle: .actionSheet)
        for item in items {
            ac.addAction(UIAlertAction(title: item, style: .default) { [weak self] _ in
                self?.viewModel.selected(item: item, for: selection)
            })
        }
        ac.addAction(UIAlertAction(title: "Баарын очуруу", style: .default) { [weak self] _ in
            self?.viewModel.clearData(for: selection)
        })
        ac.addAction(UIAlertAction(title: "Баш тартуу", style: .cancel))
        present(ac, animated: true)
    }
}

extension AddAdvertisementController: AddAdvertisementTableViewDelegate {
    func updateCell(for indexPath: IndexPath, subtitle: String){
        let index = indexPath.row
        viewModel.updateCell(for: index, subtitle: subtitle)
    }
}

extension AddAdvertisementController {
    @objc private func setLocation(action: UIAlertAction) {
        if let actionTitle = action.title {
            viewModel.setLocation(actionTitle)
        }
    }
}
