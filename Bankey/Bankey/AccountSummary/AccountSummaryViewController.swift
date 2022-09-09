//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by ibrahim AKPINAR on 4.08.2022.
//

import UIKit

final class AccountSummaryViewController: UIViewController {
    
    // Request Models
    var profile: Profile?
    
    // View Models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    var accounts: [Account] = []
    
    var tableView = UITableView()
    let headerView = AccountSummaryHeaderView(frame: .zero)
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    lazy var logoutBarButtonIten: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
        
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Private Functions

private extension AccountSummaryViewController {
    
    func setup() {
        setupNavigationBar()
        setupTableView()
        setupTableViewHeader()
        //fecthAccounts()
        fetchDataAndLoadViews()
    }
    
    func setupTableView() {
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseIdentifierId)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableHeaderView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupTableViewHeader() {
        var size =  headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonIten
    }
}

// MARK: - UITableViewDataSource

extension AccountSummaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseIdentifierId, for: indexPath) as! AccountSummaryCell
        let account = accountCellViewModels[indexPath.row]
        cell.configure(with: account)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
}

// MARK: - UITableViewDelegate

extension AccountSummaryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Actions

extension AccountSummaryViewController {
    
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}

// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchDataAndLoadViews() {
        
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        fetchAccounts(forUserId: "1") { result in
              switch result {
              case .success(let accounts):
                  self.accounts = accounts
                  self.configureTableCells(with: accounts)
                  self.tableView.reloadData()
              case .failure(let error):
                  print(error.localizedDescription)
              }
          }
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(
                accountType: $0.type,
                accountName: $0.name,
                balance: $0.amount
            )
        }
    }
}
