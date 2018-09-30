//
//  RealmUserDataStore.swift
//  RandomUserDataKit
//
//  Created by Lluis Gomez Hernando on 26/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm
import RandomUserDomainKit

class RealmUserDataStore {

    private let realmAdapter = RealmUserAdapter()

    private let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    }
    
    func allUsers() -> Observable<[User]> {
        do {
            let realm = try Realm()
            let results = realm
                .objects(RealmUser.self)
            
            
            return Observable
                .array(from: results)
                .map { $0.map(self.realmAdapter.map(realmUser:)) }
            
        } catch (let error) {
            return Observable.error(error)
        }
    }
    
    func add(_ users: [JSONUser]) -> Observable<Void> {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(users.compactMap(makeRealmUser(JSON:)), update: true)
            }
            return Observable.just(())
        } catch (let error) {
            return Observable.error(error)
        }
    }
    
    private func makeRealmUser(JSON: JSONUser) -> RealmUser? {
        guard let idJSON = JSON["id"] as? JSON, let id = idJSON["value"] as? String else {
                return nil
        }
        
        let nameJSON = JSON["name"] as? JSON
        let locationJSON = JSON["location"] as? JSON
        let pictureJSON = JSON["picture"] as? JSON
        let registrationJSON = JSON["registered"] as? JSON
        
        let user = RealmUser()
        user.id = id
        user.firstName = nameJSON?["first"] as? String
        user.lastName = nameJSON?["last"] as? String
        user.gender = JSON["gender"] as? String
        user.email = JSON["email"] as? String
        user.phone = JSON["phone"] as? String
        user.street = locationJSON?["street"] as? String
        user.city = locationJSON?["city"] as? String
        user.state = locationJSON?["state"] as? String
        user.largePictureURLString = pictureJSON?["large"] as? String
        user.mediumPictureURLString = pictureJSON?["medium"] as? String
        user.thumbnailPictureURLString = pictureJSON?["thumbnail"] as? String
        let dateString = registrationJSON?["date"] as? String
        user.registrationDate = dateFormatter.date(from: dateString ?? "")

        return user
    }
}
