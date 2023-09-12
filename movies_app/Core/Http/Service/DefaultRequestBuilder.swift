//
//  DefaultRequestBuilder.swift
//  movies_app
//
//  Created by Premiersoft on 11/09/23.
//

import Foundation


class DefaultRequestBuilder: RequestBuilder {
    func buildRequest(with endpoint: Endpoint, url: URL) -> URLRequest {
      
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        
        if let parameters = endpoint.parameters {
            switch parameters {
            case .dictionary(let dictionary):
                request.httpBody = try? JSONSerialization.data(withJSONObject: dictionary, options: .fragmentsAllowed)
            case .encodable(let encodable):
                request.httpBody = try? JSONEncoder().encode(encodable)
            }
            
        }
        return request
    }
    
    
}
