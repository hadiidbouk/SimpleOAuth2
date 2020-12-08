//
//  OAuth2Models.swift
//  SimpleOAuth2
//
//  Created by Hadi on 04/12/2020.
//

import Foundation

/// The Access Token Response
/// The only required property is the accessToken other properties are optional
/// Following the RFC 6749 OAuth 2.0 https://tools.ietf.org/html/rfc6749#section-5.1
public struct OAuth2Credentials: Codable {
    public let accessToken: String
    public let tokenType: String?
    public let refreshToken: String?
    public let scope: String?
    public let expiresIn: Int?
    
    enum CodingKeys: String, CodingKey {
        case accessToken
        case tokenType
        case refreshToken
        case scope
        case expiresIn, expires
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try container.decode(String.self, forKey: .accessToken)
        tokenType = try? container.decode(String.self, forKey: .tokenType)
        refreshToken = try? container.decode(String.self, forKey: .refreshToken)
        scope = try? container.decode(String.self, forKey: .scope)

        var expiresIn: Int?
        if let expires = try? container.decode(Int.self, forKey: .expires) {
           expiresIn = expires
        } else if let expires = try? container.decode(Int.self, forKey: .expiresIn) {
            expiresIn = expires
        }
        self.expiresIn = expiresIn
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accessToken, forKey: .accessToken)
        try? container.encode(tokenType, forKey: .tokenType)
        try? container.encode(refreshToken, forKey: .refreshToken)
        try? container.encode(scope, forKey: .scope)
        try? container.encode(expiresIn, forKey: .expiresIn)
    }
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
