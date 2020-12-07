# SimpleOAuth2

![workflow badge](https://github.com/hadiidbouk/SimpleOAuth2/workflows/Swift/badge.svg)
![version badge](https://img.shields.io/github/v/tag/hadiidbouk/SimpleOAuth2?label=Version)
![platform compatibility](https://img.shields.io/badge/Platform%20Compatibility-iOS%20%7C%20macOS-blue)

A simple implementation of OAuth2 in Swift using Combine and AuthenticationServices.

The goal of this package is to make it as simple as possible :)

## Installation

You can add SimpleOAuth2 to an Xcode project by adding it as a package dependency.

  1. From the **File** menu, select **Swift Packages › Add Package Dependency…**
  2. Enter "https://github.com/hadiidbouk/SimpleOAuth2" into the package repository URL text field

## Usage

You need to pass your client credentials to the signIn method using `OAuth2Request`

```swift
@State var cancellable: AnyCancellable?
let request: OAuth2Request = .init(authUrl: "",
                                   tokenUrl: "",
                                   clientId: "",
                                   redirectUri: "",
                                   clientSecret: "",
                                   scopes: [])
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
- Only Authorization Code flow supported since it's the recommended flow for native mobile apps.

## Coming soon
- Adding refresh function for refreshing your token (if needed).
