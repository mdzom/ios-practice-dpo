//
//  BasketViewModelProtocol.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 15.10.2022.
//

import Foundation

protocol BasketViewModelProtocol: AnyObject  {
    var accountBalanceLabel: Box<String?> { get }
    func numberOfRows() -> Int
    func withdrawalOfCurrentBalance()
    func replenishmentOfBalance(sum: String)
}
