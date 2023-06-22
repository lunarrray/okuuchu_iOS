

import UIKit

class UpdateTeacherInfoPresentable: PrimaryView {
    //MARK: - Properties
    
    lazy var tableView: UITableView = .init()

    
    //MARK: - Methods
    
    override func onConfigureView() {
        super.onConfigureView()
        super.setGrayWithRightTopBalls()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        let view = PrimaryView()
        view.setGrayWithRightTopBalls()
        tableView.backgroundView = view
        tableView.register(LabeledTextViewCell.self, forCellReuseIdentifier: String(describing: LabeledTextViewCell.self))
        tableView.register(ImageCell.self, forCellReuseIdentifier: String(describing: ImageCell.self))
        tableView.register(PrimaryButtonCell.self, forCellReuseIdentifier: String(describing: PrimaryButtonCell.self))
    }
    
    override func onAddSubviews() {
        addSubview(tableView)
    }
    
    override func onSetupConstraints() {
        tableView.snp.makeConstraints{ maker in
            maker.top.equalToSuperview()
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-20)
        }
    }
}

//MARK: - Extension


extension UpdateTeacherInfoPresentable {
    func reduceTableView(){
        tableView.snp.remakeConstraints{ maker in
            maker.height.equalTo(500)
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func normalTableView(){
        tableView.snp.remakeConstraints{ maker in
            maker.top.equalToSuperview()
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-20)
        }
    }
}
