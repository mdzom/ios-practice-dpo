////
////  MainViewController.swift
////  CostAccounting
////
////  Created by Gennadij Pleshanov on 15.10.2022.
////
//
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let cellIdentifier = "MainCell"
    var viewModel: MainViewModelProtocol?
    
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
    
    private lazy var titleLabel: UILabel = {
        createTitleLabel(title: "Расходы")
    }()
    
    private lazy var nameLabel: UILabel = {
        createFieldDescriptionTextField(title: "Наименование")
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self,
                           forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    private lazy var addAnExpenseCategoryButton: UIButton = {
        createButton(title: "Добавить категорию расходов",
                     action: #selector(pressAddAnExpenseCategoryButton))
    }()
    
    private lazy var addCategoryButton: UIButton = {
        createDisabledButton(title: "Добавить категорию расходов",
                             action: #selector(pressAddCategoryButton))
    }()
    
    private lazy var viewAddCategory: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .white
        addToViewAddCategory(view)
        addConstraintToView(view)
        return view
    }()
    
    private lazy var lineView: UIView = {
        createLine()
    }()
    
    private lazy var addCategoryTextField: UITextField = {
        createTextField(placeholder: "Наименование",
                        keyboardType: .namePhonePad)
    }()
    
    private lazy var emptyTextField: UITextField = {
        createEmptyTextField(keyboardType: .namePhonePad)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        addToView()
        addConstraint()
        removeBackButtonTitle()
    }
    
    private func addToView() {
        view.addSubview(addAnExpenseCategoryButton)
        view.addSubview(emptyTextField)
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        view.addSubview(blur)
    }
    
    private func addToViewAddCategory(_ view: UIView) {
        view.addSubview(addCategoryTextField)
        view.addSubview(addCategoryButton)
        view.addSubview(nameLabel)
        view.addSubview(lineView)
    }
    
    private func addConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        addAnExpenseCategoryButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(77)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(13)
            make.bottom.equalTo(addAnExpenseCategoryButton.snp.top).offset(-60)
        }
        
        blur.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addConstraintToView(_ view: UIView) {
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(addCategoryTextField.snp.top).inset(2)
            make.left.right.equalTo(view).inset(20)
        }
        addCategoryTextField.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.bottom.equalTo(lineView.snp.top).offset(-16)
            make.height.equalTo(19)
        }
        addCategoryButton.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.bottom.equalTo(view).inset(28)
            make.height.equalTo(48)
        }
        lineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(0.5)
            make.bottom.equalTo(addCategoryButton.snp.top).offset(-21)
        }
    }
    
    private func addAViewToMainView(_ size: CGFloat) {
        viewAddCategory.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(168)
            make.bottom.equalToSuperview().offset(size)
        }
    }
    
    private func addTextFieldObservers() {
        addCategoryTextField.addTarget(self,
                                       action: #selector(editingChanged(_:)),
                                       for: .editingChanged)
        addCategoryTextField.addTarget(self,
                                       action: #selector(editingEnded(_:)),
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
    
    private func removeBackButtonTitle() {
        if #available(iOS 14.0, *) {
            navigationItem.backButtonDisplayMode = .minimal
        }
    }
    
    @IBAction func editingChanged(_ textField: UITextField) {
        nameLabel.isHidden = false
        guard let _ = textField.text else { return }
        addCategoryButton.isEnabled = true
        addCategoryButton.backgroundColor = UIColor(red: 0,
                                                    green: 0.478,
                                                    blue: 1,
                                                    alpha: 1)
    }
    
    @IBAction func editingEnded(_ textField: UITextField) {
        addCategoryTextField.text = nil
        addCategoryButton.isEnabled = false
        addCategoryButton.backgroundColor = #colorLiteral(red: 0.4964438081, green: 0.7357916236, blue: 0.9985125661, alpha: 1)
        nameLabel.isHidden = false
    }
    
    @IBAction func kbShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        addAViewToMainView(-kbFrameSize.height)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewAddCategory.alpha = 1
            self?.blur.isHidden = false
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func kbHide() {
        viewAddCategory.removeFromSuperview()
    }
    
    @IBAction func pressAddCategoryButton() {
        guard let text = addCategoryTextField.text else { return }
        view.endEditing(true)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewAddCategory.alpha = 0
            self?.blur.isHidden = true
        }
        nameLabel.isHidden = true
        viewModel?.addAnExpenseCategory(category: text, completion: { [weak self] in
            self?.tableView.reloadData()
        })
    }
    
    @IBAction func pressAddAnExpenseCategoryButton() {
        addTextFieldObservers()
        view.addSubview(viewAddCategory)
        emptyTextField.becomeFirstResponder()
    }
}
