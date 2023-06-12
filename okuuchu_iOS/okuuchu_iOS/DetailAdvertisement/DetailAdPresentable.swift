
import UIKit

final class DetailAdPresentable: BaseView {
    
    //MARK: - Properties
    struct Navigation {
        var saveButton = UIBarButtonItem(image: Asset.saveIcon.image.withTintColor(Asset.darkBlue.color, renderingMode: .alwaysOriginal))
    }
    
    var navigation: Navigation = .init()
    private let imageView: UIImageView = .init()
    private let priceLabel: UILabel = .init()
    private let titleLabel: UILabel = .init()
    
    //MARK: - Override methods
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color
        
        imageView.image = Asset.mathImage.image
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        
        priceLabel.text = "600 сом"
        priceLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.textColor = .black
        
        titleLabel.text = "Английский язык для начальных классов"
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .black
    }
    
    override func onAddSubviews() {
        addSubviews(
            imageView,
            priceLabel,
            titleLabel
        )
            
    }
    
    override func onSetupConstraints() {
        imageView.snp.makeConstraints{ maker in
            maker.horizontalEdges.equalToSuperview()
            maker.top.equalTo(safeAreaLayoutGuide.snp.top)
            maker.height.equalTo(260)
        }
        
        priceLabel.snp.makeConstraints{ maker in
            maker.top.equalTo(imageView.snp.bottom).offset(10)
            maker.left.equalToSuperview().offset(15)
        }
        
        titleLabel.snp.makeConstraints{ maker in
            maker.top.equalTo(priceLabel.snp.bottom).offset(5)
            maker.left.equalToSuperview().offset(15)
        }
        
        
    }

}

//MARK: - Extension
