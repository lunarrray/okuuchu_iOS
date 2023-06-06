
import UIKit

//MARK: - Class

final class TutorAccountTutorInfoTableViewManager: NSObject {
    private var tutorData: [TitleSubtitleViewModel] = []
    
    func setTutorData(_ data: [TitleSubtitleViewModel], tableView: UITableView) {
        self.tutorData = data
        tableView.reloadData()
    }
}

//MARK: - Extension

extension TutorAccountTutorInfoTableViewManager: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tutorData[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LabeledTextViewCell.self), for: indexPath) as? LabeledTextViewCell else {
            return LabeledTextViewCell()
        }
        cell.configureCell(with: data, textViewBackgroundColor: Asset.textViewBackground.color)
        cell.nonEditableTextView()
//        cell.setTextViewColor(color: Asset.textViewBackground.color)
//        cell.setTextViewColor(color: Asset.normalTextColor.color)
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}
