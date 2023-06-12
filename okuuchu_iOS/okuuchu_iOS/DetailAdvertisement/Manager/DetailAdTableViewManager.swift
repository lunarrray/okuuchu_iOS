
import UIKit

//MARK: - Class

final class DetailAdTableViewManager: NSObject {
    private var cellData: [TitleSubtitleViewModel] = []
    
    func setData(_ data: [TitleSubtitleViewModel], tableView: UITableView) {
        self.cellData = data
        tableView.reloadData()
    }
}

//MARK: - Extension

extension DetailAdTableViewManager: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = cellData[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HorizontalCell.self), for: indexPath) as? HorizontalCell else {
            return HorizontalCell()
        }
        cell.configureCell(with: data)
        
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 22
    }
}
