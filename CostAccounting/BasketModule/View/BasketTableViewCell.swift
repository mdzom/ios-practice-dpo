//
//  BasketTableViewCell.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 15.10.2022.
//

import UIKit
import SnapKit

class BasketTableViewCell: UITableViewCell {
    
    private lazy var lineView: UIView = {
        createLine()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addToView()
        addConstraint()
    }
    
    private func addToView() {
        contentView.addSubview(lineView)
    }
    
    private func addConstraint() {
        lineView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
