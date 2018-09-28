//
//  UserListInteractor.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation

protocol UserListPresenterInterface {
    func present(_ state: UserList.State)
}

class UserListInteractor: UserListInteractorInterface {

    private let presenter: UserListPresenterInterface
    
    init(presenter: UserListPresenterInterface) {
        self.presenter = presenter
    }

    func dispatch(_ action: UserList.SupportedAction) {

    }

}
