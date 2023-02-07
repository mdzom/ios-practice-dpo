//
//  CategoriesOfExpensesTableViewCell.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import UIKit

class CategoriesOfExpensesTableViewCell: UITableViewCell {
    
    weak var viewModel: CategoriesOfExpensesCellViewModelProtocol? {
        willSet(viewModel) {
                            nameLabel.text = viewModel?.name
                            dateLabel.text = viewModel?.date
                            sumLabel.text = viewModel?.sum
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProDisplay-Medium",
                           size: 16)
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProDisplay-Medium",
                           size: 16)
        return view
    }()
    
    private lazy var sumLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProDisplay-Medium",
                           size: 16)
        return view
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.741,
                                       green: 0.741,
                                       blue: 0.741,
                                       alpha: 1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addToView()
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addToView() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(sumLabel)
        contentView.addSubview(lineView)
    }
    
    private func addConstraint() {
        lineView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        sumLabel.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }
    }
}
