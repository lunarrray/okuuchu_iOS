

import UIKit

class SavedAdsController: VMController<SavedAdsPresesntable, SavedAdsViewModelInput> {
   
    //MARK: - Properties
    
    var collectionViewManager: SavedAdsCollectionViewManager?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewManager = SavedAdsCollectionViewManager()
        
        content.collectionView.dataSource = collectionViewManager
        content.collectionView.delegate = collectionViewManager
        
        collectionViewManager?.delegate = self
        viewModel.getSavedAdsDataFromModel()
    }
    
    //MARK: - Override methods
    
    override func onConfigureController() {
        navigationItem.title = "Сохраненные обьявления"
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        
    }

}

//MARK: - Extension

extension SavedAdsController: SavedAdsViewModelOutput {
    
    func customizeOutput(with data: [SubsubtitleViewModel]) {
        collectionViewManager?.setCollectionViewData(data, collectionView: content.collectionView)
    }
}

extension SavedAdsController: SavedAdsCollectionViewDelegate{
    
}