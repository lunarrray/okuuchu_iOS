
import UIKit

class RectangleImageView: UIView {
    let imageView: UIImageView = .init()
    let button: UIButton = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        onSetupSubviews()
        onSetupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onSetupSubviews(){
//        backgroundColor = .white
//        imageView.image = Asset.neutralAvatarIcon.image.withTintColor(Asset.white.color, renderingMode: .alwaysOriginal)
        imageView.backgroundColor = Asset.white.color
        imageView.layer.borderColor = Asset.darkBlue.color.cgColor
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        
        button.setImage(Asset.cameraIcon.image, for: .normal)
//        button.isHidden = true
        button.addShadow()

        addSubview(button)
    }
    
    func onSetupConstraints(){
        imageView.snp.makeConstraints { maker in
            maker.horizontalEdges.equalToSuperview().inset(10)
            maker.verticalEdges.equalToSuperview().inset(10)
        }
        let size = bounds.size.width / 3
        button.snp.makeConstraints{ maker in
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.width.equalTo(size)
            maker.height.equalTo(size)
        }
    }

//    func activateCameraButton(){
//        button.isHidden = false
//    }
    
    func configureWith(_ image: UIImage) {
        imageView.image = image
        imageView.layer.borderWidth = 0
        imageView.backgroundColor = .clear
    }
}
