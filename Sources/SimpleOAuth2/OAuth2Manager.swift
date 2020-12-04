//
//  OAuth2Manager.swift
//  SimpleOAuth2
//
//  Created by Hadi on 04/12/2020.
//

import AuthenticationServices
import Combine

class OAuth2Manager: NSObject, ASWebAuthenticationPresentationContextProviding {

    var subscriptions: [AnyCancellable] = []
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }

    func signIn(with request: OAuth2Request) -> Future<OAuth2Credential, Error> {
        return Future { [weak self] completion in
            guard let self = self else { return }
            guard let components = URLComponents(string: request.redirectUri),
                  let callbackScheme = components.scheme else {
                completion(.failure(OAuth2Error.invalidRedirectUri))
                return
            }

            self.requestAuth(url: request.buildAuthURL(), callbackScheme: callbackScheme)
                .flatMap { self.requestToken(for: request.buildTokenURL(code: $0)) }
                .sink { (result) in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    default: break
                    }
                } receiveValue: { credential in
                    completion(.success(credential))
                }
                .store(in: &self.subscriptions)
        }
    }
}

private extension OAuth2Manager {
    func requestAuth(url: URL, callbackScheme: String) -> Future<String, Error> {
        return Future { [weak self] finalCompletion in
            guard let self = self else { return }
            Future<URL, Error>  { completion in
                let authSession = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackScheme) { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    }
                }

                authSession.presentationContextProvider = self
                authSession.prefersEphemeralWebBrowserSession = true
                authSession.start()
            }.map { url -> String in
                guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                      let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
                    return ""
                }
                return code
            }
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    finalCompletion(.failure(error))
                default: break
                }
            } receiveValue: { code in
                finalCompletion(.success(code))
            }
            .store(in: &self.subscriptions)
        }
    }
    
    func requestToken(for url: URL) -> AnyPublisher<OAuth2Credential, Error> {
        var request =  URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: OAuth2Credential.self, decoder: JSONDecoder.current)
            .eraseToAnyPublisher()
    }
}
