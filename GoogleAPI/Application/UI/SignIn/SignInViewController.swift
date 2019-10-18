//
//  SignInViewController.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 17/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var googleSignOutButton: UIButton!
    
    private let googleService = GoogleService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupServices()
        
        switchButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        googleSignInButton.layer.masksToBounds = true
        googleSignInButton.layer.cornerRadius = 6.0
        
        googleSignOutButton.layer.masksToBounds = true
        googleSignOutButton.layer.cornerRadius = 6.0
    }
    
    private func setupServices() {
        let driveFull = "https://www.googleapis.com/auth/drive"
        let sheetsFull = "https://www.googleapis.com/auth/spreadsheets"
        
        googleService.setPresentingViewController(self)
        googleService.setDelegate()
        googleService.setScopes(scopes: [driveFull, sheetsFull])
        googleService.restorePreviousSignIn()
    }
    
    private func switchButtons() {
        guard !GoogleService.accessToken.isEmpty else { return }
        
        googleSignInButton.isHidden = true
        googleSignOutButton.isHidden = false
    }
}

extension SignInViewController {
    @IBAction func signInButtonTapped(_ sender: Any?) {
        googleService.signIn()
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any?) {
        googleService.signOut()
        switchButtons()
    }
}
