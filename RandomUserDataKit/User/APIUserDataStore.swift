//
//  APIUserDataStore.swift
//  RandomUserDataKit
//
//  Created by Lluis Gomez Hernando on 27/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import Alamofire

typealias JSON = [String: Any]
typealias JSONUser = [String: Any]

enum APIUserDataStoreError: Error {
    case RequestInvalid
    case ResponseInvalid
}

class APIUserDataStore {

    func getUsers(limit: Int) -> Observable<[JSONUser]> {
        guard let request = makeRequest(limit: limit) else {
            return Observable.error(APIUserDataStoreError.RequestInvalid)
        }
        
        return RxAlamofire
            .requestJSON(request)
            .map(parseGetUsersResponse(response: json:))
    }
    
    private func makeRequest(limit: Int) -> URLRequest? {
        
        return try? RxAlamofire.urlRequest(
            .get,
            "http://api.randomuser.me",
            parameters: ["results": limit],
            encoding: URLEncoding.queryString,
            headers: nil
        )
    }
    
    private func parseGetUsersResponse(response: HTTPURLResponse, json: Any) throws -> [JSONUser] {
        guard let json = json as? JSON else { throw APIUserDataStoreError.ResponseInvalid }
        guard let userlist = json["results"] as? [JSONUser] else { throw APIUserDataStoreError.ResponseInvalid }
        
        return userlist
    }

}
