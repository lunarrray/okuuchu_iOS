
import UIKit

class PullDownOverlayView: BaseView {
    
    //MARK: - Properties

    let button: UIButton = .init()
    
    //MARK: - Override methods
    
    override func onConfigureView() {
        backgroundColor = .darkGray
        layer.cornerRadius = 10
        
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.white, for: .normal)
    }
    
    override func onAddSubviews() {
        addSubview(button)
    }
    
    override func onSetupConstraints() {
        button.snp.makeConstraints{ maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
    }
 
    override func onSetupTargets() {
        
    }
}
