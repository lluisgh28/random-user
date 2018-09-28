//
//  UserListInteractor.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RandomUserDomainKit
import RxSwift


protocol UserListPresenterInterface {
    func present(_ state: UserList.State)
}

class UserListInteractor: UserListInteractorInterface {

    private let presenter: UserListPresenterInterface
    private let userRepository: UserRepository
    
    private var disposeBag: DisposeBag!
    
    private var state = UserList.State(users: [], isLoading: false, error: nil) {
        didSet {
            presenter.present(state)
        }
    }
    
    init(presenter: UserListPresenterInterface, userRepository: UserRepository) {
        self.presenter = presenter
        self.userRepository = userRepository
    }

    func dispatch(_ action: UserList.SupportedAction) {

        switch action {
        case .viewWillAppear:
            subscribe()
        case .loadMoreUsers:
            loadMoreUsers()
        case .viewWillDisappear:
            unsubscribe()
        case .deleteUser(let userId):
            userRepository.deleteUser(withId: userId)
        }
    }
    
    private func subscribe() {
        disposeBag = DisposeBag()
        presenter.present(state)
        
        userRepository
            .allUsers()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
            .subscribe(
                onNext: { [weak self] users in
                    self?.updateState(withUsers: users)
                    if users.isEmpty {
                        self?.loadMoreUsers()
                    }
                },
                onError: { [weak self] error in
                    self?.updateState(withError: error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func loadMoreUsers() {
        guard !state.isLoading else { return }

        updateState(withIsLoading: true)
        
        userRepository
            .loadMoreUsers(limit: 20)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
            .subscribe(
                onNext: { [weak self] in
                    self?.updateState(withIsLoading: false)
                },
                onError: { [weak self] error in
                    self?.updateState(withError: error)
                }
            )
            .disposed(by: disposeBag)

    }
    
    private func unsubscribe() {
        disposeBag = nil
    }
    
    private func updateState(withUsers users: [User]) {
        state = state.withUsers(users)
    }

    private func updateState(withError error: Error?) {
        state = state.withError(error)
    }
    
    private func updateState(withIsLoading isLoading: Bool) {
        state = state.withIsLoading(isLoading)
    }
}

extension UserList.State {
    
    func withUsers(_ users: [User]) -> UserList.State {
        
        return UserList.State(
            users: users,
            isLoading: isLoading,
            error: error
        )
    }
    
    func withIsLoading(_ isLoading: Bool) -> UserList.State {
        
        return UserList.State(
            users: users,
            isLoading: isLoading,
            error: error
        )
    }
    
    func withError(_ error: Error?) -> UserList.State {
        
        return UserList.State(
            users: users,
            isLoading: isLoading,
            error: error
        )
    }

}
