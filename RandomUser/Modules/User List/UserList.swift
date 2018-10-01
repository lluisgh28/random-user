//
//  UserList.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RandomUserDomainKit

struct UserList {
 
    struct State {
        let users: [User]
        let isLoading: Bool
        let error: Error?
        
        init(users: [User], isLoading: Bool, error: Error?) {
            self.users = users
            self.isLoading = isLoading
            self.error = error
        }
    }

    enum SupportedRoute: Route {
        case userDetail(user: User)
    }

    enum SupportedAction: Action {
        case viewWillAppear
        case loadMoreUsers
        case viewWillDisappear
        case deleteUser(userId: String)
        case filter(text: String)
    }

    struct ViewModel {
        let showLoading: Bool
        let cells: [UserCellViewModel]
        let errorMessage: String?
        
        init(showLoading: Bool, cells: [UserCellViewModel], errorMessage: String?) {
            self.showLoading = showLoading
            self.cells = cells
            self.errorMessage = errorMessage
        }
    }
}
