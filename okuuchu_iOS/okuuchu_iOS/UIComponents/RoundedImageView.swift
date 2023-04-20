
import UIKit

class RoundedImageView: UIView {
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
        imageView.layer.cornerRadius = min(bounds.width, bounds.height) / 2.0
        imageView.layer.masksToBounds = true
        addSubview(imageView)
        
        button.setImage(Asset.cameraIcon.image, for: .normal)
        addSubview(button)
    }
    
    func onSetupConstraints(){
        imageView.snp.makeConstraints { maker in
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        let size = bounds.size.width / 3
        button.snp.makeConstraints{ maker in
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.width.equalTo(size)
            maker.height.equalTo(size)
        }
    }
    
//    private let cameraButton: UIButton = .init(type: .custom)
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.cornerRadius = min(bounds.width, bounds.height) / 2.0
//        layer.masksToBounds = true
//
//        cameraButton.setImage(Asset.cameraIcon.image, for: .normal)
//        cameraButton.frame = CGRect(x: bounds.width, y: bounds.height, width: 40, height: 40)
//        addSubview(cameraButton)
//        bringSubviewToFront(cameraButton)
//
////        cameraButton.snp.makeConstraints{ maker in
////            maker.right.equalToSuperview()
////            maker.bottom.equalToSuperview()
////        }
////        cameraButton.isHidden = true
//    }
//
//
//    func activateCamera(){
//        cameraButton.isHidden = false
//    }
}
