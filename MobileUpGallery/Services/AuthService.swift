//
//  AuthService.swift
//  MobileUpGallery
//
//  Created by Александр on 21.07.2021.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
  func authServiceShouldShow(viewController: UIViewController)
  func authServiceSignIn()
  func authServiceSignInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
  
  private let appId = "7907238"
  private let vkSdk: VKSdk
  
  override init () {
    vkSdk = VKSdk.initialize(withAppId: appId)
    super.init()
    vkSdk.register(self)
    vkSdk.uiDelegate = self
  }
  
  weak var delegate: AuthServiceDelegate?
  
  func wakeUpSession() {
    let scope = ["offline"]
    VKSdk.wakeUpSession(scope) { state, error in
      switch state {
      
      case .initialized:
        print("initialized")
        VKSdk.authorize(scope)
      case .authorized:
        print("authorized")
      default:
        fatalError(error?.localizedDescription ?? "")
      }
    }
  }
  
  func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
    if result.token != nil {
      delegate?.authServiceSignIn()
    }
  }
  
  func vkSdkUserAuthorizationFailed() {
    delegate?.authServiceSignInDidFail()
  }
  
  func vkSdkShouldPresent(_ controller: UIViewController!) {
    delegate?.authServiceShouldShow(viewController: controller)
  }
  
  func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    print("vkSdkNeedCaptchaEnter")
  }
}
