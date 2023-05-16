

import UIKit
import Foundation

class PersonalAdsController: VMController<PersonalAdsPresentable, PersonalAdsViewModelInput> {
    
    //MARK: - Properties
    
    var collectionViewManager: PersonalAdsCollectionViewManager?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        collectionViewManager = PersonalAdsCollectionViewManager()
        content.collectionView.delegate = collectionViewManager
        content.collectionView.dataSource = collectionViewManager
        
        collectionViewManager?.delegate = self
        
        viewModel.getActiveAdsDataFromModel()
    }

    //MARK: - Override Methods
    
    override func onConfigureController() {
        navigationItem.title = "Обьявления"
    }

    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfiugureActions() {
        content.handleSegmentedControlValueChanged = viewModel.toggleCollectionView(segmentedControlIndex:)
    }
}

//MARK: - Extension

extension PersonalAdsController: PersonalAdsViewModelOutput {
    func customizeOutput(with data: [AdvertisementData]) {
        collectionViewManager?.setCollectionViewData(data, collectionView: content.collectionView)
    }
}

extension PersonalAdsController: PersonalAdsCollectionViewDelegate {
    
}
