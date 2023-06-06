
import UIKit

final class TeacherProfilePresentable: PrimaryView{
    
    // MARK: - Properties
    
    private var nameLabel: UILabel = .init()
    private var avatarImageView: RoundedImageView = .init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    private var ratingView: RatingView = .init()
    private var aboutTeacherView: LabeledTextView = .init()
    private var lessonsView: LabeledTextView = .init()
    
    var tableView: RoundedTableView = .init()
    
    //MARK: - Methods
    
    override func onConfigureView() {
        super.onConfigureView()
        super.setBlueWithLeftTopBalls()
        
        nameLabel.font = .systemFont(ofSize: 25)
        nameLabel.textAlignment = .left
        nameLabel.textColor = Asset.normalTextColor.color
        
        avatarImageView.imageView.clipsToBounds = true
        
        aboutTeacherView.nonEditableTextView()

        lessonsView.nonEditableTextView()
        
        tableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))

    }
    
    override func onAddSubviews() {
        super.onAddSubviews()
        
        addSubviews(
            nameLabel,
            avatarImageView,
            ratingView,
            aboutTeacherView,
            lessonsView,
            tableView
        )
    }
    
    override func onSetupConstraints() {
        super.onSetupConstraints()
        
        nameLabel.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().offset(70)
            maker.left.equalToSuperview().offset(30)
        }
        
        avatarImageView.snp.makeConstraints{ maker in
            maker.width.equalTo(100)
            maker.height.equalTo(100)
            maker.top.equalTo(nameLabel.snp.bottom).offset(20)
            maker.centerX.equalToSuperview()
        }
        
        
        ratingView.snp.makeConstraints{ maker in
            maker.top.equalTo(avatarImageView.snp.bottom).offset(20)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(200)
        }
        
        aboutTeacherView.snp.makeConstraints{ maker in
            maker.top.equalTo(ratingView.snp.bottom).offset(20)
            maker.left.right.equalToSuperview().inset(20)
        }
        
        lessonsView.snp.makeConstraints{ maker in
            maker.top.equalTo(aboutTeacherView.snp.bottom).offset(10)
            maker.left.right.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints{ maker in
            maker.width.equalToSuperview()
            maker.top.equalTo(lessonsView.snp.bottom).offset(25)
            maker.bottom.equalToSuperview()
        }
        
    }
}

//MARK: - Extension

extension TeacherProfilePresentable {
    func setTutorData(name: String, image: UIImage, description: String, lessons: String, rating: Double){
        
        nameLabel.text = name
        avatarImageView.imageView.image = image
        let aboutTeacherData = TitleSubtitleViewModel(title: "Немного о себе", subtitle: description)
        aboutTeacherView.configureWith(aboutTeacherData, textBackgroundColor: Asset.textViewBackground.color)
        let lessonsData = TitleSubtitleViewModel(title: "Предметы", subtitle: lessons)
        lessonsView.configureWith(lessonsData, textBackgroundColor: Asset.textViewBackground.color)
        ratingView.configureWith(rating: rating, spacing: 25, starColor: Asset.normalTextColor.color)

    }
}
