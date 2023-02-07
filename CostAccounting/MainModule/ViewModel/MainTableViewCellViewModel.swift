//
//  MainTableViewCellViewModel.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import Foundation

class MainTableViewCellViewModel: MainTableViewCellViewModelProtocol {
    
    private var category: ExpenseCategory
    var title: String {
        category.category
    }
    
    init(category: ExpenseCategory) {
        self.category = category
    }
}
