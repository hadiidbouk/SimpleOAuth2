//
//  CredentialsView.swift
//  SimpleOAuth2
//
//  Created by Hadi on 04/12/2020.
//

import SwiftUI

struct CredentialsView: View {
    
    let credentials: OAuth2Credentials
    
    var dict: [String: String] {
        var dict = [String: String]()
        let mirror = Mirror(reflecting: credentials)
        for child in mirror.children {
            if let key = child.label {
                dict[key] = String(describing: child.value)
            }
        }
        return dict
    }
    
    var body: some View {
        ScrollView {
            VStack {
                if dict.isEmpty {
                    Text("No Credentials Found!")
                }

                ForEach(Array(dict), id: \.key) { item in
                    HStack(alignment: .top) {
                        Group {
                            Text(item.key)
                                .fontWeight(.bold)
                            Text(" : ")
                            Text(item.value)
                                .font(.caption)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    Divider()
                }
            }
        }
    }
}
