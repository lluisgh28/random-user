//
//  UserListPresenter.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation

protocol UserListViewControllerInterface: class {
    
    func update(with viewModel: UserList.ViewModel)
}

class UserListPresenter: UserListPresenterInterface {
   
    weak var viewController: UserListViewControllerInterface?

    func present(_ state: UserList.State) {

    }
}
