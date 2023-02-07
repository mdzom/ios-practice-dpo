//
//  CategoriesOfExpensesViewModel.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 15.10.2022.
//

import Foundation

protocol CategoriesOfExpensesViewModelProtocol: AnyObject {
    func numberOfRows() -> Int
    func cellViewModel(for indexPath: IndexPath) -> CategoriesOfExpensesCellViewModelProtocol?
    func addExpense(name: String, sum: Int, completion: @escaping () -> ())
    func paymentScheduleViewModel() -> PaymentScheduleViewController?
}
