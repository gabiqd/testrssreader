//
//  NetworkResponse.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import WebKit

struct NetworkResponse {
    fileprivate var data: Data
    init(data: Data){
        self.data = data
    }
}

extension NetworkResponse {
    public func decode<T: Decodable>(_ type: T.Type) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch _ {
            return nil
        }
    }
}
