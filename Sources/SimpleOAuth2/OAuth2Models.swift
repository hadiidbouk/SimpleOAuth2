//
//  OAuth2Models.swift
//  SimpleOAuth2
//
//  Created by Hadi on 04/12/2020.
//

import Foundation

enum OAuth2Scope: String, CaseIterable {
    case api
    case readUser = "read_user"
    case readApi = "read_api"
    case readRepository = "read_repository"
    case writeRepository = "write_repository"
    case readRegistry = "read_registry"
    case writeRegistry = "write_registry"
    case sudo
    case openid
    case profile
    case email
}

struct OAuth2Credential: Codable {
    let accessToken: String
    let tokenType: String
    let refreshToken: String
    let scope: String
    let createdAt: Int
    let idToken: String
}

struct OAuth2Request {
    let authUrl: String
    let tokenUrl: String
    let clientId: String
    let redirectUri: String
    let clientSecret: String
    let scopes: [OAuth2Scope]
}
