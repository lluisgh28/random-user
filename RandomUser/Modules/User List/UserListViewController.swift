//
//  UserListViewController.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import UIKit

protocol UserListInteractorInterface {
    func dispatch(_ action: UserList.SupportedAction)
}

protocol UserListRouterInterface {
    func routeTo(_ route: UserList.SupportedRoute)
}

class UserListViewController: UIViewController, UserListViewControllerInterface {
    private let userCellId = "UserCell"
    
    private let interactor: UserListInteractorInterface
    private let router: UserListRouterInterface

    private let tableView = UITableView()
    
    private var viewModel: UserList.ViewModel?
    
    init(interactor: UserListInteractorInterface, router: UserListRouterInterface) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor.dispatch(UserList.SupportedAction.viewWillAppear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        interactor.dispatch(UserList.SupportedAction.viewWillDisappear)
    }

    private func setUpView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: userCellId)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func setUpConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    func update(with viewModel: UserList.ViewModel) {
        self.viewModel = viewModel

        UIApplication.shared.isNetworkActivityIndicatorVisible = viewModel.showLoading
        //TODO: show loading and error states

        tableView.reloadData()
    }

}

extension UserListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        
        return viewModel?.cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            return makeUserCell(forRowAt: indexPath)
        case 1:
            return makeLoadMoreCell(forRowAt: indexPath)
        default:
            // Track, this should not happen
            return UITableViewCell()
        }
        
    }
    
    private func makeUserCell(forRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: userCellId, for: indexPath) as? UserTableViewCell,
            let cellViewModel = viewModel?.cells[indexPath.row]
            else {
                // Track, this should not happen
                return UITableViewCell()
        }
        
        cell.configure(with: cellViewModel)
        
        return cell
    }
    
    private func makeLoadMoreCell(forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Load more users"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)

        return cell
    }

}


extension UserListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            routeToDetail(ofUserAtRow: indexPath.row)
        case 1:
            interactor.dispatch(UserList.SupportedAction.loadMoreUsers)
        default:
            // Track, this should not happen
            return
        }
    }

    private func routeToDetail(ofUserAtRow row: Int) {
        guard let cellViewModel = viewModel?.cells[row] else { return }
        guard let route = cellViewModel.route as? UserList.SupportedRoute else { return }

        router.routeTo(route)
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard indexPath.section == 0 else { return [] }

        let delete = UITableViewRowAction(
            style: .destructive,
            title: "Delete",
            handler: deleteUser(afterRowAction: atIndexPath:)
        )

        return [delete]
    }

    private func deleteUser(afterRowAction: UITableViewRowAction, atIndexPath indexPath: IndexPath) {
        guard let cellViewModel = viewModel?.cells[indexPath.row] else { return }
        guard let deleteAction = cellViewModel.deleteAction as? UserList.SupportedAction else { return }

        interactor.dispatch(deleteAction)
    }
}
