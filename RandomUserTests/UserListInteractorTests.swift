//
//  UserListInteractorTests.swift
//  RandomUserTests
//
//  Created by Lluis Gomez Hernando on 01/10/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import XCTest
import RandomUserDomainKit
import RxSwift
@testable import RandomUser

private let lluisUser = User(id: "1", firstName: "Lluis", lastName: "Notmylastname", gender: "male", email: "notmyemail@gmail.com", phone: "677276177", street: "NotARealStreet", city: "Boston", state: "Massachusets", largePictureURL: nil, mediumPictureURL: nil, thumbnailPictureURL: nil, registrationDate: Date())

private let martaUser = User(id: "2", firstName: "Marta", lastName: "Herlastname", gender: "female", email: "heremail@hotmail.com", phone: "723654432", street: "HerStreet", city: "San Francisco", state: "California", largePictureURL: nil, mediumPictureURL: nil, thumbnailPictureURL: nil, registrationDate: Date().addingTimeInterval(-86400.0))

let davidUser = User(id: "3", firstName: "David", lastName: "Hislastname", gender: "male", email: "david@gmail.com", phone: "657765345", street: "Davidstrasse", city: "Hamburg", state: "Germany", largePictureURL: nil, mediumPictureURL: nil, thumbnailPictureURL: nil, registrationDate: Date().addingTimeInterval(-604800.0))

private class MockUserRepository: UserRepository {

    private let usersSubject = BehaviorSubject(value: [User]())

    var users = [User]() {
        didSet {
            usersSubject.onNext(users)
        }
    }

    func allUsers() -> Observable<[User]> {
        return usersSubject.asObservable()
    }

    func loadMoreUsers(limit: Int) -> Observable<Void> {
        if users.count == 0 {
            users = users + [lluisUser, martaUser]
            return .just(())
        } else {
            users = users + [davidUser]
            return .just(())
        }
    }

    func deleteUser(withId id: String) {
        users.removeAll(where: { $0.id == id } )
    }
}

private class MockListPresenter: UserListPresenterInterface {
    var state: UserList.State? = nil
    
    func present(_ state: UserList.State) {
        self.state = state
    }

}

class UserListInteractorTests: XCTestCase {

    private var interactor: UserListInteractor!
    private let presenter = MockListPresenter()
    private let repository = MockUserRepository()

    override func setUp() {
        interactor = UserListInteractor(presenter: presenter, userRepository: repository)
    }

    func testLoadAfterViewWillAppear() {
        interactor.dispatch(.viewWillAppear)
        waitFor(seconds: 0.1)
        assert(presenter.state!.users.count == 2)
    }

    func testLoadMoreUsersAfterViewDidAppear() {
        interactor.dispatch(.viewWillAppear)
        waitFor(seconds: 0.1)
        
        interactor.dispatch(.loadMoreUsers)
        waitFor(seconds: 0.1)
        assert(presenter.state!.users.count == 3)
    }

    func testFilterByMail() {
        interactor.dispatch(.viewWillAppear)
        waitFor(seconds: 0.1)
        assert(presenter.state!.users.contains(where: { $0.email.contains("hotmail") }))

        interactor.dispatch(.filter(text: "gmail"))
        waitFor(seconds: 0.1)
        assert(!presenter.state!.users.contains(where: { $0.email.contains("hotmail") }))
    }

    func testDeleteUser() {
        interactor.dispatch(.viewWillAppear)
        waitFor(seconds: 0.1)
        assert(presenter.state!.users.contains(where: { $0.id == "2" }))

        interactor.dispatch(.deleteUser(userId: "2"))
        waitFor(seconds: 0.1)
        assert(!presenter.state!.users.contains(where: { $0.id == "2" }))
    }
}

extension XCTestCase {
    func waitFor(seconds: Double) {
        let waitExpectation = expectation(description: "Wait")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: seconds + 0.1, handler: nil)
    }
}
