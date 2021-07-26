//
//  PostalCodePresenterMock.swift
//  WTestPostalModule-Unit-Tests
//
//  Created by Jefferson de Souza Batista on 26/07/21.
//

import XCTest
@testable import WTestPostalModule

class PostalCodePresenterMock: PostalCodePresentationLogic {
    var presentPostalCodes = false
    var presentSearchPostalCodes = false
    var presentProgressStatus = false
    var presentUpdateZipCodeIndexed = false
    
    func presentPostalCodes(response: [PostalCodeViewModel]) {
        switch response.count {
        case 5:
            presentPostalCodes = true
        case 1:
            presentSearchPostalCodes = true
        default:
            return
        }
    }
    
    func presentProgressStatus(response: CGFloat) {
        if response == 1.0 {
            presentProgressStatus = true
        }
    }
    
    func presentUpdateZipCodeIndexed(response: String) {
        if response == "Test" {
            presentUpdateZipCodeIndexed = true
        }
    }
}
