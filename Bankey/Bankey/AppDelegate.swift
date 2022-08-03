//
//  AppDelegate.swift
//  Bankey
//
//  Created by ibrahim AKPINAR on 29.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let dummyViewController = DummyViewController()
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        onboardingContainerViewController.delegate = self
        loginViewController.delagate = self
        dummyViewController.logoutDelegate = self
        window?.rootViewController = loginViewController
        
        return false
    }
}

extension AppDelegate: LogoutDelegate {
    
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(dummyViewController)
            
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(dummyViewController)
    }
}

extension AppDelegate {
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}
