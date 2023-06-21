
import UIKit

class ReviewsPresentable: BaseView {
    
    struct Navigation {
        let addButton: UIBarButtonItem = .init(title: "Кошуу")
    }
    
    //MARK: - Properties
    
    var navigation: Navigation = .init()
    private var ratingView: RatingView = .init()
    private var ratingLabel: UILabel = .init()
    lazy var tableView: RoundedTableView = .init()
    
    var handleAddButtonTapAction: (() -> Void)?
    
    //MARK: - Override methods
    
    override func onConfigureView() {
        backgroundColor = Asset.secondaryBlueBackground.color
        
        let font = UIFont.systemFont(ofSize: 17)
        let fontDescriptor = font.fontDescriptor.withSymbolicTraits(.traitBold)!

        navigation.addButton.title = "Кошуу"
        navigation.addButton.setTitleTextAttributes([.font: UIFont(descriptor: fontDescriptor, size: font.pointSize)], for: .normal)
        navigation.addButton.tintColor = Asset.darkBlue.color
                
        ratingLabel.font = .systemFont(ofSize: 32)
        
        tableView.register(ReviewCell.self, forCellReuseIdentifier: String(describing: ReviewCell.self))
        
    }
    
    override func onAddSubviews() {
        addSubviews(
            ratingView,
            ratingLabel,
            tableView
        )
    }
    
    override func onSetupConstraints() {
        ratingView.snp.makeConstraints{ maker in
            maker.top.equalTo(safeAreaLayoutGuide.snp.top).offset(25)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(210)
        }
        
        ratingLabel.snp.makeConstraints{ maker in
            maker.top.equalTo(ratingView.snp.bottom).offset(20)
            maker.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{ maker in
            maker.top.equalTo(ratingLabel.snp.bottom).offset(30)
            maker.width.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    override func onSetupTargets() {
        navigation.addButton.target = self
        navigation.addButton.action = #selector(addButtonTapActino)
    }
    
}

//MARK: - Extension

extension ReviewsPresentable {
    func setReviewData(rating: Double, isAddingReviewMode: Bool){
        
        ratingLabel.text = String(rating)
        ratingView.configureWith(rating: rating, spacing: 25, starColor: .black)
        
        if isAddingReviewMode {
            navigation.addButton.isHidden = false
        } else {
            navigation.addButton.isHidden = true
        }
    }
    
    @objc private func addButtonTapActino(){
        handleAddButtonTapAction?()
    }
}
