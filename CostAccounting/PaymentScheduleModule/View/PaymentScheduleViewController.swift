//
//  PaymentScheduleViewController.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 29.10.2022.
//

import UIKit
import SnapKit

class PaymentScheduleViewController: UIViewController {

    var viewModel: PaymentScheduleViewModelProtocol?
    
    private lazy var lineView: UIView = {
        createLine()
    }()
    
    private lazy var weekLineView: UIView = {
        createLine()
    }()
    
    private lazy var monthLineView: UIView = {
        createLine()
    }()
    
    private lazy var quarterLineView: UIView = {
        createLine()
    }()
    
    private lazy var allLineView: UIView = {
        createLine()
    }()
  
    private lazy var chartView: PaymentChartView = {
        let expenses = viewModel?.returnExpense()
        let view = PaymentChartView()
        view.viewModel = expenses
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var buttonWeek: UIButton = {
        let button = createAnIntervalSelectButton(title: "неделя",
                                                  action: #selector(pressButtonWeek))
        button.layer.borderWidth = 1
        return button
    }()
    
    private lazy var buttonMonth: UIButton = {
        createAnIntervalSelectButton(title: "месяц",
                                     action: #selector(pressButtonMonth))
    }()
    
    private lazy var buttonQuarter: UIButton = {
        createAnIntervalSelectButton(title: "квартал",
                                     action: #selector(pressButtonQuarter))
    }()
    
    private lazy var buttonAll: UIButton = {
        createAnIntervalSelectButton(title: "все",
                                     action: #selector(pressButtonAll))
    }()
    
    private lazy var firstDateLabel: UILabel = {
            let view = UILabel()
            view.font = UIFont(name: "HelveticaNeueCyr-Black",
                               size: 9)
            return view
    }()
    
    private lazy var lastDateLabel: UILabel = {
            let view = UILabel()
            view.font = UIFont(name: "HelveticaNeueCyr-Black",
                               size: 9)
            return view
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 20
        view.addArrangedSubview(buttonWeek)
        view.addArrangedSubview(buttonMonth)
        view.addArrangedSubview(buttonQuarter)
        view.addArrangedSubview(buttonAll)
        return view
    }()
    
    private lazy var sumStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .trailing
        guard let array = viewModel?.createSumForLabel() else {
            return view
        }
        array.forEach {view.addArrangedSubview(createNumberLabel(String($0)))}
        return view
    }()
    
    private lazy var dateStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        view.addArrangedSubview(firstDateLabel)
        view.addArrangedSubview(lastDateLabel)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addToView()
        addConstraint()
        viewModel?.returnWeek(completion: { [weak self] in
            self?.showDateLabels() 
        })
    }
    
    private func addToView() {
        view.addSubview(lineView)
        view.addSubview(weekLineView)
        view.addSubview(monthLineView)
        view.addSubview(quarterLineView)
        view.addSubview(allLineView)
        view.addSubview(chartView)
        view.addSubview(sumStackView)
        view.addSubview(dateStackView)
        view.addSubview(buttonsStackView)
    }
    
    private func addConstraint() {
        lineView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(74)
            make.left.right.equalToSuperview().inset(30)
        }
        
        weekLineView.snp.makeConstraints { make in
            make.left.equalTo(buttonWeek.snp.left)
            make.top.equalTo(buttonWeek.snp.bottom).offset(-1)
            make.width.equalTo(buttonWeek)
            make.height.equalTo(1)
        }
        
        monthLineView.snp.makeConstraints { make in
            make.left.equalTo(buttonMonth.snp.left)
            make.top.equalTo(buttonMonth.snp.bottom).offset(-1)
            make.width.equalTo(buttonMonth)
            make.height.equalTo(1)
        }
        
        quarterLineView.snp.makeConstraints { make in
            make.left.equalTo(buttonQuarter.snp.left)
            make.top.equalTo(buttonQuarter.snp.bottom).offset(-1)
            make.width.equalTo(buttonQuarter)
            make.height.equalTo(1)
        }
        
        allLineView.snp.makeConstraints { make in
            make.left.equalTo(buttonAll.snp.left)
            make.top.equalTo(buttonAll.snp.bottom).offset(-1)
            make.width.equalTo(buttonAll)
            make.height.equalTo(1)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(allLineView.snp.bottom).offset(108)
            make.bottom.equalTo(dateStackView.snp.top).offset(-9)
            make.right.equalTo(-16)
            make.left.equalTo(sumStackView.snp.right).offset(2)
        }
        
        sumStackView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(weekLineView.snp.bottom).offset(108)
            make.bottom.equalTo(chartView.snp.bottom)
        }
        
        dateStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-108)
            make.left.equalTo(chartView.snp.left)
            make.right.equalTo(chartView.snp.right)
            make.height.equalTo(12)
        }
    }
    
    private func createTimeLabel(_ num: String) -> UILabel {
        let label = UILabel()
        label.text = num
        return label
    }
    
    private func createNumberLabel(_ number: String) -> UILabel {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeueCyr-Black",
                           size: 9)
        view.text = number
        return view
    }
    
    private func showDateLabels() {
        viewModel?.firstDateLabel.bind { [weak self] text in
            self?.firstDateLabel.text = text
        }
        viewModel?.secondDateLabel.bind { [weak self] text in
            self?.lastDateLabel.text = text
        }
    }
    
    private func buttonIsNotActive() {
        buttonWeek.layer.borderWidth = 0
        buttonMonth.layer.borderWidth = 0
        buttonQuarter.layer.borderWidth = 0
        buttonAll.layer.borderWidth = 0
    }

    @IBAction func pressButtonWeek(_ sender: UIButton) {
        buttonIsNotActive()
        buttonWeek.layer.borderWidth = 1
        viewModel?.returnWeek(completion: { [weak self] in
            self?.showDateLabels()
        })
    }
    
    @IBAction func pressButtonMonth(_ sender: UIButton) {
        buttonIsNotActive()
        buttonMonth.layer.borderWidth = 1
        viewModel?.returnMonth(completion: { [weak self] in
            self?.showDateLabels()
        })
    }
    
    @IBAction func pressButtonQuarter(_ sender: UIButton) {
        buttonIsNotActive()
        buttonQuarter.layer.borderWidth = 1
        viewModel?.returnQuarter(completion: { [weak self] in
            self?.showDateLabels()
        })
    }
    
    @IBAction func pressButtonAll(_ sender: UIButton) {
        buttonIsNotActive()
        buttonAll.layer.borderWidth = 1
        viewModel?.returnAll(completion: {  [weak self] in
            self?.chartView.setNeedsDisplay()
        })
    }
}

