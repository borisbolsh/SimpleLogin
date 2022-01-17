import UIKit

final class MainViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    var viewModel: MainViewModel?
    
    private let mainLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Main screen loaded")
        mainLabel.text = "Hello \(viewModel?.login ?? "Default")"
    }
    
}

