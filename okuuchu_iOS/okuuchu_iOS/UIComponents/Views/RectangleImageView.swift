
import UIKit

class RectangleImageView: UIView {
    private let imageView: UIImageView = .init()
    private let button: UIButton = .init()
    private var viewModel: TitleSubtitleViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        onSetupSubviews()
        onAddSubviews()
        onSetupConstraints()
        onSetupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func onSetupSubviews(){

        imageView.backgroundColor = Asset.white.color
        imageView.layer.borderColor = Asset.darkBlue.color.cgColor
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        button.setImage(Asset.cameraIcon.image, for: .normal)
        button.addShadow()
    }
    
    private func onAddSubviews() {
        addSubviews(
            imageView,
            button
        )
    }
    
    private func onSetupConstraints(){
        imageView.snp.makeConstraints { maker in
            maker.horizontalEdges.equalToSuperview().inset(10)
            maker.verticalEdges.equalToSuperview().inset(10)
        }
        
        let size = bounds.size.width / 3
        button.snp.makeConstraints{ maker in
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.width.equalTo(size)
            maker.height.equalTo(size)
        }
    }
    
    private func onSetupTargets() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func configureWith(viewModel: TitleSubtitleViewModel) {
        self.viewModel = viewModel
        guard let image = viewModel.image else { return }
        imageView.image = image
        imageView.layer.borderWidth = 0
        imageView.backgroundColor = .clear
    }
    
    @objc private func buttonTapped()  {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.onCellUpdate?()
    }
}
