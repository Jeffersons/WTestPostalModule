//
//  PostalCodeWorkerMock.swift
//  WTestPostalModule-Unit-Tests
//
//  Created by Jefferson de Souza Batista on 26/07/21.
//

import XCTest
@testable import WTestPostalModule

class PostalCodeWorkerMock: NSObject, PostalCodeWorkerProtocol {
    private var shouldValidadePostalCodeError = false
    private var shouldValidadeZipCodeDataBase = false
    func fechPostalCode(success: @escaping FetchPostalCodeSuccess, failure: @escaping PostalCodeError) {
        if shouldValidadePostalCodeError {
            failure(.emptyDataBase)
        } else {
            var dataSource = [PostalCodeViewModel(postalText: "3750-364", locationText: "Belazaima do Chão")]
            dataSource.append(PostalCodeViewModel(postalText: "3780-425", locationText: "Avelãs de Cima"))
            dataSource.append(PostalCodeViewModel(postalText: "7300-238", locationText: "Portalegre"))
            dataSource.append(PostalCodeViewModel(postalText: "4925-413", locationText: "Lanheses"))
            dataSource.append(PostalCodeViewModel(postalText: "2695-650", locationText: "São João da Talha"))
            success(dataSource)
        }
    }
    
    func searchInformation(info: String, result: @escaping FetchPostalCodeSuccess) {
        let dataSource = [PostalCodeViewModel(postalText: "3750-364", locationText: "Belazaima do Chão")]
        result(dataSource)
    }
    
    func updateZipCodeDataBase(success: @escaping ZipCodeIndexed, failure: @escaping PostalCodeError) {
        success("Test")
    }
    
    func downloadFileAsync(finished: @escaping DownloadFileSuccess, downloadFileProgress: @escaping DownloadFileProgress, failure: @escaping PostalCodeError) {
        if shouldValidadeZipCodeDataBase {
            finished(true)
        } else {
            downloadFileProgress(1.0)
        }
    }
    
    func testPostalCodeError(with param: Bool) {
        shouldValidadePostalCodeError = param
    }
    
    func testZipCodeDataBase(with param: Bool) {
        shouldValidadeZipCodeDataBase = param
    }
}
