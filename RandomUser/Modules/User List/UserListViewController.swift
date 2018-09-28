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

    private let interactor: UserListInteractorInterface
    private let router: UserListRouterInterface

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

    }
    
    func update(with viewModel: UserList.ViewModel) {
        
    }

}
