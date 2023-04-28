
import UIKit

protocol TeacherProfileTableViewDelegate: AnyObject {
    func selectedCell()
}

class TeacherProfileTableViewManager: NSObject {
    weak var delegate: TeacherProfileTableViewDelegate?
    private var tableViewData: [CellData] = []
    
    
    func setData(_ cellData: [CellData], tableView: RoundedTableView){
        self.tableViewData = cellData
        tableView.reloadData()
    }
}

extension TeacherProfileTableViewManager: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleCell.self), for: indexPath) as? TitleCell else { return TitleCell() }

        cell.configureCell(with: tableViewData[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            delegate?.selectedCell()
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
