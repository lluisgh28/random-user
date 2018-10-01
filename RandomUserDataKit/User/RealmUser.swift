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

    @objc dynamic var firstName: String? = nil
    @objc dynamic var lastName: String? = nil

    @objc dynamic var gender: String? = nil
    @objc dynamic var email: String? = nil
    @objc dynamic var phone: String? = nil

    @objc dynamic var street: String? = nil
    @objc dynamic var city: String? = nil
    @objc dynamic var state: String? = nil

    @objc dynamic var largePictureURLString: String? = nil
    @objc dynamic var mediumPictureURLString: String? = nil
    @objc dynamic var thumbnailPictureURLString: String? = nil

    @objc dynamic var registrationDate: Date? = nil
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

