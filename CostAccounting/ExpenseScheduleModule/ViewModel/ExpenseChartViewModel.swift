//
//  ExpenseChartViewModel.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 31.10.2022.
//

import Foundation
class ExpenseChartViewModel: ExpenseChartViewModelProtocol {

    private var income: [Int]
    private var expense: [Int]
    private var rect = CGRect()
    
    lazy private var num: Int = {
        let maxCount = income.count > expense.count ? income.count - 1 : expense.count - 1
        if maxCount < 9 {
            return maxCount
        } else {
            return 9
        }
    }()
    
    private var timePeriod: Int {
        get {
            income.count > expense.count ? income.count - 1 : expense.count - 1
        }
    }
    
    init() {
        var income = [Int]()
        var expense = [Int]()
        let incomeValue = realm.objects(Income.self)
        
        let expenseValue = realm.objects(Expense.self)
        incomeValue.forEach { income.append($0.sum) }
        
        expenseValue.forEach { expense.append($0.sum) }
        
        self.income = income
        self.expense = expense
    }
    
    func dataAvailabilityCheck() -> Bool {
        timePeriod > 0
    }
    
    private func getMaxSum() -> CGFloat {
        if let maxIncome = income.max(),
           let maxExpense = expense.max() {
            let maxSum = maxExpense > maxIncome ? maxExpense : maxIncome
            return CGFloat(maxSum) / 100
        } else {
            return 0
        }
    }
    
    func setRect(_ rect: CGRect) {
        self.rect = rect
    }
    
    func getCoordinatesIncome() -> [CGPoint] {
        let maxSum = getMaxSum()
        var coordinatesIncome = [CGPoint]()
        let heightOnePercent = rect.height / 100
        if maxSum > 0 {
            for (index, value) in income.enumerated() {
                coordinatesIncome.append(CGPoint(x: Int(rect.width) * index / (timePeriod ),
                                                 y: Int(rect.height - CGFloat(value) / maxSum * heightOnePercent)))
            }
            return coordinatesIncome
        } else {
            return [CGPoint]()
        }
    }
    
    func getCoordinatesExpenses() -> [CGPoint] {
        let maxSum = getMaxSum()
        var coordinatesExpenses = [CGPoint]()
        let heightOnePercent = rect.height / 100
        if maxSum > 0 {
            for (index, value) in expense.enumerated() {
                coordinatesExpenses.append(CGPoint(x: Int(rect.width) * index / (timePeriod ),
                                                   y: Int(rect.height - CGFloat(value) / maxSum * heightOnePercent)))
            }
            return coordinatesExpenses
        } else {
            return [CGPoint]()
        }
    }
    
    
    func getHorisontalLine(completion: @escaping (CGRect) -> ()) {
        for index in 0...num {
            completion(CGRect(x: 0,
                              y: Int(rect.height) * index / num,
                              width: Int(rect.width),
                              height: Int(rect.height)))
        }
    }
    
    func getVerticalLine(completion: @escaping (CGRect) -> ()) {
        for index in 0...timePeriod {
            completion(CGRect(x: Int(rect.width) * index / timePeriod,
                              y: 0,
                              width: Int(rect.width),
                              height: Int(rect.height)))
        }
    }
    
    func getCircleExpenses(completion: @escaping (CGRect) -> ()) {
        let maxSum = getMaxSum()
        let heightOnePercent = rect.height / 100
        if maxSum > 0 {
            for (index, value) in expense.enumerated() {
                completion(CGRect(x: Int(rect.width) * index / timePeriod,
                                  y: Int(rect.height - CGFloat(value) / maxSum * heightOnePercent),
                                  width: Int(rect.width),
                                  height: Int(rect.height)))
            }
        }
    }
    
    func getCircleIncome(completion: @escaping (CGRect) -> ()) {
        let maxSum = getMaxSum()
        let heightOnePercent = rect.height / 100
        if maxSum > 0 {
            for (index, value) in income.enumerated() {
                completion(CGRect(x: Int(rect.width) * index / timePeriod,
                                  y: Int(rect.height - CGFloat(value) / maxSum * heightOnePercent),
                                  width: Int(rect.width),
                                  height: Int(rect.height)))
            }
        }
    }
}
