import UIKit

final class LoginViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private var viewModel: LoginViewModel?
    
    private let titleLabel = UILabel()
    private let loginField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton()
    private let statusLabel = UILabel()
    
    deinit{
        print("deinit LoginViewController")
    }
    
    init(coordinator: AppCoordinator, viewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleViews()
        layoutViews()
        bindViewModel()
        
        hideKeyboardWhenTappedAround()
    }
    
}

// MARK: Setup UI
extension LoginViewController {
    private func styleViews() {
        view.backgroundColor = .white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Sing in"
        
        loginField.translatesAutoresizingMaskIntoConstraints = false
        loginField.placeholder = "Username"
        loginField.borderStyle = .roundedRect
        loginField.delegate = self
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.borderStyle = .roundedRect
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.delegate = self
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .systemBlue
        loginButton.tintColor = .lightText
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.text = "Error failure!"
        statusLabel.isHidden = true
    }
    
    private func layoutViews() {
        view.addSubview(titleLabel)
        view.addSubview(loginField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(statusLabel)
        
   
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: GlobalConstants.Padding.topSectionPadding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.headingHeight),
            
            
            loginField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            loginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            loginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            loginField.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.inputHeight),
            
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            passwordField.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.inputHeight),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            loginButton.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.buttonHeight),
            
            statusLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            statusLabel.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.inputHeight),
            
        ])
        
    }
    
    func bindViewModel() {
        viewModel!.statusText.bind({ [weak self] (statusText) in
            DispatchQueue.main.async {
                self?.statusLabel.isHidden = false
                self?.statusLabel.text = statusText
            }
        })
        viewModel!.statusColor.bind({ [weak self] (statusColor) in
            DispatchQueue.main.async {
                self?.statusLabel.textColor = statusColor
            }
        })
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginField.endEditing(true)
        passwordField.endEditing(true)
        return true
    }
    
}


// MARK: - Actions
extension LoginViewController {
    
    @objc func signInTapped(sender: UIButton) {
        statusLabel.isHidden = true
        login()
    }
    
    private func login() {
        viewModel?.userButtonPressed(
            login: loginField.text ?? "",
            password: passwordField.text ?? ""
        )
        if viewModel!.isLoggedIn {
            coordinator?.isLoggedIn = viewModel!.isLoggedIn
            coordinator?.showMain(login: loginField.text ?? "")
        }
    }
    
}
