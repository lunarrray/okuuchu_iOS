
import UIKit

class HorizontalCell: BaseCell<TitleSubtitleViewModel> {
    
    //MARK: - Properties
    
    private let titleLabel: UILabel = .init()
    private let subtitleLabel: UILabel = .init()
    
    //MARK: - Methods
    
    override func onConfigureView(){
        titleLabel.font = .systemFont(ofSize: 13)
        titleLabel.textColor = Asset.normalTextColor.color
        titleLabel.text = "Title"
        
        subtitleLabel.font = .boldSystemFont(ofSize: 13)
        subtitleLabel.textColor = Asset.normalTextColor.color
        subtitleLabel.text = "Subtitle"
    }
    
    override func onAddSubviews(){
        contentView.addSubviews(
            titleLabel,
            subtitleLabel
        )
        
    }
    
    override func onSetupConstraints(){
        titleLabel.snp.makeConstraints{ maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalTo(titleLabel.snp.right).offset(5)
        }
        
    }
    
    override func configureCell(with cellData: TitleSubtitleViewModel){
        
        guard let text = cellData.title else { return }
        titleLabel.text = text + ":"
        subtitleLabel.text = cellData.subtitle
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
    }
}
