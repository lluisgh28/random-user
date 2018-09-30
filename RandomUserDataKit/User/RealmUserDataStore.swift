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
        guard let idJSON = JSON["id"] as? JSON,
            let id = idJSON["value"] as? String,
            let gender = JSON["gender"] as? String,
            let email = JSON["email"] as? String,
            let phone = JSON["phone"] as? String,
            let nameJSON = JSON["name"] as? JSON,
            let firstName = nameJSON["first"] as? String,
            let lastName = nameJSON["last"] as? String,
            let locationJSON = JSON["location"] as? JSON,
            let street = locationJSON["street"] as? String,
            let city = locationJSON["city"] as? String,
            let state = locationJSON["state"] as? String,
            let pictureJSON = JSON["picture"] as? JSON,
            let largePicture = pictureJSON["large"] as? String,
            let mediumPicture = pictureJSON["medium"] as? String,
            let thumbnailPicture = pictureJSON["thumbnail"] as? String,
            let registrationJSON = JSON["registered"] as? JSON,
            let dateString = registrationJSON["date"] as? String,
            let registrationDate = dateFormatter.date(from: dateString)
        else {
            return nil
        }

        
        let user = RealmUser()
        user.id = id
        user.firstName = firstName
        user.lastName = lastName
        user.gender = gender
        user.email = email
        user.phone = phone
        user.street = street
        user.city = city
        user.state = state
        user.largePictureURLString = largePicture
        user.mediumPictureURLString = mediumPicture
        user.thumbnailPictureURLString = thumbnailPicture
        user.registrationDate = registrationDate

        return user
    }
}
