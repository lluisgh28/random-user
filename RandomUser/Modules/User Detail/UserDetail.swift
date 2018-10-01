//
//  UserDetail.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 01/10/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RandomUserDomainKit

struct UserDetail {

    struct State {
        let user: User

        init(user: User) {
            self.user = user
        }
    }

    enum SupportedRoute: Route {

    }

    enum SupportedAction: Action {
        case viewWillAppear
        case viewWillDisappear
    }

    struct ViewModel {
        struct Section {
            let title: String
            let cells: [UserDetailCellViewModel]

            init(title: String, cells: [UserDetailCellViewModel]) {
                self.title = title
                self.cells = cells
            }
        }

        let title: String
        let header: UserHeaderViewModel
        let sections: [Section]

        init(title: String, header: UserHeaderViewModel, sections: [Section]) {
            self.title = title
            self.header = header
            self.sections = sections
        }
    }
}

struct UserDetailCellViewModel {
    let title: String
    let text: String

    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
}
