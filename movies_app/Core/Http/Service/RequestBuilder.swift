//
//  RequestBuilder.swift
//  movies_app
//
//  Created by Premiersoft on 11/09/23.
//

import Foundation

protocol RequestBuilder {
    func buildRequest(with endpoint: Endpoint, url: URL) -> URLRequest
}
