## Greetings %username% !

This is a quick manual on what we expect from you during performing the test task.

This will be a simple app that contains two features: Login & Checklist.

* First of all, get to know with the application under test, build the test app and check out its possibilities and bugs. 

* Second of all, we need to evaluate your qa manual background, so create down below:
 - short testplan 
 - list of the testcases
 - list of discovered issues
 
* Third of all, write test automation according test automation purposes  

* And fourth of all, push the whole project to github.com and notice us with a link to your repo on completion. 

Please reachout Oksana (otolstykh@readdle.com) if you have any questions.

## Good Luck!
* p.s. Do not tamper codebase of application

#YOUR TASK STARTS HERE: 


# TEST PLAN: 

- Environment:
Device: iPhone 16 Simulator.
iOS version: iOS 18.5.
Xcode version: 16.4.

- What parts of app will be tested:
Login screen: input validation for email and password fields, error handling for invalid or empty values.
Checklist screen: interaction with task checkboxes, functionality of “Complete All” and “Sort by Name” buttons, logout behaviour. 

# LIST OF TEST CASES: 
Login screen:
1. Login with valid email and password.
2. Login with empty email and empty password.
3. Login with empty email and valid password.
4. Login with valid email and empty password.
5. Login with invalid email format and valid password.
    
Checklist screen:
1. Verify that task changes state.
2. Verify that all subtasks are marked as completed after completing a parent task.
3. Verify that "Sort by Name" button sorts tasks alphabetically.
4. Verify that "Complete All" button marks all tasks as completed.
5. Verify log out from the app.
6. Verify that cancelling the logout return to checklist screen.

# LIST OF DISCOVERED ISSUES:
- Login randomly fails with valid credentials.
- Tapping on task may select the previous one instead.
- "Complete All" button doesn't toggle to "Cancel All" after all tasks are selected.
- "Complete All" button only highlights tasks without checking their boxes.
- "Sort by Name" button triggers task selection instead of sorting.
- "Sort by Name" button sorts in random order.
- Some tasks are not visible in dark mode.
