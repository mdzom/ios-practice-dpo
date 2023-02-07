//
//  CategoriesOfExpensesViewController.swift
//  CostAccounting
//
//  Created by Gennadij Pleshanov on 15.10.2022.
//

import UIKit
import SnapKit

class CategoriesOfExpensesViewController: UIViewController {
    
    let cellIdentifier = "CategoriesOfExpensesCell"
    var viewModel: CategoriesOfExpensesViewModelProtocol?
    
    private lazy var blur: UIVisualEffectView = {
        createBlurEffect()
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        let view = createHeader(Int(tableView.frame.width))
        tableView.tableHeaderView = view
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoriesOfExpensesTableViewCell.self,
                           forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    private lazy var paymentScheduleButton: UIButton = {
        createButton(title: "График платежей",
                     action: #selector(pressPaymentScheduleButton))
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self,
                         action: #selector(pressButtonAdd),
                         for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus"),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 0,
                                         green: 0.478,
                                         blue: 1,
                                         alpha: 1)
        button.layer.cornerRadius = 28
        return button
    }()
    
    private lazy var addConsumptionButton: UIButton = {
        createDisabledButton(title: "Добавить расход",
                             action: #selector(pressAddConsumptionButton))
    }()
    
    private lazy var bottomLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeueCyr-Black",
                           size: 22)
        view.text = "Добавить расход"
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        createFieldDescriptionTextField(title: "Наименование")
    }()
    
    private lazy var sumLabel: UILabel = {
        createFieldDescriptionTextField(title: "Сумма")
    }()
    
    private lazy var firstLabel: UILabel = {
        createHeaderLabel(title: "На что")
    }()

    private lazy var secondLabel: UILabel = {
        createHeaderLabel(title: "Когда")
    }()
    
    private lazy var thirdLabel: UILabel = {
        createHeaderLabel(title: "Сколько")
    }()
    
