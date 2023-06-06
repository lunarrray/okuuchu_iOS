
import UIKit

class VideoListPresentable: BaseView {
    
    //MARK: - Properties
 
    var searchField: SearchTextField = .init()
    lazy var tableView: UITableView = .init()

    //MARK: - Override methods
    
    override func onConfigureView() {
        backgroundColor = Asset.primaryGrayBackground.color

        searchField.returnKeyType = .search

        tableView.register(TitleSubtitleCell.self, forCellReuseIdentifier: String(describing: TitleSubtitleCell.self))
    }
    
    override func onAddSubviews() {
        addSubviews(
            searchField,
            tableView
        )
    }
    
    override func onSetupConstraints() {
        searchField.snp.makeConstraints{ maker in
            maker.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            maker.horizontalEdges.equalToSuperview().inset(20)
            maker.height.equalTo(32)
        }
        
        tableView.snp.makeConstraints{ maker in
            maker.top.equalTo(searchField.snp.bottom).offset(20)
            maker.horizontalEdges.equalToSuperview().inset(15)
            maker.bottom.equalToSuperview()
        }

    }
    
}

//MARK: - Extension

