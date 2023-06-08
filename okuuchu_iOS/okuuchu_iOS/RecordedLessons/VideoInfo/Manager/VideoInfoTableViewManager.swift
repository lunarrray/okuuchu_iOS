
import UIKit

// MARK: - Class

final class VideoInfoTableViewManager: NSObject {
    
    private var data: [TitleSubtitleViewModel] = []
    
    func setTableViewData(_ data: [TitleSubtitleViewModel], tableView: UITableView){
        self.data = data
        tableView.reloadData()
    }
    
}

// MARK: - Extension

extension VideoInfoTableViewManager: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LabeledTextViewCell.self), for: indexPath) as? LabeledTextViewCell else {
            return LabeledTextViewCell()
        }
        
        let currentData = data[indexPath.row]
        cell.configureCell(with: currentData)
        cell.enableTextViewEditing()
        cell.setTextViewColor(color: Asset.normalTextColor.color)
        cell.selectionStyle = .none

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

