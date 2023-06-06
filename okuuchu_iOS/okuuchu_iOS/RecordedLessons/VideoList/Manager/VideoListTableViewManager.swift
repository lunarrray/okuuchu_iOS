
import UIKit

//MARK: - Protocols

protocol VideoListTableViewDelegate: AnyObject{
    func tappedCell(at indexPath: IndexPath)
}

//MARK: - Class

class VideoListTableViewManager: NSObject {
    weak var delegate: VideoListTableViewDelegate?
    private var videos: [TitleSubtitleViewModel] = []
    
    func setTableViewData(_ videos: [TitleSubtitleViewModel], tableView: UITableView){
        self.videos = videos
        tableView.reloadData()
    }
}


//MARK: - Extension
extension VideoListTableViewManager: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videos[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleSubtitleCell.self), for: indexPath) as? TitleSubtitleCell else {
            return TitleSubtitleCell()
        }
        
        cell.configureCell(with: video)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.tappedCell(at: indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


