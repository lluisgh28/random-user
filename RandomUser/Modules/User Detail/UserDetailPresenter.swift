//
//  UserDetailPresenter.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 01/10/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RandomUserDomainKit

protocol UserDetailViewControllerInterface: class {

    func update(with viewModel: UserDetail.ViewModel)
}

class UserDetailPresenter: UserDetailPresenterInterface {

    weak var viewController: UserDetailViewControllerInterface?

    private let dateFormatter = DateFormatter()

    init() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
    }

    func present(_ state: UserDetail.State) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else { return }

            let viewModel = strongSelf.makeViewModel(state: state)

            DispatchQueue.main.async {
                strongSelf.viewController?.update(with: viewModel)
            }
        }
    }

    private func makeViewModel(state: UserDetail.State) -> UserDetail.ViewModel {

        return UserDetail.ViewModel(
            title: state.user.fullName ?? "-",
            header: makeHeaderViewModel(user: state.user),
            sections: makeSections(user: state.user)
        )
    }

    private func makeHeaderViewModel(user: User) -> UserHeaderViewModel {

        return UserHeaderViewModel(
            pictureURL: user.largePictureURL,
            name: user.fullName ?? "-"
        )
    }

    private func makeSections(user: User) -> [UserDetail.ViewModel.Section] {

        return [
            makeBasicInfoSection(user: user),
            makeContactInfoSection(user: user),
            makeLocationInfoSection(user: user)
        ]
    }

    private func makeBasicInfoSection(user: User) -> UserDetail.ViewModel.Section {

        return UserDetail.ViewModel.Section(
            title: "Basic",
            cells: [
                UserDetailCellViewModel(title: "Gender", text: user.gender?.capitalized ?? "-"),
                UserDetailCellViewModel(title: "Registered", text: makeRegisteredText(date: user.registrationDate))
            ]
        )
    }

    private func makeRegisteredText(date: Date?) -> String {
        guard let date = date else { return "-" }

        return dateFormatter.string(from: date)
    }

    private func makeContactInfoSection(user: User) -> UserDetail.ViewModel.Section {

        return UserDetail.ViewModel.Section(
            title: "Contact",
            cells: [
                UserDetailCellViewModel(title: "Phone", text: user.phone ?? "-"),
                UserDetailCellViewModel(title: "Email", text: user.email?.capitalized ?? "-")
            ]
        )
    }

    private func makeLocationInfoSection(user: User) -> UserDetail.ViewModel.Section {

        return UserDetail.ViewModel.Section(
            title: "Location",
            cells: [
                UserDetailCellViewModel(title: "Street", text: user.street?.capitalized ?? "-"),
                UserDetailCellViewModel(title: "City", text: user.city?.capitalized ?? "-"),
                UserDetailCellViewModel(title: "State", text: user.state?.capitalized ?? "-")
            ]
        )
    }
}
