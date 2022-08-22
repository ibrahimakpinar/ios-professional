//
//  AppDelegate.swift
//  Bankey
//
//  Created by ibrahim AKPINAR on 29.07.2022.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let dummyViewController = DummyViewController()
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        onboardingContainerViewController.delegate = self
        loginViewController.delagate = self
   
        displayLogin()
        
        return true
    }
    
    private func displayLogin() {
        setRootViewController(loginViewController)
    }
    
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepareMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
    
    private func prepareMainView() {
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = appColor
    }
}

extension AppDelegate: LogoutDelegate {
    
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    
    func didLogin() {
        displayNextScreen()
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepareMainView()
        setRootViewController(mainViewController)
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
