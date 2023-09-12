//
//  ServiceManager.swift
//  movies_app
//
//  Created by Premiersoft on 07/09/23.
//

import Foundation




class ServiceManager: NetworkLayer {
    
    
    static  var shared: ServiceManager = ServiceManager()
    private final var baseURL: String
    private final var requestBuilder: RequestBuilder
    private final var decoder: JSONDecoder
    
    private  var session: URLSession
    
    init(session: URLSession = URLSession.shared, baseUrl: String? = nil, requestBuilder: RequestBuilder = DefaultRequestBuilder(), decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.requestBuilder = requestBuilder
        self.decoder = decoder
        if let baseUrl {
            self.baseURL = baseUrl
        } else if let baseUrlStringg = Bundle.main.infoDictionary?["BaseURL"] as? String {
            self.baseURL = baseUrlStringg
            
        } else {
            self.baseURL = ""
        }
    }
    
    
    
    
    func request<T>(with endpoint: Endpoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let urlString = baseURL + endpoint.url
        guard let url: URL = URL(string: urlString) else {
            NetworkLogger.logError(error: .invalidURL(url: urlString))
            completion(.failure(.invalidURL(url: urlString)
                               )
            )
            return
        }
        let request = requestBuilder.buildRequest(with: endpoint, url: url)
        
        let task = session.dataTask(with: request) {
            data, response, error in
            NetworkLogger.log(request: request, response: response, data: data, error: error)
            if let error {
                
                completion(.failure(.networkFailure(error)))
                return
            }
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                
                let object: T = try self.decoder.decode(T.self, from: data)
                
                completion(.success(object))
                
            } catch {
                
                completion(.failure(.decodingError(error)))
            }
            
        }
        task.resume()
    }
    
    
}
