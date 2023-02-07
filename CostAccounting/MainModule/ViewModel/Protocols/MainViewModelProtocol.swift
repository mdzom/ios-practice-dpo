//
//  MainViewModelProtocol.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import Foundation

protocol MainViewModelProtocol: AnyObject  {
    func numberOfRows() -> Int
    func cellViewModel(for indexPath: IndexPath) -> MainTableViewCellViewModelProtocol?
    func viewModelForSelectedRow() -> CategoriesOfExpensesViewController?
    func selectRow(at indexPath: IndexPath)
    func addAnExpenseCategory(category: String, completion: @escaping () -> ())
}
