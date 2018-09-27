//
//  UserRepository.swift
//  RandomUserDomainKit
//
//  Created by Lluis Gomez Hernando on 26/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RxSwift

public protocol UserRepository {
    func allUsers() -> Observable<[User]>
    func loadMoreUsers(limit: Int) -> Observable<Void>
    func deleteUser(withId id: String)
}
