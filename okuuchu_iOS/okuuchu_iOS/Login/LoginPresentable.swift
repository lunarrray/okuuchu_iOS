
import UIKit
import SnapKit

class LoginPresentable: BaseView {
    
    //MARK: - Properties
    private let leftBall: UIImageView = .init()
    private let mainLabel: UILabel = .init()
    private let presentingImage: UIImageView = .init()
    private let stackView: UIStackView = .init()
    private let emailTextField: MainTextField = .init()
    private let passwordTextfield: MainTextField = .init()
    private let forgotPasswordButton: UIButton = .init()
    private let loginButton: PrimaryButton = .init(frame: .zero)
    private let horizontalStackView: UIStackView = .init()
    private let questionLabel: UILabel = .init()
    private let registerButton: UIButton = .init()
    private let dismissKeyboard: UITapGestureRecognizer = .init()
    
    
    //MARK: - Override methods
    override func onConfigureView() {
        
        backgroundColor = Asset.primaryGrayBackground.color
        
        leftBall.image = Asset.leftBlueBalls.image
        
        mainLabel.textAlignment = .center
        mainLabel.font = .boldSystemFont(ofSize: 22)
        mainLabel.textColor = Asset.normalTextColor.color
        mainLabel.text = "Добро пожаловать"
        
        presentingImage.image = Asset.boyAndPhoneImage.image
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 25
        stackView.distribution = .fill
        
        emailTextField.placeholder = "Введите email"
        emailTextField.keyboardType = .emailAddress
        
        passwordTextfield.placeholder = "Введите пароль"
        passwordTextfield.passwordModeActivate()
        
        forgotPasswordButton.setTitle("Забыли пароль?", for: .normal)
        forgotPasswordButton.setTitleColor(Asset.textButton.color, for: .normal)
        forgotPasswordButton.setTitleColor(Asset.darkBlue.color, for: .selected)
        forgotPasswordButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        loginButton.backgroundColor = Asset.primaryButtonsBlue.color
        loginButton.setTitle("Войти", for: .normal)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fillProportionally
        
        questionLabel.text = "Нет аккаунта?"
        questionLabel.textColor = Asset.normalTextColor.color
        questionLabel.textAlignment = .right
        questionLabel.font = .systemFont(ofSize: 14)
        
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.setTitleColor(Asset.textButton.color, for: .normal)
        registerButton.setTitleColor(Asset.darkBlue.color, for: .selected)
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
    }
    
    override func onAddSubviews() {
        addSubviews(
            leftBall,
            mainLabel,
            presentingImage,
            stackView
        )
        
        stackView.addArrangedSubviews(
            emailTextField,
            passwordTextfield,
            forgotPasswordButton,
            loginButton,
            horizontalStackView
        )
        
        horizontalStackView.addArrangedSubviews(
            questionLabel,
            registerButton
        )
        
        
    }
    
    override func onSetupConstraints() {
        leftBall.snp.makeConstraints { maker in
            maker.left.equalToSuperview()
            maker.top.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints{ maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(leftBall.snp.bottom).offset(20)
        }
        
        presentingImage.snp.makeConstraints{ maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(mainLabel.snp.bottom).offset(40)
        }
        
        stackView.snp.makeConstraints{ maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-35)
            maker.width.equalToSuperview().inset(30)
        }
        
        emailTextField.snp.makeConstraints { maker in
            maker.height.equalTo(54)
            maker.width.equalToSuperview()
        }
        
        passwordTextfield.snp.makeConstraints { maker in
            maker.height.equalTo(54)
            maker.width.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { maker in
            maker.height.equalTo(70)
            maker.width.equalToSuperview()
        }
        
        horizontalStackView.snp.makeConstraints{ maker in
            maker.width.equalToSuperview()
        }
    }
    
    override func onSetupTargets() {
        dismissKeyboard.addTarget(self, action: #selector(viewTapped))
    }
}

extension LoginPresentable {
    @objc private func viewTapped(_ recognizer: UITapGestureRecognizer){
        endEditing(true)
    }
}
