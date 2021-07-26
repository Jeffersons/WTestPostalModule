import XCTest
@testable import WTestPostalModule

class PostalCodeInteractorTest: XCTestCase {
    var interactor: PostalCodeInteractor!
    var presenter: PostalCodePresenterMock!
    var worker: PostalCodeWorkerMock!

    override func setUp() {
        presenter = PostalCodePresenterMock()
        worker = PostalCodeWorkerMock()
        interactor = PostalCodeInteractor(
            worker: worker,
            presenter: presenter
        )
    }
    
    override func tearDown() {
        presenter.presentPostalCodes = false
        presenter.presentSearchPostalCodes = false
        presenter.presentProgressStatus = false
        presenter.presentUpdateZipCodeIndexed = false
    }
    
    func testFetchPostalCodes() {
        interactor.fetchPostalCodes()
        XCTAssertTrue(presenter.presentPostalCodes)
    }
    
    func testSearchInformation() {
        interactor.searchInformation(info: "Test")
        XCTAssertTrue(presenter.presentSearchPostalCodes)
    }
    
    func testDownloadFileAsync() {
        worker.testPostalCodeError(with: true)
        interactor.fetchPostalCodes()
        XCTAssertTrue(presenter.presentProgressStatus)
    }
    
    func testUpdateZipCodeDataBase() {
        worker.testPostalCodeError(with: true)
        worker.testZipCodeDataBase(with: true)
        interactor.fetchPostalCodes()
        XCTAssertTrue(presenter.presentUpdateZipCodeIndexed)
    }
}
