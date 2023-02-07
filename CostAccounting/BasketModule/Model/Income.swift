//
//  Income.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import RealmSwift

class Income: Object {
    @Persisted var sum: Int
    @Persisted var date: Date
    
    convenience init(sum: Int) {
        self.init()
        self.sum = sum
        self.date = Date()
    }
}
