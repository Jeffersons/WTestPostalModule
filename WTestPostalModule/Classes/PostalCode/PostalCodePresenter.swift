import WTestToolKit

protocol PostalCodePresentationLogic {
    func presentPostalCodes(response: [PostalCodeViewModel])
    func presentProgressStatus(response: CGFloat)
    func presentUpdateZipCodeIndexed(response: String)
}

final class PostalCodePresenter {
    weak var viewController: PostalCodeDisplayLogic?
}

extension PostalCodePresenter: PostalCodePresentationLogic {
    func presentUpdateZipCodeIndexed(response: String) {
        viewController?.displayUpdateZipCodeIndexed(with: response)
    }
    
    func presentProgressStatus(response: CGFloat) {
        viewController?.displayUpdateProgressBar(with: response)
    }
    
    func presentPostalCodes(response: [PostalCodeViewModel]) {
        let viewModel = transform(with: response)
        viewController?.displayPostalCodeList(with: viewModel)
    }
}

// MARK: Private Functions
private extension PostalCodePresenter {
    private func transform(with response: [PostalCodeViewModel]) -> [PostalAndLocationView.ViewModel] {
        var items: [PostalAndLocationView.ViewModel] = []
        items = response.map { item in
            return PostalAndLocationView.ViewModel(
                postalText: item.postalText,
                locationText: item.locationText
            )
        }
        return items
    }
}
