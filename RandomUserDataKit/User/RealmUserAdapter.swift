//
//  RealmUserAdapter.swift
//  RandomUserDataKit
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RandomUserDomainKit

class RealmUserAdapter {
    
    func map(realmUser: RealmUser) -> User {

        return User(
            id: realmUser.id,
            firstName: realmUser.firstName,
            lastName: realmUser.lastName,
            gender: realmUser.gender,
            email: realmUser.email,
            phone: realmUser.phone,
            street: realmUser.street,
            city: realmUser.city,
            state: realmUser.state,
            largePictureURL: URL(string: realmUser.largePictureURLString),
            mediumPictureURL: URL(string: realmUser.mediumPictureURLString),
            thumbnailPictureURL: URL(string: realmUser.thumbnailPictureURLString),
            registrationDate: realmUser.registrationDate
        )
    }
}
