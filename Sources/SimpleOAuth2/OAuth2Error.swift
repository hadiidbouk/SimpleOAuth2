//
//  OAuth2Error.swift
//  SimpleOAuth2
//
//  Created by Hadi on 04/12/2020.
//

import Foundation

enum OAuth2Error: String, LocalizedError {
    case invalidRedirectUri
    
    var localizedDescription: String {
        switch self {
        case .invalidRedirectUri: return "Invalid Redirect Uri"
        }
    }
}
