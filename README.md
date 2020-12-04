# SimpleOAuth2

A simple implementation of OAuth2 in Swift using Combine and AuthenticationServices.

The goal of this package is to make it as simple as possible :)

## Usage

You need to pass your client credentials to the signIn method using `OAuth2Request`

```swift
@State var cancellable: AnyCancellable?
let request: OAuth2Request = .init(authUrl: "",
                                   tokenUrl: "",
                                   clientId: "",
                                   redirectUri: "",
                                   clientSecret: "",
                                   scopes: OAuth2Scope.allCases) // `OAuth2Scope` contains all the scopes available.
Button(action: {
                cancellable = auth.signIn(with: request)
                    .sink( receiveCompletion: { result in
                        switch result {
                        case .failure(let error):
                            print(error.localizedDescription)
                        default: break
                        }
                    }, receiveValue: { credentials in
                        credentials.save()
                        print(credentials)
                    })
            }) {
                Text("Login with GitLab")
            }
```

You can also use `save()` function to save the `OAuth2Credentials` instance to your `UserDefaults` and load the credentials using this static function `OAuth2Credentials.load()`.


## About this package
- It will never be published on Cocoapods neither on Carthage.
- Only Authorization Code flow supported since it's the recommanded flow for native mobile apps.

## Comming soon
- Adding refresh function for refreshing your token (if needed).
