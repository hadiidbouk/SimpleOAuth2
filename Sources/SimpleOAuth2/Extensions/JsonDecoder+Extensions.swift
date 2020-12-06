//
//  JsonDecoder+Extensions.swift
//  SimpleOAuth2
//
//  Created by Hadi on 04/12/2020.
//

import Foundation

extension JSONDecoder {
    static var current: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
