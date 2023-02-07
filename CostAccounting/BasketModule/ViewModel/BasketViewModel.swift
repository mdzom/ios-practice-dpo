//
//  BasketViewModel.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 15.10.2022.
//

import Foundation
import RealmSwift

class BasketViewModel: BasketViewModelProtocol {
    
    var accountBalanceLabel: Box<String?> = Box(nil)
    
    func numberOfRows() -> Int { 5 }
    
    func withdrawalOfCurrentBalance() {
        let balance = StorageManager.loadCurrentBalance()
        let balanceString = sumWithdrawal(balance)
        accountBalanceLabel.value = balanceString
    }
    
    func replenishmentOfBalance(sum: String) {
        let intSum = Int(sum)
        guard let intSum else { return }
        let newIncome = Income(sum: intSum)
        StorageManager.saveObject(newIncome)
        StorageManager.saveCurrentBalance(sum: intSum)
    }
    
    private func sumWithdrawal(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        guard let result = formatter.string(from: number as NSNumber) else {
            return "Error"
        }
        return "\(result) p"
    }
}
