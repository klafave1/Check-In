import XCTest

// Test case for launching MediManage UI tests
final class MediManageUITestsLaunchTests: XCTestCase {

    // Set to true to run the test for each target application UI configuration
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    // Perform setup before each test case
    override func setUpWithError() throws {
        // Ensure that tests continue after a UI failure
        continueAfterFailure = false
    }

    // Test method for launching the application
    func testLaunch() throws {
        // Launch the application
        let app = XCUIApplication()
        app.launch()

        // Take a screenshot of the launch screen
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

// Sources:
// https://developer.apple.com/documentation/xctest
// https://developer.apple.com/documentation/xctest/user_interface_tests
