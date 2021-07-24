//
//  PostalCodeViewController.swift
//  WTestToolKit
//
//  Created by Jefferson de Souza Batista on 24/07/21.
//

import WTestToolKit

protocol PostalCodeDisplayLogic: AnyObject {
    func displayPostalCodeList(with viewModel: [PostalAndLocationView.ViewModel])
}

class PostalCodeViewController: UIViewController {
    private let interactor: PostalCodeBusinessLogic
    private lazy var contentView = UIView(frame: UIScreen.main.bounds)
    
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
        view = UIView(frame: UIScreen.main.bounds)
    }
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchPostalCodes()
    }
}

extension PostalCodeViewController: PostalCodeDisplayLogic {
    func displayPostalCodeList(with viewModel: [PostalAndLocationView.ViewModel]) {
        let postalTableView = PostalTableView(dataSource: viewModel)
        view = postalTableView
    }
}
