//
//  ExpenseScheduleViewModelProtocol.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 24.10.2022.
//

import Foundation

protocol ExpenseScheduleViewModelProtocol {
    var firstDateLabel: Box<String?> { get }
    var secondDateLabel: Box<String?> { get }
    func returnWeek(completion: @escaping () -> ())
    func returnMonth(completion: @escaping () -> ())
    func returnQuarter(completion: @escaping () -> ())
    func returnAll(completion: @escaping () -> ())
    func createSumForLabel() -> [String]
}
