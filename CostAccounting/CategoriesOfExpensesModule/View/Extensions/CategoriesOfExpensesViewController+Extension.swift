//
//  CategoriesOfExpensesViewController+Extension.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import UIKit

extension CategoriesOfExpensesViewController: UITableViewDelegate {}

extension CategoriesOfExpensesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? CategoriesOfExpensesTableViewCell,
              let viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.viewModel = cellViewModel
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    
    
}
