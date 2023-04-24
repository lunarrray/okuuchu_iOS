//    
//import UIKit
//
//class LabeledTextField: LabeledView {
//    var textField: UITextField = .init()
//    var addButton: UIButton = .init()
//    var switchControl: UISwitch = .init()
//    
//    
//    override func onConfigureView(){
//        
//        textField.textAlignment = .center
//        
//        addButton.setImage(Asset.addIcon.image, for: .normal)
//        
//        switchControl.backgroundColor = Asset.white.color
//        switchControl.onTintColor = Asset.secondaryBlueBackground.color
//        switchControl.onImage = Asset.visibleIcon.image
//        switchControl.offImage = Asset.invisibleIcon.image
//        
//        addButton.isHidden = true
//        switchControl.isHidden = true
//        
//    }
//    
//    override func onAddSubviews(){
//        addSubviews(
//            textField,
//            addButton,
//            switchControl
//        )
//    }
//    
//    override func onSetupConstraints(){
//        
//        textField.snp.makeConstraints{ maker in
//            maker.top.equalTo(titleLabel.snp.bottom).offset(10)
//            maker.width.equalTo(snp.width)
//        }
//    }
//    
//  
//    
//    func configureWith(_ data: LabelAndTextData, textBackgroundColor: UIColor = Asset.white.color){
//        
//        super.configureWith(data.title)
//        textField.backgroundColor = textBackgroundColor
//        
//        if let textFieldText = data.text {
//            textField.text = textFieldText
//        }
//        switch data.type {
//        case .usual:
//            print("usual")
//        case .withAddButton:
//            print("withAddButton")
//        case .withSwitch:
//            print("withSwitch")
//        case .variations:
//            print("variations")
//            
//        case .bigText:
//            
//            textField.issc
//        }
//    }
//    
//}
