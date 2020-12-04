//
//  ContentView.swift
//  Shared
//
//  Created by Hadi on 04/12/2020.
//

import Combine
import SwiftUI

struct ContentView: View {
    
    @State var authManager = OAuth2Manager()
    @State var cancellable: AnyCancellable?
    @State var credentials: OAuth2Credentials?
    
    let request: OAuth2Request = .init(authUrl: "",
                                       tokenUrl: "",
                                       clientId: "",
                                       redirectUri: "",
                                       clientSecret: "",
                                       scopes: OAuth2Scope.allCases)
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Login") {
                    cancellable = authManager.signIn(with: request)
                        .sink( receiveCompletion: { result in
                            switch result {
                            case .failure(let error):
                                print(error.localizedDescription)
                            default: break
                            }
                        }, receiveValue: { credentials in
                            self.credentials = credentials
                        })
                }
                
                if credentials != nil {
                    #if os(iOS)
                    Divider()
                    CredentialsView(credentials: credentials!)
                    #else
                    NavigationLink(destination: CredentialsView(credentials: credentials!),
                                   isActive: Binding(get: { credentials != nil },
                                                     set: { _ in })) {
                        Text("Credentials")
                    }
                    #endif
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
