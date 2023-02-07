//
//  CategoriesOfExpensesCellViewModelProtocol.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import Foundation

protocol CategoriesOfExpensesCellViewModelProtocol: AnyObject {
    var name: String { get }
    var date: String { get }
    var sum: String { get }
    func sumWithdrawal(number: Int) -> String
}
