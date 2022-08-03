//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by ibrahim AKPINAR on 2.08.2022.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

final class OnboardingContainerViewController: UIViewController {
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    
    var pages = [UIViewController]()
    var currentVC: UIViewController {
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else {
                return
            }
            nextButton.isHidden = index == pages.count - 1
            backButton.isHidden = index == 0
            doneButton.isHidden = !(index == pages.count - 1)
        }
    }
    
    let pageViewController: UIPageViewController
    let closeButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        pageViewController.view.isUserInteractionEnabled = false
        
        let page1 = OnboardingViewController(
            imageName: "delorean",
            titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989."
        )
        let page2 = OnboardingViewController(
            imageName: "world",
            titleText: "Move your money around the world quickly and securely."
        )
        let page3 = OnboardingViewController(
            imageName: "thumbs",
            titleText: "Learn more at www.bankey.com."
        )
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

// MARK: Private Functions

private extension OnboardingContainerViewController {
    
    func setup() {
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.setViewControllers(
            [pages.first!],
            direction: .forward,
            animated: false,
            completion: nil
        )
        currentVC = pages.first!
    }
    
    func style() {
        // Close Button
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(
            self,
            action: #selector(closeButtonTapped),
            for: .primaryActionTriggered
        )
        view.addSubview(closeButton)
        
        // Next Button
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(
            self,
            action: #selector(nextButtonTapped),
            for: .primaryActionTriggered
        )
        view.addSubview(nextButton)
        
        // Done Button
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(
            self,
            action: #selector(doneButtonTapped),
            for: .primaryActionTriggered
        )
        view.addSubview(doneButton)
        
        // Back Button
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: [])
        backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .primaryActionTriggered
        )
        view.addSubview(backButton)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        // Close Button
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
        
        // Next Button
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 8)
        ])
        
        // Done Button
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 8)
        ])
        
        // Back Button
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 8)
        ])
    }
}

// MARK: Actions

extension OnboardingContainerViewController {
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        guard let nextVC = getNextViewController(from: currentVC) else {
            return
        }
        pageViewController.setViewControllers(
            [nextVC],
            direction: .forward,
            animated: true,
            completion: nil
        )
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        guard let previousVC = getPreviousViewController(from: currentVC) else {
            return
        }
        pageViewController.setViewControllers(
            [previousVC],
            direction: .reverse,
            animated: true,
            completion: nil
        )
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else {
            return nil
        }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else {
            return nil
        }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}
