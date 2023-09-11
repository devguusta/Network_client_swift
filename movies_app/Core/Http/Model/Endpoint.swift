//
//  Endpoint.swift
//  movies_app
//
//  Created by Premiersoft on 11/09/23.
//

import Foundation


struct Endpoint {
    let url: String
    let method: HttpMethod
    let header: [String: String]?
    let parameters: Parameters?
    
    init(url: String, method: HttpMethod, header: [String : String]?, parameters: Parameters?) {
        self.url = url
        self.method = method
        self.header = header
        self.parameters = parameters
    }
}


enum Parameters {
    case dictionary([String: Any])
    case encodable(Encodable)
}
