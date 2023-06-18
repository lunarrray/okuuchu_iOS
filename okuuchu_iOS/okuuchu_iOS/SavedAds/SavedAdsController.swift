

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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParent {
            viewModel.viewDidDisappear()
        }
    }
    
    //MARK: - Override methods
    
 
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.searchField.delegate = self
    }

}

//MARK: - Extension

extension SavedAdsController: SavedAdsViewModelOutput {
    
    func customizeOutput(with data: [SubsubtitleViewModel]) {
        collectionViewManager?.setCollectionViewData(data, collectionView: content.collectionView)
    }
}

extension SavedAdsController: SavedAdsCollectionViewDelegate{
    func selectedCell(at indexPath: IndexPath) {
        viewModel.cellTapped(at: indexPath)
    }
}

extension SavedAdsController: UITextFieldDelegate {
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
            viewModel.getSavedAdsDataFromModel()
        }
    }
}
