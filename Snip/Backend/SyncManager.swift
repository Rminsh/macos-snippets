//
//  APIManager.swift
//  Snip
//
//  Created by Anthony Fernandez on 8/13/20.
//  Copyright © 2020 pictarine. All rights reserved.
//

import Foundation
import Combine
import KeychainAccess
import SwiftUI

class SyncManager: ObservableObject {
  
  public static let shared = SyncManager()
  
  private let keychainService = "com.pictarine.Snip"
  private let keychainAuthTokenKey = "oauth_github_key"
  
  @Published var isAuthenticated = false
  @Published var connectedUser : User?
  
  var stores: Set<AnyCancellable> = []
  var oauth : Oauth?
  
  var snippets : [SnipItem] = []
  
  private let callbackURL = "snip://callback"
  static let oauthURL = URL(string: "https://snip.picta-hub.io/github-auth")!
  
  func initialize() {
    
    let keychain = Keychain(service: keychainService)
    if let token = keychain[keychainAuthTokenKey] {
      
      oauth = Oauth(access_token: token)
      isAuthenticated = true
      
      DispatchQueue.global(qos: .utility).async { [weak self] in
        self?.requestUser()
      }
    }
  }
  
  func logout() {
    oauth = nil
    isAuthenticated = false
    connectedUser = nil
    
    do {
        let keychain = Keychain(service: keychainService)
        try keychain.remove(keychainAuthTokenKey)
    } catch let error {
        print("error: \(error)")
    }
  }
  
  func requestAccessToken(code: String, state: String) {
    requestToken(code: code, state: state)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { (completion) in
        if case let .failure(error) = completion {
          print(error)
        }
      }, receiveValue: { [weak self] (oauth) in
        
        guard let this = self else { return }
        
        print(oauth.access_token)
        this.oauth = oauth
        this.isAuthenticated = true
        this.requestUser()
        
        let keychain = Keychain(service: this.keychainService)
        keychain[this.keychainAuthTokenKey] = oauth.access_token
        
      })
      .store(in: &stores)
  }
  
  func requestUser() {
    getUser()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { (completion) in
        if case let .failure(error) = completion {
          print(error)
        }
      }, receiveValue: { [weak self] (user) in
        self?.connectedUser = user
      })
      .store(in: &stores)
  }
  
  func requestToken(code: String, state: String) -> AnyPublisher<Oauth, Error> {
    print(code)
    let bodyParams = [
      "redirect_uri": callbackURL,
      "code": code,
      "state": state
    ]
    
    return API.run(Endpoint.token, HttpMethod.post, [:], bodyParams, [:], oauth)
  }
  
  func getUser() ->  AnyPublisher<User, Error> {
    
    let headerParams = [
      "Accept": "application/vnd.github.v3+json"
    ]
    
    return API.run(Endpoint.user, HttpMethod.get, [:], [:], headerParams, oauth)
  }
  
  func createGist(title: String, code: String) -> AnyPublisher<Gist, Error> {
    
    let headerParams = [
      "Accept": "application/vnd.github.v3+json"
    ]
    
    let bodyParams = [
      "files": [
        title: [ "content": code ]
      ],
      "description": title,
      "public": "\(false)"
      ] as [String : Any]
    
    return API.run(Endpoint.createGist, HttpMethod.post, [:], bodyParams, headerParams, oauth)
  }
  
  func updateGist(id: String, title: String, code: String) -> AnyPublisher<Gist, Error> {
     
     let headerParams = [
       "Accept": "application/vnd.github.v3+json"
     ]
     
     let bodyParams = [
       "files": [
         title: [ "content": code ]
       ],
       "description": title,
       "public": "\(false)"
       ] as [String : Any]
     
     return API.run(Endpoint.updateGist(id: id), HttpMethod.patch, [:], bodyParams, headerParams, oauth)
   }
}
