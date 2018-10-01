//
//  UserDetailInteractor.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 01/10/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RandomUserDomainKit

protocol UserDetailPresenterInterface {
    func present(_ state: UserDetail.State)
}

class UserDetailInteractor: UserDetailInteractorInterface {

    private let presenter: UserDetailPresenterInterface
    private let user: User

    init(presenter: UserDetailPresenterInterface, user: User) {
        self.presenter = presenter
        self.user = user
    }

    func dispatch(_ action: UserDetail.SupportedAction) {

        switch action {
        case .viewWillAppear:
            presenter.present(UserDetail.State(user: user))
        case .viewWillDisappear:
            return
        }
    }
}
