//
//  OAuth2Error.swift
//  SimpleOAuth2
//
//  Created by Hadi on 04/12/2020.
//

import Foundation

public enum OAuth2Error: String, LocalizedError {
    case invalidRedirectUri
    
    public var localizedDescription: String {
        switch self {
        case .invalidRedirectUri: return "Invalid Redirect Uri"
        }
    }
}
