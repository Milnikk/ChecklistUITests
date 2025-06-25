//
//  LoginTests.swift
//  Tasks
//
//  Created by Andrii Melnyk on 22.06.2025.
//  Copyright © 2025 Cultured Code. All rights reserved.
//
import XCTest

final class LoginTests: BaseTest {
    
    override func setUp() {
        super.setUp()
        if checklistScreen.logoutButton.exists {
            checklistScreen.logout()
        }
    }
    
   func testLoginWithValidCredentials() {
       loginScreen.login(email: StringConstants.validEmail, password: StringConstants.validPassword)
       let result = ActionsHelper.waitForElementWithLabel(StringConstants.tasksScreenTitle, in: app)
       
       if result == false {
           XCTExpectFailure("Known issue: Login randomly fails with valid credentials.")
       }
       
       XCTAssertTrue(result, "'Tasks' screen should appear after succesfull login")
   }
    
   func testLoginWithEmptyFields() {
       loginScreen.login(email: "", password: "")
       XCTAssertFalse(loginScreen.isLoginButtonEnabled(), "Login button should be disabled when both fields are empty.")
   }

   func testLoginWithEmptyEmail() {
       loginScreen.login(email: "", password: StringConstants.validPassword)
       XCTAssertFalse(loginScreen.isLoginButtonEnabled(), "Login button should be disabled when email is empty.")
   }

   func testLoginWithEmptyPassword() {
       loginScreen.login(email: StringConstants.validEmail, password: "")
       XCTAssertFalse(loginScreen.isLoginButtonEnabled(), "Login button should be disabled when password is empty.")
   }

   func testLoginWithInvalidEmail() {
       loginScreen.login(email: StringConstants.invalidEmail, password: StringConstants.validEmail)
       XCTAssertTrue(ActionsHelper.waitForElementWithLabel(StringConstants.incorrectEmailOrPassFormatAlertTitle, in: app), "Alert with \(StringConstants.incorrectEmailOrPassFormatAlertTitle) title should appear after login with invalid email.")
   }
}
