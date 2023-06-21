
import UIKit

final class TutorAccountPresentable: PrimaryView {
    
    //MARK: - Properties

    private let scrollView: UIScrollView = .init()
    private var avatarImageView: RoundedImageView = .init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    private var ratingView: RatingView = .init()
    lazy var tutorInfoTableView: UITableView = .init()
    private var stackView: UIStackView = .init()
    private var contactLabel: UILabel = .init()
    private var whatsappButton: UIButton = .init()
    private var telegramButton: UIButton = .init()
    lazy var menuTableView: RoundedTableView = .init()
    private var callButton: PrimaryButton = .init()
    
    var handleCallButtonTapAction: (() -> Void)?
    var handleWhatsappTapAction: (() -> Void)?
    var handleTelegramTapAction: (() -> Void)?
    
    //MARK: - Override methods
    
    override func onConfigureView() {
        super.onConfigureView()
        super.setBlueWithLeftTopBalls()
        
        avatarImageView.imageView.clipsToBounds = true
        
        tutorInfoTableView.separatorStyle = .none
        tutorInfoTableView.backgroundColor = .clear
        tutorInfoTableView.layer.borderWidth = 0.5
        tutorInfoTableView.layer.borderColor = Asset.normalTextColor.color.withAlphaComponent(0.3).cgColor
        tutorInfoTableView.layer.cornerRadius = 10
        tutorInfoTableView.register(LabeledTextViewCell.self, forCellReuseIdentifier: String(describing: LabeledTextViewCell.self))
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        
        contactLabel.text = "Байланышуу:"
        contactLabel.font = .systemFont(ofSize: 14)
        contactLabel.textColor = Asset.normalTextColor.color
        
        whatsappButton.setTitle("whatsapp,", for: .normal)
        whatsappButton.setTitleColor(Asset.darkBlue.color, for: .normal)
        whatsappButton.setTitleColor(Asset.textViewBackground.color, for: .selected)
        whatsappButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        telegramButton.setTitle("telegram", for: .normal)
        telegramButton.setTitleColor(Asset.darkBlue.color, for: .normal)
        telegramButton.setTitleColor(Asset.textViewBackground.color, for: .selected)
        telegramButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        menuTableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))
        
        callButton.backgroundColor = Asset.darkBlue.color
        callButton.setTitle("Чалуу", for: .normal)
        
    }
    
    override func onAddSubviews() {
        super.onAddSubviews()
                
        addSubviews(
            avatarImageView,
            ratingView,
            tutorInfoTableView,
            stackView,
            menuTableView,
            callButton
        )
        
        stackView.addArrangedSubviews(
            contactLabel,
            whatsappButton,
            telegramButton
        )
    }
    
    override func onSetupConstraints() {
        super.onSetupConstraints()
        
        avatarImageView.snp.makeConstraints{ maker in
            maker.width.equalTo(100)
            maker.height.equalTo(100)
            maker.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            maker.centerX.equalToSuperview()
        }
        
        
        ratingView.snp.makeConstraints{ maker in
            maker.top.equalTo(avatarImageView.snp.bottom).offset(20)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(200)
        }
        
        tutorInfoTableView.snp.makeConstraints{ maker in
            maker.top.equalTo(ratingView.snp.bottom).offset(10)
            maker.horizontalEdges.equalToSuperview().inset(10)
            maker.height.equalTo(250)
        }
        
        stackView.snp.makeConstraints{ maker in
            maker.top.equalTo(tutorInfoTableView.snp.bottom).offset(10)
            maker.horizontalEdges.equalToSuperview().inset(60)
        }
        
        menuTableView.snp.makeConstraints{ maker in
            maker.top.equalTo(stackView.snp.bottom).offset(10)
            maker.horizontalEdges.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        callButton.snp.makeConstraints { maker in
            maker.height.equalTo(60)
            maker.horizontalEdges.equalToSuperview().inset(30)
            maker.bottom.equalToSuperview().offset(-30)
        }
    }
    
    override func onSetupTargets() {
        callButton.addTarget(self, action: #selector(callButtonTapAction), for: .touchUpInside)
        whatsappButton.addTarget(self, action: #selector(whatsappTapAction), for: .touchUpInside)
        telegramButton.addTarget(self, action: #selector(telegramTapAction), for: .touchUpInside)
    }

    
}

//MARK: - Extension

extension TutorAccountPresentable {
    func setTutorData(image: UIImage, rating: Double){
        avatarImageView.imageView.image = image
        ratingView.configureWith(rating: rating, spacing: 25, starColor: Asset.normalTextColor.color)
    }
    
    @objc private func callButtonTapAction() {
        handleCallButtonTapAction?()
    }
    
    @objc private func whatsappTapAction() {
        handleWhatsappTapAction?()
    }
    
    @objc private func telegramTapAction() {
        handleTelegramTapAction?()
    }
    
}