    private lazy var viewAddConsumption: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .white
        addToViewAddConsumption(view)
        addConstraintToView(view)
        return view
    }()
    
    private lazy var longLineView: UIView = {
        createLine()
    }()
    
    private lazy var headerLine: UIView = {
        createLine()
    }()
    
    private lazy var shortLineViewFirst: UIView = {
        createLine()
    }()
    
    private lazy var shortLineViewSecond: UIView = {
        createLine()
    }()
    
    private lazy var addConsumptionNameTextField: UITextField = {
        createTextField(placeholder: "Наименование",
                        keyboardType: .namePhonePad)
    }()
    
    private lazy var addConsumptionSumTextField: UITextField = {
        createTextField(placeholder: "Сумма",
                        keyboardType: .numberPad)
    }()
    
    private lazy var emptyTextField: UITextField = {
        createEmptyTextField(keyboardType: .namePhonePad)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addToView()
        addConstraint()
        removeBackButtonTitle()
    }
    
    private func removeBackButtonTitle() {
        if #available(iOS 14.0, *) {
            navigationItem.backButtonDisplayMode = .minimal
        }
    }
    
    private func addToView() {
        view.addSubview(longLineView)
        view.addSubview(emptyTextField)
        view.addSubview(paymentScheduleButton)
        view.addSubview(tableView)
        view.addSubview(bottomLabel)
        view.addSubview(addButton)
        view.addSubview(blur)
    }
    
    private func createHeader(_ width: Int) -> UIView {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: width,
                                        height: 22))
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(thirdLabel)
        view.addSubview(headerLine)
        
        firstLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(view)
        }

        secondLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.top.equalTo(view)
        }

        thirdLabel.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-16)
            make.top.equalTo(view)
        }
        
        headerLine.snp.makeConstraints { make in
            make.width.equalTo(view)
            make.bottom.equalTo(view)
            make.height.equalTo(1)
        }
        return view
    }
    
    private func addToViewAddConsumption(_ view: UIView) {
        view.addSubview(nameLabel)
        view.addSubview(addConsumptionNameTextField)
        view.addSubview(shortLineViewFirst)
        view.addSubview(sumLabel)
        view.addSubview(addConsumptionSumTextField)
        view.addSubview(shortLineViewSecond)
        view.addSubview(addConsumptionButton)
    }
    
    private func addConstraint() {
        longLineView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        paymentScheduleButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(22)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(56)
            make.bottom.equalTo(bottomLabel.snp.top).offset(-7)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(paymentScheduleButton.snp.bottom).offset(31)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(addButton.snp.top).inset(-12)
        }
        
        blur.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addConstraintToView(_ view: UIView) {
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(view).inset(20)
            make.top.equalTo(view).inset(18)
        }
        
        addConsumptionNameTextField.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(19)
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
        }
        
        shortLineViewFirst.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(0.5)
            make.top.equalTo(addConsumptionNameTextField.snp.bottom).offset(16)
        }
        
        sumLabel.snp.makeConstraints { make in
            make.left.equalTo(view).inset(20)
            make.top.equalTo(shortLineViewFirst.snp.bottom).offset(9.5)
        }
        
        addConsumptionSumTextField.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(19)
            make.top.equalTo(sumLabel.snp.bottom).offset(2)
        }
        
        shortLineViewSecond.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(0.5)
            make.top.equalTo(addConsumptionSumTextField.snp.bottom).offset(16)
        }
        
        addConsumptionButton.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
                        make.bottom.equalTo(view).inset(21)
                        make.height.equalTo(48)
        }
    }
    
    private func addAViewToMainView(_ size: CGFloat) {
        viewAddConsumption.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(216)
            make.bottom.equalToSuperview().offset(size)
        }
    }
    
    private func addTextFieldObservers() {
        addConsumptionNameTextField.addTarget(self,
                                       action: #selector(editingNameChanged(_:)),
                                       for: .editingChanged)
        addConsumptionNameTextField.addTarget(self,
                                       action: #selector(editingNameEnded(_:)),
                                       for: .editingDidEnd)
        
        addConsumptionSumTextField.addTarget(self,
                                       action: #selector(editingSumChanged(_:)),
                                       for: .editingChanged)
        addConsumptionSumTextField.addTarget(self,
                                       action: #selector(editingSumEnded(_:)),
                                       for: .editingDidEnd)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbShow),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbHide),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    @IBAction func editingNameChanged(_ textField: UITextField) {
        nameLabel.isHidden = false
    }
    
    @IBAction func editingNameEnded(_ textField: UITextField) {
        addConsumptionButton.backgroundColor = #colorLiteral(red: 0.4964438081, green: 0.7357916236, blue: 0.9985125661, alpha: 1)
    }
    
    
    
    @IBAction func editingSumChanged(_ textField: UITextField) {
        sumLabel.isHidden = false
        guard let _ = textField.text else { return }
        addConsumptionButton.isEnabled = true
        addConsumptionButton.backgroundColor = UIColor(red: 0,
                                                    green: 0.478,
                                                    blue: 1,
                                                    alpha: 1)
    }
    
    @IBAction func editingSumEnded(_ textField: UITextField) {
        addConsumptionNameTextField.text = nil
        addConsumptionSumTextField.text = nil
        addConsumptionButton.backgroundColor = #colorLiteral(red: 0.4964438081, green: 0.7357916236, blue: 0.9985125661, alpha: 1)
        sumLabel.isHidden = false
        nameLabel.isHidden = false
    }
    
    @IBAction func kbShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        addAViewToMainView(-kbFrameSize.height)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewAddConsumption.alpha = 1
            self?.blur.isHidden = false
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func kbHide() {
        viewAddConsumption.removeFromSuperview()
    }

    @IBAction func pressAddConsumptionButton() {
        guard let name = addConsumptionNameTextField.text,
        let sumString = addConsumptionSumTextField.text,
        let sum = Int(sumString) else { return }
        view.endEditing(true)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewAddConsumption.alpha = 0
            self?.blur.isHidden = true
        }
        nameLabel.isHidden = true
        sumLabel.isHidden = true
        viewModel?.addExpense(name: name,
                              sum: sum,
                              completion: { [weak self] in
            self?.tableView.reloadData()
        })
    }
    
    @IBAction func pressButtonAdd() {
        addTextFieldObservers()
        view.addSubview(viewAddConsumption)
        emptyTextField.becomeFirstResponder()
    }
    
    @IBAction func pressPaymentScheduleButton() {
        guard let vc = viewModel?.paymentScheduleViewModel() else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
