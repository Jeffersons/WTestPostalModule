import UIKit

protocol SampleDisplayLogic: AnyObject {
    func displaySomething(viewModel: SampleModel)
}

class SampleViewController: UIViewController {
    let interactor: SampleBusinessLogic
    private var sampleButton = UIButton()
    
    // MARK: Object lifecycle
    init(interactor: SampleBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        view.backgroundColor = .red
        sampleButton.setTitle("Sample Code", for: .normal)
        sampleButton.layer.borderWidth = 1.0
        sampleButton.layer.cornerRadius = 5.0
        sampleButton.layer.borderColor = UIColor.white.cgColor
        sampleButton.setTitleColor(.white, for: .normal)
        sampleButton.frame = CGRect(
            x: view.frame.size.width / 2,
            y: view.frame.size.height / 2 ,
            width: 300,
            height: 50)
        sampleButton.center = view.center
        sampleButton.addTarget(self, action: #selector(SampleViewController.doSomething), for: .touchUpInside)
        self.view.addSubview(sampleButton)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Do something
    @objc func doSomething(){
        interactor.doSomething()
    }
}

extension SampleViewController: SampleDisplayLogic {
    func displaySomething(viewModel: SampleModel) {
        debugPrint(viewModel.sampleTitle)
        sampleButton.setTitle(viewModel.sampleTitle, for: .normal)
    }
}
