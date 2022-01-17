import UIKit

final class LoginViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    var viewModel: LoginViewModel?
    
    private let titleLabel = UILabel()
    private let loginField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton()
    private let statusLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleViews()
        layoutViews()
        bindViewModel()
        
        hideKeyboardWhenTappedAround()
    }
    
}

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
        
        let padding: CGFloat = 16
        
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding * 3),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 48),
            
            
            loginField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            loginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            loginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            loginField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: padding),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            passwordField.heightAnchor.constraint(equalToConstant: 48),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: padding),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            
            statusLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: padding),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            statusLabel.heightAnchor.constraint(equalToConstant: 48),
            
        ])
        
    }
    
    func bindViewModel() {
        viewModel!.statusText.bind({ (statusText) in
            DispatchQueue.main.async {
                self.statusLabel.isHidden = false
                self.statusLabel.text = statusText
            }
        })
        viewModel!.statusColor.bind({(statusColor) in
            DispatchQueue.main.async {
                self.statusLabel.textColor = statusColor
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
