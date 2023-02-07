//
//  CategoriesOfExpensesCellViewModel.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import Foundation

class CategoriesOfExpensesCellViewModel: CategoriesOfExpensesCellViewModelProtocol {
    
    private let expense: Expense
    var name: String {
        expense.name
    }
    
    var date: String {
        dateToString(expense.date)
    }
    
    var sum: String {
        sumWithdrawal(number: expense.sum)
    }
    
    init(expense: Expense) {
        self.expense = expense
    }
    
    private func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    func sumWithdrawal(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        guard let result = formatter.string(from: number as NSNumber) else {
            return "Error"
        }
        return "\(result) p"
    }
}
