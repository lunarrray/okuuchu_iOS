
import UIKit

final class VideoInfoPresentable: BaseView {
    
    //MARK: - Properties
    
    private let viewTutorButton: UIButton = .init()
    private let watchVideoButton: PrimaryButton = .init()
    private let imageView: UIImageView = .init()
    let tableView: UITableView = .init()
    
    var handleWatchVideoButtonTapAction: (() -> Void)?
    var handleViewTutorButtonTapAction: (() -> Void)?

    //MARK: - Override Methods
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color
        
        viewTutorButton.setTitleColor(Asset.textButton.color, for: .normal)
        viewTutorButton.setTitle("Репетитордун профилин көрүү", for: .normal)
        viewTutorButton.titleLabel?.textAlignment = .center
        viewTutorButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        watchVideoButton.setTitle("Видео-сабак көрүү", for: .normal)
        watchVideoButton.backgroundColor = Asset.primaryButtonsBlue.color
        
        imageView.image = Asset.videoPublishing.image
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        let view = UIView()
        view.backgroundColor = Asset.primaryGrayBackground.color
        tableView.backgroundView = view
        tableView.register(LabeledTextViewCell.self, forCellReuseIdentifier: String(describing: LabeledTextViewCell.self))

    }

    override func onAddSubviews() {
        addSubviews(
            watchVideoButton,
            viewTutorButton,
            imageView,
            tableView
        )
    }
    
    override func onSetupConstraints() {
        
        viewTutorButton.snp.makeConstraints{ maker in
            maker.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
            maker.horizontalEdges.equalToSuperview().inset(40)
        }
        
        watchVideoButton.snp.makeConstraints { maker in
            maker.bottom.equalTo(viewTutorButton.snp.top).offset(-20)
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.height.equalTo(60)
        }
        
        imageView.snp.makeConstraints { maker in
            maker.bottom.equalTo(watchVideoButton.snp.top).offset(-30)
            maker.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{ maker in
            maker.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            maker.horizontalEdges.equalToSuperview().inset(10)
            maker.bottom.equalTo(imageView.snp.top).offset(20)
        }
        
    }
    
    override func onSetupTargets() {
        viewTutorButton.addTarget(self, action: #selector(viewTutorButtonTapAction), for: .touchUpInside)
        watchVideoButton.addTarget(self, action: #selector(watchVideoButtonTapAction), for: .touchUpInside)
    }
    
}

//MARK: - Extension

extension VideoInfoPresentable {
    @objc func watchVideoButtonTapAction(){
        handleWatchVideoButtonTapAction?()
    }

    @objc func viewTutorButtonTapAction(){
        handleViewTutorButtonTapAction?()
    }
}
