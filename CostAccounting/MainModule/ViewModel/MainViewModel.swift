//
//  MainViewModel.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 15.10.2022.
//

import Foundation
import RealmSwift

class MainViewModel: MainViewModelProtocol {
    
    private var selectedIndexPath: IndexPath?
    
    private var expenseCategory: Results<ExpenseCategory> {
        realm.objects(ExpenseCategory.self)
    }
    
    func cellViewModel(for indexPath: IndexPath) -> MainTableViewCellViewModelProtocol? {
        let category = expenseCategory[indexPath.row]
        return MainTableViewCellViewModel(category: category)
    }
    
    func viewModelForSelectedRow() -> CategoriesOfExpensesViewController? {
        guard let selectedIndexPath else { return nil }
        let expenses = expenseCategory[selectedIndexPath.row]
        let viewController = CategoriesOfExpensesViewController()
        viewController.viewModel = CategoriesOfExpensesViewModel(expenses: expenses)
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }
    
    func selectRow(at indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
    func addAnExpenseCategory(category: String, completion: @escaping () -> ()) {
        let emptyList = List<Expense>()
        let newCategory = ExpenseCategory(category: category,
                                          expence: emptyList)
        try! realm.write({
            realm.add(newCategory)
        })
        completion()
    }
    
    func numberOfRows() -> Int {
        return expenseCategory.count
    }
}
