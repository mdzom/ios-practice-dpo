//
//  PaymentScheduleViewModel.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 29.10.2022.
//

import Foundation
import RealmSwift

class PaymentScheduleViewModel: PaymentScheduleViewModelProtocol {
    private let dateFormatter = DateFormatter()
    private var week = [String]()
    private var month = [String]()
    private var quarter = [String]()
    private var date = Date()
    private let calendar = Calendar.current
    private var numberOfSumLabels: Int = 0
    private var timePeriodLabels: Int = 0
    private var maxSum: CGFloat = 0
    private var expense: List<Expense>
    
    var firstDateLabel: Box<String?> = Box(nil)
    var secondDateLabel: Box<String?> = Box(nil)
    
    lazy private var num: Int = {
        let maxCount = expense.count - 1
        if maxCount < 9 {
            return maxCount
        } else {
            return 9
        }
    }()
    
    init(expense: List<Expense>) {
        self.expense = expense
    }
    
    func returnExpense() -> PaymentChartViewModel {
        var sumExpenses = [Int]()
        expense.forEach { sumExpenses.append($0.sum) }
        return PaymentChartViewModel(expense: sumExpenses)
    }
    
    func createSumForLabel() -> [String] {
        var sumExpenses = [Int]()
        expense.forEach { sumExpenses.append($0.sum) }
        guard let maxSumExpenses = sumExpenses.max() else {
            return [String]()
        }
        var value = [String]()
        self.maxSum = CGFloat(maxSumExpenses)
        for index in 0...num {
            let number = sumWithdrawal(maxSumExpenses - (maxSumExpenses * index / 10))
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


