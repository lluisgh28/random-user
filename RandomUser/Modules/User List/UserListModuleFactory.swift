//
//  UserListModuleFactory.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import UIKit
import RandomUserDomainKit

class UserListModuleFactory {
    
    private let userRepository: UserRepository

    private let userDetailModuleFactory: UserDetailModuleFactory

    init(userRepository: UserRepository, userDetailModuleFactory: UserDetailModuleFactory) {
        self.userRepository = userRepository
        self.userDetailModuleFactory = userDetailModuleFactory
    }
    
    func makeViewController() -> UIViewController {
        let presenter = UserListPresenter()
        let interactor = UserListInteractor(
            presenter: presenter,
            userRepository: userRepository
        )
        let router = UserListRouter(userDetailModuleFactory: userDetailModuleFactory)
        let viewController = UserListViewController(
            interactor: interactor, router: router
        )
        presenter.viewController = viewController
        router.viewController = viewController
        viewController.title = "Random User"

        return viewController
    }
}
