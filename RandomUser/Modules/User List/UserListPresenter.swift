//
//  UserListPresenter.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RandomUserDomainKit

protocol UserListViewControllerInterface: class {
    
    func update(with viewModel: UserList.ViewModel)
}

class UserListPresenter: UserListPresenterInterface {
   
    weak var viewController: UserListViewControllerInterface?

    func present(_ state: UserList.State) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else { return }

            let viewModel = strongSelf.makeViewModel(state: state)

            DispatchQueue.main.async {
                strongSelf.viewController?.update(with: viewModel)
            }
        }
    }
    
    private func makeViewModel(state: UserList.State) -> UserList.ViewModel {
        let cells = state
            .users
            .map(makeCellViewModel(user:))
            .sorted(by: { $0.name < $1.name })

        return UserList.ViewModel(
            showLoading: state.isLoading,
            cells: cells,
            errorMessage: state.error?.localizedDescription
        )
    }
    
    private func makeCellViewModel(user: User) -> UserCellViewModel {
        
        return UserCellViewModel(
            name: makeFullNameText(firstName: user.firstName, lastName: user.lastName),
            email: user.email ?? "-",
            pictureURL: user.largePictureURL,
            phone: user.phone ?? "-",
            route: UserList.SupportedRoute.userDetail(user: user),
            deleteAction: UserList.SupportedAction.deleteUser(userId: user.id)
        )
    }
    
    private func makeFullNameText(firstName: String?, lastName: String?) -> String {
        if let firstName = firstName {
            if let lastName = lastName {
                return firstName + " " + lastName
            }
            
            return firstName
        } else if let lastName = lastName {
            return lastName
        } else {
            return "-"
        }
    }
}
