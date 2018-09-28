//
//  UserList.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RandomUserDomainKit

protocol Route {}
protocol Action {}

struct UserList {
 
    struct State {
        let users: [User]
        let isLoading: Bool
        let error: Error?
    }

    enum SupportedRoute: Route {
        case userDetail(user: User)
    }

    enum SupportedAction: Action {
        case viewWillAppear
        case loadMoreUsers
        case viewWillDisappear
        case deleteUser(userId: String)
    }

    struct ViewModel {
        
    }
}
