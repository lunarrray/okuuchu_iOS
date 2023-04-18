
import UIKit

class MainTextField: UITextField {
    
    private let eyeIcon: UIImageView = .init()
    private var eyeOpened = true
    
    // MARK: - Properties
    
//    private var insets: UIEdgeInsets =
//                        UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
//    
    
    // MARK: - Methods
    
    
    
    private func configure() {
        backgroundColor = Asset.white.color
        tintColor = Asset.normalTextColor.color
        layer.cornerRadius = 30
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
     
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func passwordModeActivate(){
        eyeIcon.image = Asset.visibleIcon.image
        let contentView = UIView()
        contentView.addSubview(eyeIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: eyeIcon.image!.size.width * 2, height: eyeIcon.image?.size.height ?? .zero)
        eyeIcon.frame = CGRect(x: 0, y: 0, width: eyeIcon.image?.size.width ?? .zero, height: eyeIcon.image?.size.height ?? .zero)
        
        rightView = contentView
        rightViewMode = .always
        isSecureTextEntry = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(eyeIconTapped(tapGestureRecognizer:)))
        eyeIcon.isUserInteractionEnabled = true
        eyeIcon.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func eyeIconTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if eyeOpened{
            eyeOpened = false
            tappedImage.image = Asset.invisibleIcon.image
            isSecureTextEntry = false
        } else {
            eyeOpened = true
            tappedImage.image = Asset.visibleIcon.image
            isSecureTextEntry = true
        }
    }
    
}

