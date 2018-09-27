//
//  UserDataStore.swift
//  RandomUserDataKit
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RandomUserDomainKit
import RxSwift

public class UserDataStore: UserRepository {
    
    private let APIDataStore = APIUserDataStore()
    private let realmDataStore = RealmUserDataStore()
    
    private static let kDeletedIds = "DeletedUserIds"

    private let deletedIdsSubjet = BehaviorSubject<[String]>(value: UserDataStore.getDeletedIds())

    public init() {

    }
    
    public func allUsers() -> Observable<[User]> {

        return Observable
            .combineLatest(
                realmDataStore.allUsers(),
                deletedIdsSubjet.asObservable()
            )
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map({ (users, deletedIds) -> [User] in
                users.filter { !deletedIds.contains($0.id) }
            })
    }
    
    public func loadMoreUsers(limit: Int)  -> Observable<Void> {
        
        return APIDataStore
            .getUsers(limit: limit)
            .flatMap(realmDataStore.add(_:))
    }
    
    public func deleteUser(withId id: String) {
        let deletedIds = UserDataStore.getDeletedIds() + [id]
        UserDataStore.saveDeletedIds(deletedIds)
        deletedIdsSubjet.on(Event.next(deletedIds))
    }

    private static func getDeletedIds() -> [String] {

        return UserDefaults.standard.array(forKey: UserDataStore.kDeletedIds) as? [String] ?? []
    }

    private static func saveDeletedIds(_ deletedIds: [String]) {

        UserDefaults.standard.set(deletedIds, forKey: UserDataStore.kDeletedIds)
    }

}
