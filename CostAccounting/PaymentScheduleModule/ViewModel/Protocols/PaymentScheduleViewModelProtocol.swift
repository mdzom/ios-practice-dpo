//
//  PaymentScheduleViewModelProtocol.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 29.10.2022.
//

import Foundation
protocol PaymentScheduleViewModelProtocol {
    var firstDateLabel: Box<String?> { get }
    var secondDateLabel: Box<String?> { get }
    func returnExpense() -> PaymentChartViewModel
    func returnWeek(completion: @escaping () -> ())
    func returnMonth(completion: @escaping () -> ())
    func returnQuarter(completion: @escaping () -> ())
    func returnAll(completion: @escaping () -> ())
    func createSumForLabel() -> [String]
}
