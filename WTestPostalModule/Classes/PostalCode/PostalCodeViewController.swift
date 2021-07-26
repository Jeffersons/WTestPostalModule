//
//  PostalCodeViewController.swift
//  WTestToolKit
//
//  Created by Jefferson de Souza Batista on 24/07/21.
//

import WTestToolKit

protocol PostalCodeDisplayLogic: AnyObject {
    func displayPostalCodeList(with viewModel: [PostalAndLocationView.ViewModel])
    func displayUpdateProgressBar(with progress: CGFloat)
    func displayUpdateZipCodeIndexed(with zipCodeIdexed: String)
}

class PostalCodeViewController: UIViewController {
    private var searchTask: DispatchWorkItem?
    private let interactor: PostalCodeBusinessLogic
    private lazy var postalTableView = PostalTableView(dataSource: [])
    private lazy var downloadView: DownloadView = {
        let view = DownloadView()
        view.continueAction = { [weak self] in
            self?.interactor.fetchPostalCodes()
            view.removeFromSuperview()
        }
        return view
    }()
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.barStyle = .default
        return searchController
    }()
    
    // MARK: Object lifecycle
    init(interactor: PostalCodeBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    override func loadView() {
        view = downloadView
        postalTableView.bounds = UIScreen.main.bounds
        downloadView.bounds = UIScreen.main.bounds
        downloadView.backgroundColor = Colors.clWhite.color
    }
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.interactor.fetchPostalCodes()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        showSearchBar()
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            postalTableView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        postalTableView.tableView.contentInset = .zero
    }
}
// MARK: Private Functions
private extension PostalCodeViewController {
    func showSearchBar() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .automatic
    }
}
// MARK: UISearchResultsUpdating
extension PostalCodeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchTask?.cancel()
        let text = searchController.searchBar.text ?? ""
        if !text.isEmpty {
            let task = DispatchWorkItem { [weak self] in
                self?.interactor.searchInformation(info: text)
            }
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: task)
        }
    }
}
// MARK: UISearchBarDelegate
extension PostalCodeViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.interactor.fetchPostalCodes()
    }
}

extension PostalCodeViewController: PostalCodeDisplayLogic {
    func displayUpdateZipCodeIndexed(with zipCodeIdexed: String) {
        let task = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.downloadView.configure(with: .init(progress: 1.0, indexInfo: zipCodeIdexed))
        }
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: task)
    }
    
    func displayUpdateProgressBar(with progress: CGFloat) {
        downloadView.configure(with: .init(progress: progress))
    }
    
    func displayPostalCodeList(with viewModel: [PostalAndLocationView.ViewModel]) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        let contentInset = postalTableView.tableView.contentInset
        postalTableView = PostalTableView(dataSource: viewModel)
        postalTableView.tableView.contentInset = contentInset
        view = postalTableView
    }
}
