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

    }

    func update(with viewModel: UserDetail.ViewModel) {

    }

}
