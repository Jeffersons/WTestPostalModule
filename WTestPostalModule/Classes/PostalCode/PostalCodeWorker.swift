import Foundation

class PostalCodeWorker {
    func fetchPostalCodes() -> [PostalCodeViewModel] {
        var dataSource = [PostalCodeViewModel(postalText: "3750-364", locationText: "Belazaima do Chão")]
        dataSource.append(PostalCodeViewModel(postalText: "3780-425", locationText: "Avelãs de Cima"))
        dataSource.append(PostalCodeViewModel(postalText: "7300-238", locationText: "Portalegre"))
        dataSource.append(PostalCodeViewModel(postalText: "4925-413", locationText: "Lanheses"))
        dataSource.append(PostalCodeViewModel(postalText: "2695-650", locationText: "São João da Talha"))
        return dataSource
    }
}
