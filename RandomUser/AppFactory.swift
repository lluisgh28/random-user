//
//  AppFactory.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RandomUserDataKit

class AppFactory {
    lazy var userRepository = UserDataStore()
    lazy var userListModuleFactory = UserListModuleFactory(userRepository: userRepository)
}
