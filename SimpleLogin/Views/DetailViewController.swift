import UIKit

final class DetailViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private var viewModel: DetailViewModel?
    private var model: UserData?
    
    private let titleLabel = UILabel()
    private let nameLabel = UILabel()
    private let cityLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneLabel = UILabel()
   
    
    deinit{
        print("deinit DetailViewController")
    }
    
    init(coordinator: AppCoordinator, viewModel: DetailViewModel, model: UserData) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.model = model
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
extension DetailViewController {
    private func styleViews() {
        view.backgroundColor = .white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "About"
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textAlignment = .center
        cityLabel.numberOfLines = 0

        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textAlignment = .center
        emailLabel.numberOfLines = 0

        
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.textAlignment = .center
        phoneLabel.numberOfLines = 0
     
    }
    
    private func layoutViews() {
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(cityLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: GlobalConstants.Padding.topSectionPadding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.headingHeight),
            
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            nameLabel.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.inputHeight),
            
            cityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            cityLabel.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.inputHeight),
            
            emailLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            emailLabel.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.inputHeight),
            
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: GlobalConstants.Padding.sixteenPadding),
            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -GlobalConstants.Padding.sixteenPadding),
            phoneLabel.heightAnchor.constraint(equalToConstant: GlobalConstants.Size.inputHeight),
        ])
        
    }
    
    private func bindViewModel() {
        nameLabel.text = model?.name
        cityLabel.text = model?.city
        emailLabel.text = model?.email
        phoneLabel.text = model?.phone
    }
}
