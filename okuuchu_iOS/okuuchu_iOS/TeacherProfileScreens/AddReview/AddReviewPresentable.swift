
import UIKit

class AddReviewPresentable: PrimaryView {
    
    //MARK: - Properties
    
    struct Navigation {
        let cancelButton: UIBarButtonItem = .init(image: Asset.cancelIcon.image.withTintColor(Asset.normalTextColor.color, renderingMode: .alwaysOriginal))
    }
    
    let navigation: Navigation = .init()
    private var buttons: [UIButton] = .init()
    private var starsStackView: UIStackView = .init()
    var logo: UIImageView = .init()
    let reviewTextView: LabeledTextView = .init()
    private let addButton: PrimaryButton = .init()
    
    private let dismissKeyboardTap: UITapGestureRecognizer = .init()


    var handleCancelButtonTapAction: (() -> Void)?
    var handleStarButtonTapAction: ((_: String) -> Void)?
    var handleAddButtonTapAction: (() -> Void)?
    
    //MARK: - Override Methods

    override func onConfigureView() {
        super.onConfigureView()
        
        setGrayWithLeftTopBalls()
        
        starsStackView.axis = .horizontal
        starsStackView.distribution = .fillEqually
        starsStackView.alignment = .fill
        starsStackView.spacing = 10
        
        for i in 0..<5 {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
            button.imageView?.contentMode = .scaleAspectFit
            button.setImage(Asset.emtyStarIcon.image.withTintColor(Asset.darkBlue.color), for: .normal)
            button.setTitle("\(i)", for: .normal)
            button.setTitleColor(.clear, for: .normal)
            button.setTitleColor(.clear, for: .selected)

            buttons.append(button)
        }
        
        reviewTextView.configureWith(TitleSubtitleViewModel(title: "Пикир жазыңыз"))
        logo.image = Asset.logoWithoutLabel.image
        
        addButton.setTitle("Кошуу", for: .normal)
        addButton.backgroundColor = Asset.primaryButtonsBlue.color
    }
    
    override func onAddSubviews() {
        super.onAddSubviews()
        
        addSubviews(
            starsStackView,
            reviewTextView,
            logo,
            addButton
        )
        
        for button in buttons {
            starsStackView.addArrangedSubview(button)
            button.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
        
        addGestureRecognizer(dismissKeyboardTap)

    }
    
    override func onSetupConstraints() {
        super.onSetupConstraints()
        
        starsStackView.snp.makeConstraints{ maker in
            maker.top.equalTo(safeAreaLayoutGuide.snp.top).offset(100)
            maker.horizontalEdges.equalToSuperview().inset(60)
            maker.height.equalTo(50)
        }
        
        reviewTextView.snp.makeConstraints{ maker in
            maker.top.equalTo(starsStackView.snp.bottom).offset(30)
            maker.left.right.equalToSuperview().inset(40)
        }
        
        logo.snp.makeConstraints{ maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(addButton.snp.top).offset(-40)
        }
        
        addButton.snp.makeConstraints{ maker in
            maker.bottom.equalToSuperview().offset(-40)
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.height.equalTo(70)
        }
    }
    
    override func onSetupTargets() {
        navigation.cancelButton.target = self
        navigation.cancelButton.action = #selector(cancelButtonTapAction)
        
        for button in buttons {
            button.addTarget(self, action: #selector(starButtonTapAction), for: .touchUpInside)
        }
        
        addButton.addTarget(self, action: #selector(addButtonTapAction), for: .touchUpInside)
        
        dismissKeyboardTap.addTarget(self, action: #selector(viewTapped(_: )))

    }
    
}

//MARK: - Extension

extension AddReviewPresentable {
    @objc func cancelButtonTapAction(){
        handleCancelButtonTapAction?()
    }
    
    @objc func starButtonTapAction(sender: UIButton){
        if let index = sender.titleLabel?.text {
            handleStarButtonTapAction?(index)
        }
    }
    
    @objc func addButtonTapAction(){
        handleAddButtonTapAction?()
    }
    
    func rateTutor(with assesment: Int) {
        for (i, button) in buttons.enumerated() {
            if i < assesment {
                button.setImage(Asset.fullStarIcon.image.withTintColor(Asset.darkBlue.color, renderingMode: .alwaysOriginal), for: .normal)
            } else {
                button.setImage(Asset.emtyStarIcon.image.withTintColor(Asset.darkBlue.color, renderingMode: .alwaysOriginal), for: .normal)
            }
        }
    }
    
    @objc private func viewTapped(_ recognizer: UITapGestureRecognizer) {
        endEditing(true)
    }
    
}
