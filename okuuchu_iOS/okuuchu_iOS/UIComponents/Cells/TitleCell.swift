
import UIKit

class TitleCell: BaseCell<CellData> {
    
    //MARK: - Properties
    
    var titleLabel: UILabel = .init()
    
    //MARK: - Methods
    
    override func onConfigureView(){
        titleLabel.font = .systemFont(ofSize: 16)
    }
    
    override func onAddSubviews(){
        contentView.addSubview(titleLabel)
    }
    
    override func onSetupConstraints(){
        titleLabel.snp.makeConstraints{ maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(25)
        }
    }
    
    override func configureCell(with cellData: CellData){
        titleLabel.text = cellData.title
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
    }
}
