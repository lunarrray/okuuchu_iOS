
import UIKit

//MARK: - Protocol

protocol SavedAdsCollectionViewDelegate: AnyObject {
    
    func selectedCell(at indexPath: IndexPath)
}

//MARK: - Class
final class SavedAdsCollectionViewManager: NSObject {
    
    weak var delegate: SavedAdsCollectionViewDelegate?
    
    private var adsData: [SubsubtitleViewModel] = []
    func setCollectionViewData(_ adsData: [SubsubtitleViewModel], collectionView: UICollectionView) {
        self.adsData = adsData
        collectionView.reloadData()
    }
}


//MARK: - Extension

extension SavedAdsCollectionViewManager: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCollectionViewCell.self), for: indexPath) as? ImageCollectionViewCell else {
            return ImageCollectionViewCell()
        }
        
        let advertisement = adsData[indexPath.row]
                
        cell.configureCell(with: advertisement)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.selectedCell(at: indexPath)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = 178
        let spacing: CGFloat = 3
        let stackViewHeight: CGFloat = 64

        return CGSize(width: width, height: (width + spacing * 5 + stackViewHeight))
    }
}


