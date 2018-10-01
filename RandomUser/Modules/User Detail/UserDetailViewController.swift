//
//  UserDetailViewController.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 01/10/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import UIKit

protocol UserDetailInteractorInterface {
    func dispatch(_ action: UserDetail.SupportedAction)
}

protocol UserDetailRouterInterface {
    func routeTo(_ route: UserDetail.SupportedRoute)
}

class UserDetailViewController: UIViewController, UserDetailViewControllerInterface {

    private let interactor: UserDetailInteractorInterface
    private let router: UserDetailRouterInterface

    private var viewModel: UserDetail.ViewModel?

    private var headerView: UserHeaderView!
    private let headerContainerView = UIView()
    private let tableView = UITableView(frame: .zero, style: .grouped)

    private let infoCellId = "InfoCell"

    init(interactor: UserDetailInteractorInterface, router: UserDetailRouterInterface) {
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

        interactor.dispatch(UserDetail.SupportedAction.viewWillAppear)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        interactor.dispatch(UserDetail.SupportedAction.viewWillDisappear)
    }

    private func setUpView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: infoCellId)
        tableView.allowsSelection = false
        headerView = UserHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 130))
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
    }

    private func setUpConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    func update(with viewModel: UserDetail.ViewModel) {
        self.viewModel = viewModel
        
        title = viewModel.title
        headerView.configure(with: viewModel.header)
        tableView.reloadData()
    }

}

extension UserDetailViewController: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {

            return viewModel?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionViewModel = viewModel?.sections[section] else { return 0 }

        return sectionViewModel.cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel?.sections[indexPath.section].cells[indexPath.row] else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: infoCellId, for: indexPath)
        cell.textLabel?.text = cellViewModel.text
        cell.detailTextLabel?.text = cellViewModel.title
        cell.detailTextLabel?.textColor = UIColor.darkGray

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionViewModel = viewModel?.sections[section] else { return nil }

        return sectionViewModel.title
    }
}
