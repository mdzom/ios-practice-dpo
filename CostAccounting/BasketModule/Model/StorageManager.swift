//
//  StorageManager.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 20.10.2022.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ object: Income) {
        try! realm.write({
            realm.add(object)
        })
    }
    
    static func saveObject(_ object: ExpenseCategory) {
        try! realm.write({
            realm.add(object)
        })
    }
    
    static func deleteObject(_ object: Income) {
        try! realm.write({
            realm.delete(object)
        })
    }
    
    static func loadCurrentBalance() -> Int {
        guard let value = UserDefaults.standard.value(forKey: "key") as? Int else {
            return 0
        }
        return value
    }
    
    static func saveCurrentBalance(sum: Int) {
        var currentValue = loadCurrentBalance()
        currentValue += sum
        UserDefaults.standard.set(currentValue, forKey: "key")
    }
}
