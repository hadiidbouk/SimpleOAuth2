//
//  OAuth2Models.swift
//  SimpleOAuth2
//
//  Created by Hadi on 04/12/2020.
//

import Foundation

public struct OAuth2Credentials: Codable {
    let accessToken: String
    let tokenType: String
    let refreshToken: String
    let scope: String
    let createdAt: Int
    let idToken: String
}

public struct OAuth2Request {
    let authUrl: String
    let tokenUrl: String
    let clientId: String
    let redirectUri: String
    let clientSecret: String
    let scopes: [String]
    
    public init(authUrl: String,
                tokenUrl: String,
                clientId: String,
                redirectUri: String,
                clientSecret: String,
                scopes: [String]) {
        self.authUrl = authUrl
        self.tokenUrl = tokenUrl
        self.clientId = clientId
        self.redirectUri = redirectUri
        self.clientSecret = clientSecret
        self.scopes = scopes
    }
}
