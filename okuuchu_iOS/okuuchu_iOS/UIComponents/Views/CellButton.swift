
import UIKit

class CellButton: UIButton {
    
    private var roundedImageView: RoundedImageView = .init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    private var title: UILabel = .init()
    private var disclosureIndicator: UIImageView = .init(frame: CGRect(x: 0, y: 0, width: 10, height: 15))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        onConfigureView()
        onAddSubviews()
        onSetupContraints()
    }
    
    func onConfigureView() {
//        roundedImageView.configureWith(Asset.womenAvatar.image)
        roundedImageView.clipsToBounds = true
        
        backgroundColor = .white
        title.font = .boldSystemFont(ofSize: 15)
        title.textColor = Asset.normalTextColor.color
//        title.text = "Мария Иванова"
        layer.cornerRadius = 15
        
        disclosureIndicator.image = Asset.disclosureIcon.image.withTintColor(Asset.textGrayColor.color, renderingMode: .alwaysOriginal)
        addShadow()
    }
    
    
    private func onAddSubviews() {
        addSubviews(
            roundedImageView,
            title,
            disclosureIndicator
        )

    }
    
    private func onSetupContraints() {
        roundedImageView.snp.makeConstraints{ maker in
            maker.left.equalToSuperview().offset(10)
            maker.centerY.equalToSuperview()
            maker.width.height.equalTo(50)
        }

        title.snp.makeConstraints{ maker in
            maker.centerY.equalToSuperview()
            maker.left.equalTo(roundedImageView.snp.right).offset(10)
        }
        
        disclosureIndicator.snp.makeConstraints{ maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().offset(-15)
        }
    }
    
    func configureCellButtonWith(image: UIImage, titleText: String) {
        roundedImageView.configureWith(image)
        title.text = titleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
