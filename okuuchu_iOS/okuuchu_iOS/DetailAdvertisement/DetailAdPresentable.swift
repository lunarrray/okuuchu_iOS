
import UIKit

final class DetailAdPresentable: BaseView {
    
    //MARK: - Properties
    struct Navigation {
        var saveButton = UIBarButtonItem(image: Asset.saveIcon.image.withTintColor(Asset.darkBlue.color, renderingMode: .alwaysOriginal))
    }
    
    var navigation: Navigation = .init()
    private let imageView: UIImageView = .init()
    private let priceLabel: UILabel = .init()
    private let titleLabel: UILabel = .init()
    private let tutorButton: CellButton = .init()
    lazy var tableView: UITableView = .init()
    private let detailTitle: UILabel = .init()
    private let whatsappButton: UIButton = .init()
    private let telegramButton: UIButton = .init()
    private let separatorView: UIView = .init()
    private let descriptionView: LabeledTextView = .init()
    private let callButton: PrimaryButton = .init()
    
    var handleTutorButtonTapAction: (() -> Void)?
    var handleCallButtonTapAction: (() -> Void)?
    var handleWhatsappTapAction: (() -> Void)?
    var handleTelegramTapAction: (() -> Void)?
    
    //MARK: - Override methods
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color
        
//        imageView.image = Asset.mathImage.image
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        
//        priceLabel.text = "600 сом"
        priceLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.textColor = .black
        
//        titleLabel.text = "Английский язык для начальных классов"
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .black
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(HorizontalCell.self, forCellReuseIdentifier: String(describing: HorizontalCell.self))
        
        detailTitle.text = "Байланышуу:"
        detailTitle.textColor = Asset.normalTextColor.color
        detailTitle.font = .systemFont(ofSize: 13)
        
        whatsappButton.setTitle("whatsapp,", for: .normal)
        whatsappButton.setTitleColor(Asset.darkBlue.color, for: .normal)
        whatsappButton.setTitleColor(Asset.textViewBackground.color, for: .selected)
        whatsappButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
        
        telegramButton.setTitle("telegram", for: .normal)
        telegramButton.setTitleColor(Asset.darkBlue.color, for: .normal)
        telegramButton.setTitleColor(Asset.textViewBackground.color, for: .selected)
        telegramButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
        
        separatorView.backgroundColor = .black.withAlphaComponent(0.15)
        
        descriptionView.nonEditableTextView()
        
        callButton.setTitle("Чалуу", for: .normal)
        callButton.backgroundColor = Asset.primaryButtonsBlue.color
        
    }
    
    override func onAddSubviews() {
        addSubviews(
            imageView,
            priceLabel,
            titleLabel,
            tutorButton,
            tableView,
            detailTitle,
            whatsappButton,
            telegramButton,
            separatorView,
            descriptionView,
            callButton
        )
            
    }
    
    override func onSetupConstraints() {
        imageView.snp.makeConstraints{ maker in
            maker.horizontalEdges.equalToSuperview()
            maker.top.equalTo(safeAreaLayoutGuide.snp.top)
            maker.height.equalTo(260)
        }
        
        priceLabel.snp.makeConstraints{ maker in
            maker.top.equalTo(imageView.snp.bottom).offset(10)
            maker.left.equalToSuperview().offset(15)
        }
        
        titleLabel.snp.makeConstraints{ maker in
            maker.top.equalTo(priceLabel.snp.bottom).offset(5)
            maker.left.equalToSuperview().offset(15)
        }
        
        tutorButton.snp.makeConstraints{ maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(10)
            maker.horizontalEdges.equalToSuperview().inset(15)
            maker.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints{ maker in
            maker.top.equalTo(tutorButton.snp.bottom).offset(15)
            maker.horizontalEdges.equalToSuperview().inset(15)
            maker.height.equalTo(88)
        }
        
        detailTitle.snp.makeConstraints{ maker in
            maker.top.equalTo(tableView.snp.bottom)
            maker.left.equalToSuperview().offset(15)
            maker.height.equalTo(22)
        }
        
        whatsappButton.snp.makeConstraints{ maker in
            maker.left.equalTo(detailTitle.snp.right).offset(5)
            maker.top.equalTo(detailTitle)
            maker.height.equalTo(22)
        }
        
        telegramButton.snp.makeConstraints{ maker in
            maker.left.equalTo(whatsappButton.snp.right).offset(3)
            maker.top.equalTo(whatsappButton)
            maker.height.equalTo(22)
        }
        
        separatorView.snp.makeConstraints{ maker in
            maker.top.equalTo(detailTitle.snp.bottom).offset(5)
            maker.height.equalTo(1)
            maker.horizontalEdges.equalToSuperview()
        }
        
        descriptionView.snp.makeConstraints{ maker in
            maker.top.equalTo(separatorView.snp.bottom).offset(5)
            maker.horizontalEdges.equalToSuperview().inset(15)
        }
        
        callButton.snp.makeConstraints{ maker in
            maker.bottom.equalToSuperview().offset(-35)
            maker.horizontalEdges.equalToSuperview().inset(15)
            maker.height.equalTo(60)
        }
        
    }
    
    override func onSetupTargets() {
        tutorButton.addTarget(self, action: #selector(tutorButtonTapAction), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(callButtonTapAction), for: .touchUpInside)
        whatsappButton.addTarget(self, action: #selector(whatsappTapAction), for: .touchUpInside)
        telegramButton.addTarget(self, action: #selector(telegramTapAction), for: .touchUpInside)
    }

}

//MARK: - Extension

extension DetailAdPresentable {
    func setContentData(image: UIImage, priceText: String, titleText: String, tutorText: String, tutorImage: UIImage, descriptionText: String) {
        
        imageView.image = image
        priceLabel.text = priceText
        titleLabel.text = titleText
        
        tutorButton.configureCellButtonWith(image: tutorImage, titleText: tutorText)
        
        descriptionView.configureWith(TitleSubtitleViewModel(title: "Маалымат", subtitle: descriptionText))
    }
    
    @objc private func tutorButtonTapAction(){
        handleTutorButtonTapAction?()
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
