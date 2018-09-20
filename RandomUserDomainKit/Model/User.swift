//
//  User.swift
//  RandomUserDomainKit
//
//  Created by Lluís Gómez on 20/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation

public struct User {
    public struct Name {
        let title: String
        let first: String
        let last: String
        
        public init(title: String, first: String, last: String) {
            self.title = title
            self.first = first
            self.last = last
        }
    }

    public struct Location {
        let street: String
        let city: String
        let state: String
        
        public init(street: String, city: String, state: String) {
            self.street = street
            self.city = city
            self.state = state
        }
    }

    public struct Picture {
        let large: URL?
        let medium: URL?
        let thumbnail: URL?
        
        public init(large: URL?, medium: URL?, thumbnail: URL?) {
            self.large = large
            self.medium = medium
            self.thumbnail = thumbnail
        }
    }

    public let id: String
    public let name: Name
    public let email: String
    public let picture: Picture
    public let phone: String
    public let gender: String
    public let location: Location
    public let registrationDate: Date
    
    public init(id: String, name: Name, email: String,
                picture: Picture, phone: String, gender: String,
                location: Location, registrationDate: Date) {
        
        self.id = id
        self.name = name
        self.email = email
        self.picture = picture
        self.phone = phone
        self.gender = gender
        self.location = location
        self.registrationDate = registrationDate
    }
}
