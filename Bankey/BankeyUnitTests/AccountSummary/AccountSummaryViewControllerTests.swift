//
//  AccountSummaryViewControllerTests.swift
//  BankeyUnitTests
//
//  Created by ibrahim AKPINAR on 24.02.2023.
//

import XCTest

@testable import Bankey

final class AccountSummaryViewControllerTests: XCTestCase {
    private var vc: AccountSummaryViewController!
    private var mockManager: MockProfileManager!
    
    override func setUp() {
        super.setUp()
        
        vc = AccountSummaryViewController()
        vc.loadViewIfNeeded()
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.1)
    }
    
    func testTitleAndMessageForDecodignError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Decoding Error", titleAndMessage.0)
        XCTAssertEqual("We could no process your request. Please try again.", titleAndMessage.1)
    }
    
    func testAlertForServerError() {
        mockManager.error = NetworkError.serverError
        vc.forceFetchProfileForTesting()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
    }
    
    func testAlertForDecofingError() {
        mockManager.error = NetworkError.decodingError
        vc.forceFetchProfileForTesting()
        
        XCTAssertEqual("Decoding Error", vc.errorAlert.title)
        XCTAssertEqual("We could no process your request. Please try again.", vc.errorAlert.message)
    }
}

fileprivate final class MockProfileManager: ProfileManagerProtocol {
    var profile: Profile?
    var error: NetworkError?
    
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Bankey.Profile, Bankey.NetworkError>) -> Void) {
        if error != nil {
            completion(.failure(error!))
            return
        }
        
        profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
        completion(.success(profile!))
    }
}

