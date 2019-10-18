//
//  GoogleService.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 17/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import GoogleSignIn

class GoogleService: NSObject {
    static var accessToken: String = ""
    
    func signIn() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signOut() {
        GIDSignIn.sharedInstance().signOut()
        GoogleService.accessToken = ""
    }
    
    func restorePreviousSignIn() {
        guard !GIDSignIn.sharedInstance().hasPreviousSignIn() else {
            GIDSignIn.sharedInstance().restorePreviousSignIn()
            return
        }
    }
    
    func setPresentingViewController(_ vc: UIViewController) {
        GIDSignIn.sharedInstance().presentingViewController = vc
    }
    
    func setDelegate() {
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func setScopes(scopes: [String]) {
        GIDSignIn.sharedInstance().scopes = scopes
    }
    
    func setAccessToken() {
        guard let accessToken = GIDSignIn.sharedInstance()?.currentUser.authentication.accessToken else {
            fatalError()
        }
        GoogleService.accessToken = accessToken
    }
    
    func setClientID(withID id: String) {
        GIDSignIn.sharedInstance().clientID = id
    }
    
    func handle(url: URL) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}

extension GoogleService: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("New or signed out user")
            } else {
                print(error.localizedDescription)
            }
            return
        }
        self.setAccessToken()
        
        let vc = SignInViewController.initFromNib()
        UIApplication.shared.keyWindow?
            .rootViewController = UINavigationController(rootViewController: vc)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        UIApplication.shared.keyWindow?.rootViewController = SignInViewController.initFromNib()
    }
}
