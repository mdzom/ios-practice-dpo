//
//  Expense.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import Foundation
import RealmSwift

class Expense: Object {
    @Persisted var name: String
    @Persisted var date: Date
    @Persisted var sum: Int

    convenience init(name: String, sum: Int) {
        self.init()
        self.name = name
        self.date = Date()
        self.sum = sum
    }
}
