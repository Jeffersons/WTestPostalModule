//
//  Realm+Extensions.swift
//  WTestPostalModule
//
//  Created by Jefferson de Souza Batista on 26/07/21.
//

import RealmSwift

extension Realm {
    static func safeInit() -> Realm? {
        do {
            let realm = try Realm()
            return realm
        }
        catch {
            debugPrint(#function)
        }
        return nil
    }
    func safeWrite(_ block: () -> ()) {
        do {
            // Async safety, to prevent "Realm already in a write transaction" Exceptions
            if !isInWriteTransaction {
                try write(block)
            }
        } catch {
            debugPrint(#function)
        }
    }
}
