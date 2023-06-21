
import UIKit

class MainScreenController: VMController<MainScreenPresentable, MainScreenViewModelInput> {
    
    //MARK: - Properties

    var collectionViewManager: MainScreenCollectionViewManager?

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewManager = MainScreenCollectionViewManager()
        content.collectionView.dataSource = collectionViewManager
        content.collectionView.delegate = collectionViewManager
        collectionViewManager?.delegate = self
        viewModel.getDataFromModel()
//        viewModel.getActiveAdsDataFromModel()
        
    }

    //MARK: - Override methods

    override func onConfigureController() {
        navigationItem.title = "Негизги экран"
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleSegmentedControlValueChanged = viewModel.toggleCollectionView
        content.searchField.delegate = self
    }
}

//MARK: - Extension

extension MainScreenController: MainScreenViewModelOutput {
    func customizeOutput(with data: [SubsubtitleViewModel]) {
        collectionViewManager?.setCollectionViewData(data, collectionView: content.collectionView)
    }
}

extension MainScreenController: MainScreenCollectionViewDelegate {
    func selectedCell(at indexPath: IndexPath) {
        viewModel.cellTapped(at: indexPath)
    }
}

extension MainScreenController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            if text != ""{
                viewModel.performSearch(with: text)
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            viewModel.getDataFromModel()
        }
    }

}
