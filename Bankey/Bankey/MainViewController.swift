//
//  MainViewController.swift
//  Bankey
//
//  Created by ibrahim AKPINAR on 4.08.2022.
//

import UIKit

final class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBar()
    }
    
}

private extension MainViewController {
    
    func setupViews() {
        let accountSummaryVC = AccountSummaryViewController()
        let moveMoneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()
        
        accountSummaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moveMoneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        let summaryNC = UINavigationController(rootViewController: accountSummaryVC)
        let moneyNC = UINavigationController(rootViewController: moveMoneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        summaryNC.navigationBar.barTintColor = appColor
        hideNavigationBarLine(summaryNC.navigationBar)
        
        let tabBarList = [summaryNC, moneyNC, moreNC]
        
        viewControllers = tabBarList
    }
    
    func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    func setupBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}

class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemPurple
    }
}
