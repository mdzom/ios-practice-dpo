//
//  BasketViewController.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 15.10.2022.
//

import UIKit
import SnapKit

class BasketViewController: UIViewController {
    let cellIdentifier = "BasketCell"
    var viewModel: BasketViewModelProtocol?
    
    private lazy var blur: UIVisualEffectView = {
        createBlurEffect()
    }()
    
    private lazy var currentBalanceLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProDisplay-Medium",
                           size: 16)
        view.attributedText = NSMutableAttributedString(string: "Текущий баланс",
                                                        attributes: [NSAttributedString.Key.kern: 0.19])
        return view
    }()
    
    private lazy var balanceLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeueCyr-Black",
                           size: 24)
        view.textAlignment = .right
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        createTitleLabel(title: "Доходы")
    }()
    
    private lazy var sumLabel: UILabel = {
        createFieldDescriptionTextField(title: "Сумма")
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BasketTableViewCell.self,
                           forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    private lazy var addIncomeButton: UIButton = {
        createButton(title: "Добавить доход",
                     action: #selector(pressAddIncomeButton))
    }()
    
    private lazy var addSumButton: UIButton = {
        createDisabledButton(title: "Добавить доход",
                             action: #selector(pressAddSumButton))
    }()
    
    private lazy var viewAddIncome: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .white
        addToViewAddIncome(view)
        addConstraintToView(view)
        return view
    }()
    
    private lazy var lineView: UIView = {
        createLine()
    }()
    
    private lazy var addSumTextField: UITextField = {
        createTextField(placeholder: "Сумма",
                        keyboardType: .numberPad)
    }()
    
    private lazy var emptyTextField: UITextField = {
        createEmptyTextField(keyboardType: .numberPad)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BasketViewModel()
        addToView()
        addConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showBalance()
    }
    
    private func addToView() {
        view.addSubview(addIncomeButton)
        view.addSubview(emptyTextField)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(currentBalanceLabel)
        view.addSubview(balanceLabel)
        view.addSubview(blur)
    }
    
    private func addToViewAddIncome(_ view: UIView) {
        view.addSubview(addSumTextField)
        view.addSubview(addSumButton)
        view.addSubview(sumLabel)
        view.addSubview(lineView)
    }
    
    private func addConstraint() {
        currentBalanceLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentBalanceLabel.snp.bottom).offset(25)
        }
        
        addIncomeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(56)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(9)
            make.bottom.equalTo(addIncomeButton.snp.top).offset(-43)
        }
        
        blur.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addConstraintToView(_ view: UIView) {
        sumLabel.snp.makeConstraints { make in
            make.bottom.equalTo(addSumTextField.snp.top).inset(2)
            make.left.right.equalTo(view).inset(20)
        }
        addSumTextField.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.bottom.equalTo(lineView.snp.top).offset(-16)
            make.height.equalTo(19)
        }
        addSumButton.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.bottom.equalTo(view).inset(28)
            make.height.equalTo(48)
        }
        lineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(0.5)
            make.bottom.equalTo(addSumButton.snp.top).offset(-21)
        }
    }
    
    private func addAViewToMainView(_ size: CGFloat) {
        viewAddIncome.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(168)
            make.bottom.equalToSuperview().offset(size)
        }
    }
    
    private func showBalance() {
        viewModel?.withdrawalOfCurrentBalance()
        viewModel?.accountBalanceLabel.bind { [weak self] text in
            self?.balanceLabel.text = text
        }
    }
    
    private func addTextFieldObservers() {
        addSumTextField.addTarget(self,
                                  action: #selector(editingChanged(_:)),
                                  for: .editingChanged)
        addSumTextField.addTarget(self,
                                  action: #selector(editingEnded(_:)),
                                  for: .editingDidEnd)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbDidShow),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbDidHide),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    @IBAction func editingChanged(_ textField: UITextField) {
        sumLabel.isHidden = false
        guard let text = textField.text,
              let _ = Int(text) else { return }
        addSumButton.isEnabled = true
        addSumButton.backgroundColor = UIColor(red: 0,
                                               green: 0.478,
                                               blue: 1,
                                               alpha: 1)
    }
    
    @IBAction func editingEnded(_ textField: UITextField) {
        addSumTextField.text = nil
        addSumButton.isEnabled = false
        addSumButton.backgroundColor = #colorLiteral(red: 0.4964438081, green: 0.7357916236, blue: 0.9985125661, alpha: 1)
        sumLabel.isHidden = false
    }
    
    @IBAction func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        addAViewToMainView(-kbFrameSize.height)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewAddIncome.alpha = 1
            self?.blur.isHidden = false
        }
    }
    
    @IBAction func kbDidHide() {
        viewAddIncome.removeFromSuperview()
    }
    
    @IBAction func pressAddSumButton() {
        guard let text = addSumTextField.text else { return }
        view.endEditing(true)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewAddIncome.alpha = 0
            self?.blur.isHidden = true
        }
        sumLabel.isHidden = true
        viewModel?.replenishmentOfBalance(sum: text)
        showBalance()
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func pressAddIncomeButton() {
        addTextFieldObservers()
        view.addSubview(viewAddIncome)
        emptyTextField.becomeFirstResponder()
    }
}
