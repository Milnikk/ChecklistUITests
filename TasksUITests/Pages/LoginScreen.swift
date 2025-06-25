//
//  LoginScreen.swift
//  Tasks
//
//  Created by Andrii Melnyk on 22.06.2025.
//  Copyright © 2025 Cultured Code. All rights reserved.
//

import XCTest

struct LoginScreen {
    let app: XCUIApplication

    var emailField: XCUIElement { app.textFields[StringConstants.emailPlaceholder] }
    var passwordField: XCUIElement { app.secureTextFields[StringConstants.passwordPlaceholder] }
    var loginButton: XCUIElement { app.buttons[StringConstants.loginButton] }

    func enterEmail(_ email: String) {
        ActionsHelper.typeTextAndDismissKeyboard(element: emailField, text: email, app: app)
    }

    func enterPassword(_ password: String) {
        ActionsHelper.pasteText(password, into: passwordField, app: app)
    }

    func tapLogin() {
        loginButton.tap()
    }

    func login(email: String, password: String) {
        enterEmail(email)
        enterPassword(password)
        tapLogin()
    }
    
    func isLoginButtonEnabled() -> Bool {
        return loginButton.isEnabled
    }
}

