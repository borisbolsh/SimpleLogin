import UIKit

final class MainViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    private var viewModel: MainViewModel?
    
    private let titleLabel = UILabel()
    private let textLabel = UITextView()
    private let aboutButton = UIButton()
    
    
    deinit{
        print("deinit MainViewController")
    }
    
    init(coordinator: AppCoordinator, viewModel: MainViewModel) {
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
    }
    
}

// MARK: Setup UI
extension MainViewController {
    private func styleViews() {
        view.backgroundColor = .white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Default"
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        textLabel.isEditable = false
        
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        aboutButton.backgroundColor = .gray
        aboutButton.tintColor = .darkText
        aboutButton.setTitle("About", for: .normal)
        aboutButton.layer.cornerRadius = 8
        aboutButton.addTarget(self, action: #selector(aboutTapped), for: .primaryActionTriggered)
    }

    private func layoutViews() {
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        view.addSubview(aboutButton)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: GlobalConstants.Padding.topSectionPadding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.headingHeight),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            textLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: GlobalConstants.Size.textFieldHeight),
            
            aboutButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            aboutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            aboutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            aboutButton.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.buttonHeight),
            ])
    }
    
    private func bindViewModel() {
        titleLabel.text = "Hello \(viewModel?.login ?? "Default")"
    }

}

// MARK: - Actions
extension MainViewController {
    
    @objc func aboutTapped(sender: UIButton) {
        coordinator?.showDetail()
    }

}
