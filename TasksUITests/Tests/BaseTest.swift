//
//  Base.swift
//  Tasks
//
//  Created by Andrii Melnyk on 22.06.2025.
//  Copyright © 2025 Cultured Code. All rights reserved.
//

import XCTest

class BaseTest: XCTestCase {
    var app: XCUIApplication!
    var loginScreen: LoginScreen!
    var checklistScreen: ChecklistScreen!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        loginScreen = LoginScreen(app: app)
        checklistScreen = ChecklistScreen(app: app)
    }
    
    override func tearDown() {
        super.tearDown()

        if self.testRun?.hasSucceeded == false {
            ActionsHelper.takeScreenshot(name: "Failure Screenshot", testCase: self)
            print("App debug description on failure: \(app.debugDescription)")
        }
    }
}

