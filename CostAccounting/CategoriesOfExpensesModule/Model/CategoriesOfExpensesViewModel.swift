//
//  CategoriesOfExpensesViewModel.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import Foundation
import RealmSwift

class CategoriesOfExpensesViewModel: CategoriesOfExpensesViewModelProtocol {
    private var expenses: ExpenseCategory    
    
    func numberOfRows() -> Int {
        expenses.expence.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> CategoriesOfExpensesCellViewModelProtocol? {
        let expense = expenses.expence[indexPath.row]
        return CategoriesOfExpensesCellViewModel(expense: expense)
    }
    
    func paymentScheduleViewModel() -> PaymentScheduleViewController? {
        let expense = expenses.expence
        let viewController = PaymentScheduleViewController()
        viewController.viewModel = PaymentScheduleViewModel(expense: expense)
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }
    
    func addExpense(name: String, sum: Int, completion: @escaping () -> ()) {
        let newExpense = Expense(name: name,
                                 sum: sum)
        StorageManager.saveCurrentBalance(sum: -sum)
        try! realm.write {
            expenses.expence.append(newExpense)
        }
        completion()
    }
    
    init(expenses: ExpenseCategory) {
        self.expenses = expenses
    }
}
