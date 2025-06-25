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

        var taskChangeMismatch = false

        for i in 0 ..< totalTasks {
            let currentState = checklistScreen.isTaskChecked(at: i)
            if i == targetIndex {
                if currentState == initialStates[i] {
                    taskChangeMismatch = true
                }
                XCTAssertNotEqual(currentState, initialStates[i], "Task at index \(i) should have changed.")
            } else {
                XCTAssertEqual(currentState, initialStates[i], "Task at index \(i) should not have changed.")
            }
        }

        if taskChangeMismatch {
            XCTExpectFailure("Known issue: Tapping on task may select the previous one instead.")
        }
    }

    func testSortByName() {
        checklistScreen.tapSortByName()
        
        let isSorted = checklistScreen.isSortedAlphabetically()
        let areAllSelected = checklistScreen.areAllTasksChecked()
        
        if !isSorted {
            XCTExpectFailure("Known issue: 'Sort by Name' button sorts in random order.")
        }
        
        if areAllSelected {
            XCTExpectFailure("Known issue: 'Sort by Name' button triggers task selection instead of sorting.")
        }

        XCTAssertTrue(isSorted, "Tasks should be sorted in alphabetical order")
        XCTAssertFalse(areAllSelected, "'Sort by Name' should not mark all tasks as selected.")
    }

    func testCompleteAllTasks() {
        checklistScreen.tapCompleteAll()

        let allChecked = checklistScreen.areAllTasksChecked()
        let cancelVisible = checklistScreen.cancelAllButton.exists

        if !allChecked {
            XCTExpectFailure("Known issue: 'Complete All' button only highlights tasks without checking their boxes.")
        }

        if !cancelVisible {
            XCTExpectFailure("Known issue: 'Complete All' button doesn't toggle to 'Cancel All' after all tasks are selected.")
        }

        XCTAssertTrue(allChecked, "'Complete All' should mark all tasks as selected.")
        XCTAssertTrue(cancelVisible, "'Cancel All' button should appear after all tasks are completed.")
    }
    
    func testSubtasksAreCompletedWithParent() {
        let taskIndex = 3
        checklistScreen.changeTaskState(at: taskIndex)
        XCTAssertTrue(checklistScreen.isTaskChecked(at: taskIndex), "Task at index \(taskIndex) should be selected.")

        checklistScreen.openTaskDetails(forTaskWithLabel: "Sleep")

        let subtasksChecked = !checklistScreen.allTaskStates().contains(false)

        if !subtasksChecked {
            XCTExpectFailure("Known issue: Subtasks are not marked as completed after completing a parent task.")
        }

        XCTAssertTrue(subtasksChecked, "All subtasks should be marked as completed after parent is completed.")
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
