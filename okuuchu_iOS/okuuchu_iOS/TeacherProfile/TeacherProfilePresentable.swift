
import UIKit

final class TeacherProfilePresentable: PrimaryView{
    
    // MARK: - Properties
    
    private var nameLabel: UILabel = .init()
    private var avatarImageView: RoundedImageView = .init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    private var ratingView: RatingView = .init()
    private var aboutTeacherView: LabeledTextView = .init()
    private var lessonsView: LabeledTextView = .init()
    
    private let tableView: RoundedTableView = .init()
    private let whiteView: UIView = .init()
    
    private var tableDataCurrent = ["График", "Записанные уроки", "Обновить информацию о себе", "Обьявления", "Отзывы", "Информация", ]
    
    //MARK: - Methods
    
    override func onConfigureView() {
        super.onConfigureView()
        super.setBlueWithLeftTopBalls()
        
        nameLabel.text = "Алиса Иванова"
        nameLabel.font = .systemFont(ofSize: 25)
        nameLabel.textAlignment = .left
        nameLabel.textColor = Asset.normalTextColor.color
        
        avatarImageView.imageView.image = Asset.avatarImg.image
        avatarImageView.imageView.clipsToBounds = true
        avatarImageView.activateCameraButton()
        
        ratingView.configureWith(rating: 3.5, spacing: 25, starColor: Asset.normalTextColor.color)
        let aboutTeacherData = LabelAndTextData(title: "Немного о себе", text: "Дорогие друзья, выбранный нами инновационный путь способствует повышению актуальности модели развития. Соображения высшего порядка!", type: .usual)
        
        aboutTeacherView.configureWith(aboutTeacherData, textBackgroundColor: Asset.textViewBackground.color)
        
        let lessonsData = LabelAndTextData(title: "Предметы", text: "Математика, Программирование", type: .usual)
        lessonsView.configureWith(lessonsData, textBackgroundColor: Asset.textViewBackground.color)
        
        tableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        
        whiteView.backgroundColor = Asset.white.color
    }
    
    override func onAddSubviews() {
        super.onAddSubviews()
        
        addSubviews(
            nameLabel,
            avatarImageView,
            ratingView,
            aboutTeacherView,
            lessonsView,
            whiteView,
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
            maker.width.equalTo(90)
        }
        
        lessonsView.snp.makeConstraints{ maker in
            maker.top.equalTo(aboutTeacherView.snp.bottom).offset(10)
            maker.left.right.equalToSuperview().inset(20)
            maker.width.equalTo(50)
        }
        
        tableView.snp.makeConstraints{ maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(250)
            maker.top.equalTo(lessonsView.snp.bottom).offset(30)
        }
        
        whiteView.snp.makeConstraints{ maker in
            maker.top.equalTo(tableView.snp.bottom)
            maker.right.left.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    override func onSetupTargets() {
        super.onSetupTargets()
    }
}


extension TeacherProfilePresentable: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataCurrent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleCell.self), for: indexPath) as? TitleCell else { return TitleCell() }
        var titleData = CellData(title: tableDataCurrent[indexPath.row])
        cell.configureCell(with: titleData)
        cell.accessoryType = .disclosureIndicator
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
//        cell.textLabel?.text = tableDataCurrent[indexPath.row]
//        cell.textLabel?.font = .systemFont(ofSize: 16)
//        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
