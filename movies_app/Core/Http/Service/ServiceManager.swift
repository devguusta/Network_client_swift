//
//  ServiceManager.swift
//  movies_app
//
//  Created by Premiersoft on 07/09/23.
//

import Foundation




class ServiceManager: NetworkLayer {
    
    
    static var shared: ServiceManager = ServiceManager()
    private var baseURL: String
    init(baseUrl: String? = nil) {
        if let baseUrl {
            self.baseURL = baseUrl
        } else if let baseUrlStringg = Bundle.main.infoDictionary?["BaseURL"] as? String {
            self.baseURL = baseUrlStringg
            
        } else {
            self.baseURL = ""
        }
    }
    
    var session: URLSession = URLSession.shared
    
    func request<T>(with urlString: String, method: HttpMethod, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard let url: URL = URL(string: urlString) else {
             completion(.failure(.invalidURL(url: urlString)
                                      )
            )
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let task = session.dataTask(with: request) {
            data, response, error in
            if let error {
                print("ERROR \(#function) Detalhe do erro: \(error.localizedDescription)")
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
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let object: T = try decoder.decode(T.self, from: data)
                print("SUCCESS -> \(#function)")
                completion(.success(object))
                
            } catch {
                print("ERROR -> \(#function)")
                completion(.failure(.decodingError(error)))
            }
            
        }
        task.resume()
    }
    
    func request2<T>(with endpoint: Endpoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let urlString = baseURL + endpoint.url
        guard let url: URL = URL(string: urlString) else {
             completion(.failure(.invalidURL(url: urlString)
                                      )
            )
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        let task = session.dataTask(with: request) {
            data, response, error in
            if let error {
                print("ERROR \(#function) Detalhe do erro: \(error.localizedDescription)")
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
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let object: T = try decoder.decode(T.self, from: data)
                print("SUCCESS -> \(#function)")
                completion(.success(object))
                
            } catch {
                print("ERROR -> \(#function)")
                completion(.failure(.decodingError(error)))
            }
            
        }
        task.resume()
    }
    
}