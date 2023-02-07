//
//  MainTableViewCell.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 16.10.2022.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    weak var viewModel: MainTableViewCellViewModelProtocol? {
        willSet(viewModel) {
            titleLabel.text = viewModel?.title
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProDisplay-Medium",
                           size: 16)
        return view
    }()
    
    private lazy var arrowIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        return view
    }()
    
    private lazy var lineView: UIView = {
        createLine()
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
        contentView.addSubview(lineView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowIcon)
    }
    
    private func addConstraint() {
        lineView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        arrowIcon.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }
    }
}
