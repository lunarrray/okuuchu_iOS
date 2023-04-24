
import UIKit

class LabeledView: UIView {
    var titleLabel: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        onConfigureView()
        onAddSubviews()
        onSetupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onConfigureView(){
        
        titleLabel.text = "Title"
        titleLabel.font = .systemFont(ofSize: 13)
        titleLabel.textAlignment = .left
        titleLabel.textColor = Asset.normalTextColor.color
    }
    
    func onAddSubviews(){
        addSubview(titleLabel)
    }
    
    func onSetupConstraints(){
        titleLabel.snp.makeConstraints{ maker in
            maker.top.equalToSuperview()
            maker.left.equalToSuperview()
        }
    }
    
    func configureWith(_ title: String){
        titleLabel.text = title
    }
    
}
