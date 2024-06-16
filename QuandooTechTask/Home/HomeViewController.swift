//
//  HomeViewController.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 25/02/2024.
//

import Combine
import UIKit

class HomeViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    private let tableView = UITableView()
    private let viewModel: HomeViewModel
    private var usersCancellables = Set<AnyCancellable>()
    private let loadingViewController = LoadingViewController()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Users"
        setUpTableView()
        configureRefreshControl()
        setUpFetchingData()
    }
    
    override func loadView() {
        super.loadView()
        view = tableView
    }
    
    private func setUpTableView() {
        tableView.backgroundColor = .black
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UserCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    private func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(handleRefreshControl),
            for: .valueChanged
        )
    }
    
    @objc func handleRefreshControl() {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.fetchUsers()
            self?.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func setUpFetchingData() {
        subscribeToFetchingStatus()
        viewModel.fetchUsers()
    }
    
    private func subscribeToFetchingStatus() {
        viewModel.fetchingClientsStatus.sink { [weak self] status in
            if status != .loading {
                self?.stopLoadingView()
            }
            switch status {
            case .loading:
                DispatchQueue.main.async {
                    self?.startLoadingView()
                }
            case .fetched:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .empty:
                DispatchQueue.main.async {
                    self?.createNoDataView()
                }
            case .error:
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        }
        .store(in: &usersCancellables)
    }
    
    private func createNoDataView() {
        let child = NoDataViewController()
        child.setTitle("No Users")
        child.buttonAction = { [weak self] in
            self?.viewModel.fetchUsers()
        }
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    private func startLoadingView() {
        addChild(loadingViewController)
        loadingViewController.view.frame = view.frame
        view.addSubview(loadingViewController.view)
        loadingViewController.didMove(toParent: self)
    }
    
    private func stopLoadingView() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingViewController.willMove(toParent: nil)
            self?.loadingViewController.view.removeFromSuperview()
            self?.loadingViewController.removeFromParent()
        }
    }
    
    private func showAlert() -> Void {
        let pleaseAssessAlert = UIAlertController(title: "Error", message: "Error", preferredStyle: .alert)
        pleaseAssessAlert.addAction(.init(title: "Dismiss", style: .cancel))
        present(pleaseAssessAlert, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CustomCell",
            for: indexPath
        ) as! UserCell
        let rowData = viewModel.users[indexPath.row]
        cell.configure(with: rowData)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowData = viewModel.users[indexPath.row]
        coordinator?.buildUserPostsController(userId: rowData.id)
    }
}
