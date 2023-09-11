//
//  HomeServices.swift
//  movies_app
//
//  Created by Premiersoft on 24/08/23.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let usersList = try? JSONDecoder().decode(UsersList.self, from: jsonData)

import Foundation

// MARK: - UsersListElement
struct User: Codable {
    var id: Int?
    var name, username, email, phone: String?
}

typealias UsersList = [User]


class HomeServices{
    private var httpClient: ServiceManager?
    
    init(httpClient: ServiceManager? = ServiceManager.shared) {
        self.httpClient = httpClient
    }
    
    public func fetchRequest(completion: @escaping (Result<[User], NetworkError>) -> Void){
        let urlString: String = "users"
        
        var endpoint: Endpoint = Endpoint(url: urlString, method: HttpMethod.get, header: nil, parameters: nil)
     
        httpClient?.request2(with: endpoint, decodeType: UsersList.self){
            result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
                           
        
      
        
    }
}
