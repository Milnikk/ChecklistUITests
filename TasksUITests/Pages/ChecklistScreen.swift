//
//  ChecklistScreen.swift
//  Tasks
//
//  Created by Andrii Melnyk on 22.06.2025.
//  Copyright © 2025 Cultured Code. All rights reserved.
//

import XCTest

struct ChecklistScreen {
    let app: XCUIApplication

    var tasksLabel: XCUIElement { app.staticTexts[StringConstants.tasksScreenTitle] }
    var logoutButton: XCUIElement { app.buttons[StringConstants.logoutButton] }
    var logoutAlert: XCUIElement { app.alerts.descendants(matching: .staticText)
            .matching(NSPredicate(format: "label == %@", StringConstants.logoutAlertTitle))
            .firstMatch }
    var logoutConfirmButton: XCUIElement { app.alerts.descendants(matching: .button)
            .matching(NSPredicate(format: "label == %@", StringConstants.logoutConfirm))
            .firstMatch  }
    var logoutCancelButton: XCUIElement { app.alerts.descendants(matching: .button)
            .matching(NSPredicate(format: "label == %@", StringConstants.logoutCancel))
            .firstMatch }
    var completeAllButton: XCUIElement { app.buttons[StringConstants.completeAllButton] }
    var cancelAllButton: XCUIElement { app.buttons[StringConstants.cancelAllButton] }
    var sortByNameButton: XCUIElement { app.buttons[StringConstants.sortByNameButton] }
    var taskCells: [XCUIElement] {
        app.cells.allElementsBoundByIndex
    }
    var taskCheckboxes: [XCUIElement] {
        app.cells.descendants(matching: .image).allElementsBoundByIndex
    }

    func logout() {
        logoutButton.tap()
        XCTAssertTrue(logoutAlert.waitForExistence(timeout: 2))
        logoutConfirmButton.tap()
    }

    func cancelLogout() {
        logoutButton.tap()

        if logoutAlert.waitForExistence(timeout: 2) {
            logoutCancelButton.tap()
        }
    }
    
    func tapCompleteAll() {
        completeAllButton.tap()
    }
    
    func areAllTasksChecked() -> Bool {
        return taskCheckboxes.allSatisfy { $0.value as? String == "Selected" }
    }

    
    func tapSortByName() {
        sortByNameButton.tap()
    }
    
    func openTaskDetails(forTaskWithLabel label: String) {
        let cell = app.cells.containing(.staticText, identifier: label).firstMatch
        let moreInfoButton = cell.buttons[StringConstants.moreInfoButton]
        if moreInfoButton.exists {
            moreInfoButton.tap()
        }
    }

    func isSortedAlphabetically() -> Bool {
        let taskLabels = taskCells.map { $0.staticTexts.firstMatch.label }
        return taskLabels == taskLabels.sorted()
    }

    func changeTaskState(at index: Int) {
        guard taskCheckboxes.indices.contains(index) else { return }
        taskCheckboxes[index].tap()
    }

    func isTaskChecked(at index: Int) -> Bool {
        guard taskCheckboxes.indices.contains(index) else { return false }
        return (taskCheckboxes[index].value as? String) == "Selected"
    }
    
    func allTaskStates() -> [Bool] {
        return taskCheckboxes.map { ($0.value as? String) == "Selected" }
    }
}
