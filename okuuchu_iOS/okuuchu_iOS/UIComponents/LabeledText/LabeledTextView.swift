
import UIKit

class LabeledTextView: LabeledView {
    var textView: UITextView = .init()
    
    override func onConfigureView(){
        super.onConfigureView()
        textView.layer.cornerRadius = 10
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 15)
        textView.textContainerInset = .zero
        textView.textAlignment = .center
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
    override func onAddSubviews(){
        super.onAddSubviews()
        addSubview(textView)
    }
    
    override func onSetupConstraints(){
        super.onSetupConstraints()
        textView.snp.makeConstraints{ maker in
            maker.top.equalTo(super.titleLabel.snp.bottom).offset(10)
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    func configureWith(_ data: LabelAndTextData, textBackgroundColor: UIColor = Asset.white.color){
        
        super.configureWith(data.title)
        textView.backgroundColor = textBackgroundColor
        textView.text = data.text
    }
}

//extension LabeledView: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//        let fixedWidth = textView.frame.width
//        let newSize =  textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//        textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
//    }
//}
