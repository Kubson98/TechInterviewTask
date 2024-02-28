//
//  UserPostsViewController.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 25/02/2024.
//

import Combine
import UIKit
import SwiftUI

class UserPostsViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    private let tableView = UITableView()
    private let viewModel: UserPostsViewModel
    private var postsCancellables = Set<AnyCancellable>()
    private let loadingViewController = SpinnerViewController()
    
    init(viewModel: UserPostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControl()
        fetchData()
        navigationItem.title = "Posts"
        let swiftUIView = UserPostView(viewModel: viewModel, backButtonTapped: { [weak self] in self?.coordinator?.back() })
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
    
    private func fetchData() {
        subscribeToFetchingPostsStatus()
        viewModel.fetchPosts()
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
            self?.viewModel.fetchPosts()
            self?.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
    }
    
    @objc func backButtonTapped() {
        coordinator?.back()
    }
    
    private func subscribeToFetchingPostsStatus() {
        viewModel.fetchingPostsStatus.sink { [weak self] status in
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
        .store(in: &postsCancellables)
    }
    
    private func createNoDataView() {
        let child = NoDataViewController()
        child.setTitle("No Posts")
        child.buttonAction = { [weak self] in
                self?.viewModel.fetchPosts()
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

extension UserPostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        if let rowData = viewModel.postRowData(at: indexPath.row) {
            cell.configure(with: rowData)
        }
        return cell
    }
}

