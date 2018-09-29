//
//  User.swift
//  RandomUserDomainKit
//
//  Created by Lluís Gómez on 20/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation

public struct User {
    public let id: String

    public let firstName: String?
    public let lastName: String?
    public let gender: String?
    public let email: String?
    public let phone: String?
    public let street: String?
    public let city: String?
    public let state: String?
    public let largePictureURL: URL?
    public let mediumPictureURL: URL?
    public let thumbnailPictureURL: URL?
    public let registrationDate: Date?
    
    public init(id: String, firstName: String?, lastName: String?, gender: String?,
                email: String?, phone: String?,
                street: String?, city: String?, state: String?,
                largePictureURL: URL?, mediumPictureURL: URL?, thumbnailPictureURL: URL?,
                registrationDate: Date?) {
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.email = email
        self.phone = phone
        self.street = street
        self.city = city
        self.state = state
        self.largePictureURL = largePictureURL
        self.mediumPictureURL = mediumPictureURL
        self.thumbnailPictureURL = thumbnailPictureURL
        self.registrationDate = registrationDate
    }
}
