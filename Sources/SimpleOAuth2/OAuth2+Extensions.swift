//
//  OAuth2+Extensions.swift
//  SimpleOAuth2
//
//  Created by Hadi on 04/12/2020.
//

import Foundation

public extension OAuth2Credentials {
    private static let key = "OAuth2CredentialsKey"

    func save() {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(self)
        UserDefaults.standard.set(data, forKey: OAuth2Credentials.key)
    }
    
    static func load() -> OAuth2Credentials? {
        guard let credentialsData = UserDefaults.standard.data(forKey: key),
              let credentials = try? JSONDecoder.current.decode(OAuth2Credentials.self, from: credentialsData) else { return nil }
        return credentials
    }
}

extension OAuth2Request {
    func buildAuthURL() -> URL {
        let queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "redirect_uri", value: redirectUri),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: scopes.joined(separator: "+"))
        ]
        
        var components = URLComponents(string: authUrl)!
        components.queryItems = queryItems
        return components.url!
    }
    
    func buildTokenURL(code: String) -> URL {
        let queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "client_secret", value: clientSecret),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "redirect_uri", value: redirectUri)
        ]
        
        var components = URLComponents(string: tokenUrl)!
        components.queryItems = queryItems
        return components.url!
    }
}
