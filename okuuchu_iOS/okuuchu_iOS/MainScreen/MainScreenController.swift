
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
        viewModel.getActiveAdsDataFromModel()
        
    }

    //MARK: - Override methods

    override func onConfigureController() {

    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleSegmentedControlValueChanged = viewModel.toggleCollectionView
    }
}

//MARK: - Extension

extension MainScreenController: MainScreenViewModelOutput {
    func customizeOutput(with data: [SubsubtitleViewModel]) {
        collectionViewManager?.setCollectionViewData(data, collectionView: content.collectionView)
    }
}

extension MainScreenController: MainScreenCollectionViewDelegate {
    
}
