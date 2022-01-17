import UIKit

final class AppCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    var isLoggedIn: Bool = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if isLoggedIn {
            showMain(login: User.logins[0].login!)
        } else {
            showLogin()
        }
    }
    
    func showLogin() {
        let loginVC = LoginViewController(
            coordinator: self,
            viewModel: LoginViewModel()
        )

        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func showMain(login: String) {
        let mainVC = MainViewController(
            coordinator: self,
            viewModel: MainViewModel()
        )
       
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    func showDetail() {
        let detailVC = DetailViewController(
            coordinator: self,
            viewModel: DetailViewModel(),
            model: UserData.userData
        )

        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
