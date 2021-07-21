//
//  AuthViewController.swift
//  MobileUpGallery
//
//  Created by Александр on 21.07.2021.
//

import UIKit

class AuthViewController: UIViewController {
  
  private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      authService = SceneDelegate.shared().authService
    }
    
  @IBAction func signInTouch(_ sender: UIButton) {
    authService.wakeUpSession()
  }
  
}

