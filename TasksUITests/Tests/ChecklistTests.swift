//
//  CheclistTests.swift
//  Tasks
//
//  Created by Andrii Melnyk on 22.06.2025.
//  Copyright © 2025 Cultured Code. All rights reserved.
//

import XCTest

final class ChecklistTests: BaseTest {
    
    override func setUp() {
        super.setUp()
        if loginScreen.loginButton.exists {
            loginScreen.login(email: StringConstants.validEmail, password: StringConstants.validPassword)
        }
    }
        
    func testChangeTaskState() {
        let targetIndex = 1
        let totalTasks = checklistScreen.taskCheckboxes.count

        var initialStates: [Bool] = []
        for i in 0 ..< totalTasks {
            initialStates.append(checklistScreen.isTaskChecked(at: i))
        }

        checklistScreen.changeTaskState(at: targetIndex)

        for i in 0 ..< totalTasks {
            let currentState = checklistScreen.isTaskChecked(at: i)
            if i == targetIndex {
                XCTAssertNotEqual(currentState, initialStates[i], "Task at index \(i) should have changed.")
            } else {
                XCTAssertEqual(currentState, initialStates[i], "Task at index \(i) should not have changed.")
            }
        }
    }

    func testSortByName() {
        checklistScreen.tapSortByName()
        XCTAssertTrue(checklistScreen.isSortedAlphabetically(), "Tasks should be sorted in alphabetical order")
    }

    func testCompleteAllTasks() {
        checklistScreen.tapCompleteAll()
        XCTAssertTrue(checklistScreen.areAllTasksChecked(), "'Complete All' should mark all tasks as selected.")
        XCTAssertTrue(checklistScreen.cancelAllButton.exists, "'Cancel All' button should appear after all tasks are completed.")
    }
    
    func testSubtasksAreCompletedWithParent() {
        let taskIndex = 3
        checklistScreen.changeTaskState(at: taskIndex)
        XCTAssertTrue(checklistScreen.isTaskChecked(at: taskIndex), "Task at index \(taskIndex) should not have changed.")
        checklistScreen.openTaskDetails(forTaskWithLabel: "Sleep")
        XCTAssertFalse(checklistScreen.allTaskStates().contains(false), "All subtasks should be marked same as parent task.")
    }

    func testLogoutFlow() {
        checklistScreen.logout()
        XCTAssertTrue(loginScreen.loginButton.waitForExistence(timeout: 2), "Login screen should appear after confirming logout.")
    }

    func testCancelLogout() {
        checklistScreen.cancelLogout()
        XCTAssertTrue(checklistScreen.tasksLabel.exists, "Checklist screen should remain after cancelling logout.")
    }
}
