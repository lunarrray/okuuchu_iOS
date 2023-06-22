
import UIKit
import Foundation
import SnapKit

class LabeledTextViewCell: BaseCell<TitleSubtitleViewModel> {
    
    //MARK: - Properties
    
    private let labeledView: LabeledTextView = .init()
    private var textViewHeightConstraint: Constraint?
    private let button: UIButton = .init()
    private var withButton: Bool = false {
        didSet {
            if withButton {
                button.isHidden = false
            } else {
                button.isHidden = true
            }
        }
    }
    
    private let datePickerView: UIDatePicker = .init()
    private let toolBar: UIToolbar = .init(frame: .init(x: 0, y: 0, width: 100, height: 35))
    lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(image: Asset.doneIcon.image.withTintColor(Asset.normalTextColor.color, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(doneButtonTapped))
    }()
    private var viewModel: TitleSubtitleViewModel?
    
    //MARK: - Methods
    override func onConfigureView() {
        
//        labeledView.textView.delegate = self
        labeledView.configureTextView(insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), cornerRadius: 5)
        
//        button.setImage(Asset.addIcon.image.withTintColor(Asset.lightBlue.color, renderingMode: .alwaysOriginal), for: .normal)
        button.isHidden = true
        
        toolBar.setItems([doneButton], animated: false)
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .date
        datePickerView.backgroundColor = .white
        
    }
    
    override func onAddSubviews() {
        contentView.addSubviews(labeledView, button)
    }
    
    override func onSetupConstraints() {
  
        labeledView.snp.remakeConstraints{ maker in
            maker.top.equalToSuperview().offset(20)
            maker.left.right.equalToSuperview().inset(25)
            maker.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints{ maker in
            maker.right.equalToSuperview().offset(-25)
            maker.bottom.equalTo(labeledView.snp.bottom)
            maker.width.height.equalTo(30)
        }
    }
    

    override func onSetupTargets() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        withButton = false
        contentView.backgroundColor = .clear
    }
    
    func configureCell(with cellData: TitleSubtitleViewModel, textViewBackgroundColor: UIColor = Asset.white.color){
        
        self.viewModel = cellData
        
        switch cellData.subTextType {
        case .selectingSeveral:
            button.setImage(Asset.addIcon.image.withTintColor(Asset.lightBlue.color, renderingMode: .alwaysOriginal), for: .normal)
            labeledView.nonEditableTextView()
            activateButton()
        case .selectingOne:
            button.setImage(Asset.selectIcon.image.withTintColor(Asset.lightBlue.color, renderingMode: .alwaysOriginal), for: .normal)
            labeledView.nonEditableTextView()
            activateButton()
        case .phoneNumber:
            labeledView.textView.keyboardType = .phonePad
        case .date:
            labeledView.textView.inputView = datePickerView
            labeledView.textView.inputAccessoryView = toolBar
        case .decimal:
            labeledView.textView.keyboardType = .decimalPad
        default: break
        }
        
        labeledView.configureWith(cellData, textBackgroundColor: textViewBackgroundColor)
        
    }
    
    override func configureCell(with cellData: TitleSubtitleViewModel) {
        self.viewModel = cellData

        switch cellData.subTextType {
        case .selectingSeveral:
            button.setImage(Asset.addIcon.image.withTintColor(Asset.lightBlue.color, renderingMode: .alwaysOriginal), for: .normal)
            labeledView.nonEditableTextView()
            activateButton()
        case .selectingOne:
            button.setImage(Asset.selectIcon.image.withTintColor(Asset.lightBlue.color, renderingMode: .alwaysOriginal), for: .normal)
            labeledView.nonEditableTextView()
            activateButton()
        case .phoneNumber:
            labeledView.textView.keyboardType = .phonePad
        case .date:
            labeledView.textView.inputView = datePickerView
            labeledView.textView.inputAccessoryView = toolBar
        default: break
        }

        labeledView.configureWith(cellData)

    }

}

//MARK: - Extension

extension LabeledTextViewCell {
    func activateButton(){
        button.isHidden = false
        
        labeledView.snp.remakeConstraints{ maker in
            maker.top.equalToSuperview().offset(20)
            maker.left.equalToSuperview().offset(25)
            maker.right.equalTo(button.snp.left).offset(-10)
            maker.bottom.equalToSuperview()
        }
    }
    
    func setTextViewDelegate(delegate: UITextViewDelegate) {
        labeledView.setTextViewDelegate(delegate: delegate)
    }
    
    @objc private func doneButtonTapped(){
        
    }
    
    @objc private func buttonTapped(){
        viewModel?.onCellUpdate?()
    }
    
    func setHeightConstraint(newConstraint: ConstraintOffsetTarget){
        textViewHeightConstraint?.update(offset: newConstraint)
    }
    
    func enableTextViewEditing(){
        labeledView.textView.isUserInteractionEnabled = true
    }
    
    func nonEditableTextView(){
        labeledView.nonEditableTextView()
    }
    
    func setTextViewColor(color: UIColor){
        labeledView.textView.textColor = color
    }
    

}

