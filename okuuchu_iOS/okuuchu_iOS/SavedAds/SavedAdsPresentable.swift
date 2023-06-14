
import UIKit

class SavedAdsPresesntable: BaseView {
    
    //MARK: - Properties
    
    var searchField: SearchTextField = .init()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collectionView
    }()
        
    //MARK: - OverrideMethods
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color
        
        searchField.returnKeyType = .search

        let view = PrimaryView()
        view.backgroundColor = Asset.primaryGrayBackground.color
        view.addWalkingGirlImage()
        collectionView.backgroundView = view
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionViewCell.self))

        
    }
    
    override func onAddSubviews() {
        addSubviews(
            searchField,
            collectionView
        )
    }
    
    override func onSetupConstraints() {
     
        searchField.snp.makeConstraints{ maker in
            maker.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.height.equalTo(32)
        }
        
        collectionView.snp.makeConstraints{ maker in
            maker.top.equalTo(searchField.snp.bottom).offset(10)
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.bottom.equalToSuperview()
            
        }
 
    }
    
    override func onSetupTargets() {

    }
}


