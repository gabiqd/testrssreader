//
//  NetworkError.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

enum NetworkError: Error {
    case wrongBodyFormat
    case decodingError
    case requestError
    case nilDataResponseError
    case serverMessage(message: String)
    
    var message: String{
        switch self{
        case .wrongBodyFormat:
            return "Wrong body format"
        case .decodingError:
            return "We have an error decoding the response"
        case .requestError:
            return "An error doing the request ocurred"
        case .nilDataResponseError:
            return "We have received an empty response"
        case .serverMessage(let message):
            return message
        }
    }
}
