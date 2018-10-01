//
//  UserDetailPresenter.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 01/10/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation

protocol UserDetailViewControllerInterface: class {

    func update(with viewModel: UserDetail.ViewModel)
}

class UserDetailPresenter: UserDetailPresenterInterface {

    weak var viewController: UserDetailViewControllerInterface?

    func present(_ state: UserDetail.State) {

    }
}
