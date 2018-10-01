//
//  UserListRouter.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RandomUserDomainKit

class UserListRouter: UserListRouterInterface {
    
    weak var viewController: UserListViewController?

    private let userDetailModuleFactory: UserDetailModuleFactory

    init(userDetailModuleFactory: UserDetailModuleFactory) {
        self.userDetailModuleFactory = userDetailModuleFactory
    }

    func routeTo(_ route: UserList.SupportedRoute) {
        switch route {
        case .userDetail(let user):
            routeToUserDetail(with: user)
        }
    }

    private func routeToUserDetail(with user: User) {
        let detailViewController = userDetailModuleFactory.makeViewController(user: user)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
