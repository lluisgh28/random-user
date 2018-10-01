//
//  RealmUser.swift
//  RandomUserDataKit
//
//  Created by Lluis Gomez Hernando on 26/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @objc dynamic var id: String = ""

    @objc dynamic var firstName: String = "-"
    @objc dynamic var lastName: String = "-"

    @objc dynamic var gender: String = "-"
    @objc dynamic var email: String = "-"
    @objc dynamic var phone: String = "-"

    @objc dynamic var street: String = "-"
    @objc dynamic var city: String = "-"
    @objc dynamic var state: String = "-"

    @objc dynamic var largePictureURLString: String = "-"
    @objc dynamic var mediumPictureURLString: String = "-"
    @objc dynamic var thumbnailPictureURLString: String = "-"

    @objc dynamic var registrationDate: Date = Date()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

