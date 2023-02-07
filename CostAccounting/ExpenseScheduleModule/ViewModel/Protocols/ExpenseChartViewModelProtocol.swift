//
//  ExpenseChartViewModelProtocol.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 31.10.2022.
//

import Foundation

protocol ExpenseChartViewModelProtocol: AnyObject {
    func getCircleExpenses(completion: @escaping (CGRect) -> ())
    func getCircleIncome(completion: @escaping (CGRect) -> ())
    func getHorisontalLine(completion: @escaping (CGRect) -> ()) 
    func getVerticalLine(completion: @escaping (CGRect) -> ())
    func getCoordinatesIncome() -> [CGPoint]
    func getCoordinatesExpenses() -> [CGPoint]
    func setRect(_ rect: CGRect)
    func dataAvailabilityCheck() -> Bool
}
