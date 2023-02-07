//
//  ExpenseCategory.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import Foundation
import RealmSwift

class ExpenseCategory: Object {
    @Persisted var category: String
    @Persisted var expence: List<Expense>

    convenience init(category: String, expence: List<Expense>) {
        self.init()
        self.category = category
        self.expence = expence
    }
}
