//
//  ActionsHelper.swift
//  Tasks
//
//  Created by Andrii Melnyk on 23.06.2025.
//  Copyright © 2025 Cultured Code. All rights reserved.
//

import XCTest

struct ActionsHelper {
    
    static func typeTextAndDismissKeyboard(element: XCUIElement, text: String, app: XCUIApplication) {
        guard element.exists else { return }

        element.tap()
        if !app.keyboards.element.waitForExistence(timeout: 1.5) {
            element.tap()
            _ = app.keyboards.element.waitForExistence(timeout: 1.0)
        }
        element.typeText(text)

        dismissKeyboard(app: app)
    }
    
    static func dismissKeyboard(app: XCUIApplication) {
        if app.keyboards.element.exists {
            let returnButton = app.keyboards.buttons[StringConstants.returnButton]
            let doneButton = app.toolbars.buttons[StringConstants.doneButton]
            
            if returnButton.waitForExistence(timeout: 1) && returnButton.isHittable {
                returnButton.tap()
            } else if doneButton.waitForExistence(timeout: 1) && doneButton.isHittable {
                doneButton.tap()
            }
        }
    }
    
    static func pasteText(_ text: String, into element: XCUIElement, app: XCUIApplication) {
        UIPasteboard.general.string = text
        element.tap()
        
        element.doubleTap()
        if app.menuItems[StringConstants.pasteButton].waitForExistence(timeout: 1.5) {
            app.menuItems[StringConstants.pasteButton].tap()
        }
    }
    
    static func waitForElementWithLabel(_ label: String, type: XCUIElement.ElementType = .any, in app: XCUIApplication, timeout: TimeInterval = 3) -> Bool {
        return app.descendants(matching: type)
            .matching(NSPredicate(format: "label == %@", label))
            .firstMatch
            .waitForExistence(timeout: timeout)
    }
    
    static func takeScreenshot(name: String = "Screenshot", testCase: XCTestCase) {
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        testCase.add(attachment)
    }
}
