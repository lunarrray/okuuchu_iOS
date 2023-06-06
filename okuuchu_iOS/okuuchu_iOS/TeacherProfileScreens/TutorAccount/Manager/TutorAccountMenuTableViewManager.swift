
import UIKit

//MARK: Protocol

protocol TutorAccountMenuTableViewDelegate: AnyObject {
    func selectedMenuItem(_ menuItem: Menu)
}

//MARK: - Class

final class TutorAccountMenuTableViewManager: NSObject {
    weak var delegate: TutorAccountMenuTableViewDelegate?
    private var menuData: [Menu] = [.schedule, .recordedLessons, .reviews, .ads]
}

//MARK: - Extension

extension TutorAccountMenuTableViewManager: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleCell.self), for: indexPath) as? TitleCell else {
            return TitleCell()
        }
        let menuItem = menuData[indexPath.row]
        let cellData = TitleSubtitleViewModel(title: menuItem.title)
        cell.configureCell(with: cellData)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
