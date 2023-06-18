
import UIKit

class MainScreenPresentable: BaseView {
    
    //MARK: - Properties
    
    var searchField: SearchTextField = .init()
    
    private var segmentedControl: CustomSegmentedControl = {
        let segmentedControl = CustomSegmentedControl(items: ["Объявления", "Репетиторы"])
        segmentedControl.contentVerticalAlignment = .center
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collectionView
    }()
        
    var handleSegmentedControlValueChanged: (() -> Void)?
    
    //MARK: - OverrideMethods
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color
        
        searchField.returnKeyType = .search
        
        segmentedControl.selectedSegmentTintColor = Asset.darkBlue.color
        fixBackgroundSegmentControl(segmentedControl)

        for _ in 0..<segmentedControl.numberOfSegments {
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        }
    
        let view = PrimaryView()
        view.backgroundColor = Asset.primaryGrayBackground.color
        view.addWalkingGirlImage()
        collectionView.backgroundView = view
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = true
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionViewCell.self))

        
    }
    
    override func onAddSubviews() {
        addSubviews(
            searchField,
            segmentedControl,
            collectionView
        )
    }
    
    override func onSetupConstraints() {
        
        searchField.snp.makeConstraints{ maker in
            maker.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.height.equalTo(32)
        }
        
        segmentedControl.snp.makeConstraints{ maker in
            maker.top.equalTo(searchField.snp.bottom).offset(10)
            maker.horizontalEdges.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints{ maker in
            maker.top.equalTo(segmentedControl.snp.bottom).offset(10)
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.bottom.equalToSuperview()
            
        }
 
    }
    
    override func onSetupTargets() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
}

//MARK: - Extension

extension MainScreenPresentable {
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl){
        searchField.text = ""
        handleSegmentedControlValueChanged?()
    }
}


//MARK: - Extension

