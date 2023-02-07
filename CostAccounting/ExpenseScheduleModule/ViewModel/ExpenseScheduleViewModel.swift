//
//  ExpenseScheduleViewModel.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 15.10.2022.
//

import Foundation

class ExpenseScheduleViewModel: ExpenseScheduleViewModelProtocol {
    private let dateFormatter = DateFormatter()
    private var week = [String]()
    private var month = [String]()
    private var quarter = [String]()
    private var date = Date()
    private let calendar = Calendar.current
    private var numberOfSumLabels: Int = 0
    private var timePeriodLabels: Int = 0
    private var maxSum: CGFloat = 0
    
    var firstDateLabel: Box<String?> = Box(nil)
    var secondDateLabel: Box<String?> = Box(nil)
    
    private var income: [Int] = {
        var income = [Int]()
        let incomeValue = realm.objects(Income.self)
        incomeValue.forEach { income.append($0.sum) }
        return income
    }()
    
    private var expense: [Int] = {
        var expense = [Int]()
        let expenseValue = realm.objects(Expense.self)
        expenseValue.forEach { expense.append($0.sum) }
        return expense
    }()
    
    lazy private var num: Int = {
        let maxCount = income.count > expense.count ? income.count - 1 : expense.count - 1
        if maxCount < 9 {
            return maxCount
        } else {
            return 9
        }
    }()
    
    func createSumForLabel() -> [String] {
        guard let maxSumExpenses = expense.max(),
              let maxSumIncome = income.max() else {
            return [String]()
        }
        let maxSum = maxSumExpenses > maxSumIncome ? maxSumExpenses : maxSumIncome
        var value = [String]()
        self.maxSum = CGFloat(maxSum)
        
        for index in 0...num {
            let number = sumWithdrawal(maxSum - (maxSum * index / 10))
            value.append(number)
        }
        value.append("")
        return value
    }
    
    private func sumWithdrawal(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        guard let result = formatter.string(from: number as NSNumber) else {
            return "Error"
        }
        return result
    }

    func returnWeek(completion: @escaping () -> ()) {
        dateFormatter.dateFormat = "dd.MM"
        
        for day in 1...7 {
            var component = DateComponents()
            component.day = -day
            guard let lastDate = calendar.date(byAdding: component,
                                               to: date) else {
                return
            }
            week.append(dateFormatter.string(from: lastDate))
        }
        
        guard let first = week.last,
              let last = week.first else {
            return
        }
        firstDateLabel.value = "\(first)"
        secondDateLabel.value = "\(last)"
        completion()
    }
    
    func returnMonth(completion: @escaping () -> ()) {
        dateFormatter.dateFormat = "dd.MM"
        
        for day in 1...30 {
            var component = DateComponents()
            component.day = -day
            guard let lastDate = calendar.date(byAdding: component,
                                               to: date) else {
                return
            }
            month.append(dateFormatter.string(from: lastDate))
        }
        guard let first = month.last,
              let last = month.first else {
            return
        }
        firstDateLabel.value = "\(first)"
        secondDateLabel.value = "\(last)"
        completion()
    }
    
    func returnQuarter(completion: @escaping () -> ()) {
        dateFormatter.dateFormat = "dd.MM"
        for day in 1...90 {
            var component = DateComponents()
            component.day = -day
            guard let lastDate = calendar.date(byAdding: component,
                                               to: date) else {
                return
            }
            quarter.append(dateFormatter.string(from: lastDate))
        }
        guard let first = quarter.last,
              let last = quarter.first else {
            return
        }
        firstDateLabel.value = "\(first)"
        secondDateLabel.value = "\(last)"
        completion()
    }
    
    func returnAll(completion: @escaping () -> ()) {
        dateFormatter.dateFormat = "dd.MM"
    }
}
