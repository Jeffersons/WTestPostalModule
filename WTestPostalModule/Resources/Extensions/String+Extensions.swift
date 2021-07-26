//
//  String+Extensions.swift
//  WTestPostalModule
//
//  Created by Jefferson de Souza Batista on 25/07/21.
//

import Foundation

extension String {
    init(withInt int: Int, leadingZeros: Int = 2) {
        self.init(format: "%0\(leadingZeros)d", int)
    }
    func leadingZeros(_ zeros: Int) -> String {
        if let int = Int(self) {
            return String(withInt: int, leadingZeros: zeros)
        }
        return ""
    }
}
