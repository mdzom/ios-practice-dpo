//
//  PaymentChartViewModel.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 01.11.2022.
//

import Foundation

class PaymentChartViewModel: PaymentChartViewModelProtocol {
    private var expense: [Int]
    private var rect = CGRect()
    lazy private var num: Int = {
        let maxCount = expense.count - 1
        if maxCount < 9 {
            return maxCount
        } else {
            return 9
        }
    }()
    
    private var timePeriod: Int {
        get {
            expense.count - 1
        }
    }
    
    init(expense: [Int]) {
        self.expense = expense
    }
    
    func dataAvailabilityCheck() -> Bool {
        timePeriod > 0
    }
    
    private func getMaxSum() -> CGFloat {
        if let maxExpense = expense.max() {
            return CGFloat(maxExpense) / 100
        } else {
            return 0
        }
    }
    
    func setRect(_ rect: CGRect) {
        self.rect = rect
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
}
