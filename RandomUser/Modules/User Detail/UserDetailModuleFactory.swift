//
//  UserDetailModuleFactory.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 01/10/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import UIKit
import RandomUserDomainKit

class UserDetailModuleFactory {

    func makeViewController(user: User) -> UIViewController {
        let presenter = UserDetailPresenter()
        let interactor = UserDetailInteractor(
            presenter: presenter
        )
        let router = UserDetailRouter()
        let viewController = UserDetailViewController(
            interactor: interactor, router: router
        )
        presenter.viewController = viewController
        router.viewController = viewController
//        viewController.title = user.name --> IN THE VC

        return viewController
    }
}
