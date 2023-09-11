//
//  NetworkError.swift
//  movies_app
//
//  Created by Premiersoft on 07/09/23.
//

import Foundation


enum NetworkError: Error {
case invalidURL(url: String)
    case noData
    case invalidResponse
    case decodingError(Error)
    case networkFailure(Error)
}


extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL(let error):
            return "URL inválida \(error)"
        case .noData:
            return "Dados não recebidos da API."
        case .invalidResponse:
            return "Resposta inválida da API."
        case .decodingError(let error):
            return "Decodificação falhou: \(error.localizedDescription)"
        case .networkFailure(let error):
            return "Falha na rede: \(error.localizedDescription)"
        }
    }
}
