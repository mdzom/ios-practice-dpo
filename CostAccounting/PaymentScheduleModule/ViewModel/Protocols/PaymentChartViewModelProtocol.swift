//
//  PaymentChartViewModelProtocol.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 01.11.2022.
//

import Foundation

protocol PaymentChartViewModelProtocol: AnyObject {
    func getCircleExpenses(completion: @escaping (CGRect) -> ())
    func getHorisontalLine(completion: @escaping (CGRect) -> ())
    func getVerticalLine(completion: @escaping (CGRect) -> ())
    func getCoordinatesExpenses() -> [CGPoint]
    func setRect(_ rect: CGRect)
    func dataAvailabilityCheck() -> Bool
}
