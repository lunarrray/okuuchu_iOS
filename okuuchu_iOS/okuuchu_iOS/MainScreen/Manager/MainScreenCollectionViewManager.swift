
import UIKit

//MARK: - Protocol

protocol MainScreenCollectionViewDelegate: AnyObject {
    
}

//MARK: - Class
final class MainScreenCollectionViewManager: NSObject {
    
    weak var delegate: MainScreenCollectionViewDelegate?
    
    private var adsData: [SubsubtitleViewModel] = []
    func setCollectionViewData(_ adsData: [SubsubtitleViewModel], collectionView: UICollectionView) {
        self.adsData = adsData
        collectionView.reloadData()
    }
}


//MARK: - Extension

extension MainScreenCollectionViewManager: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = 178
        let spacing: CGFloat = 3
        let stackViewHeight: CGFloat = 64

        return CGSize(width: width, height: (width + spacing * 5 + stackViewHeight))
    }
}


