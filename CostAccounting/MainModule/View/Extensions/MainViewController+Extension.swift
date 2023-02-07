//
//  MainViewController+Extension.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import UIKit

extension MainViewController: UITableViewDelegate {}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? MainTableViewCell,
              let viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel else { return }
        viewModel.selectRow(at: indexPath)
        guard let vc = viewModel.viewModelForSelectedRow() else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
