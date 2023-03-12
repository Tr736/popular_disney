import MyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

/*
 +-------------+
 |             |
 |     App     | Contains PopularDisney App target and PopularDisney unit-test target
 |             |
 +------+-------------+-------+
 |         depends on         |
 |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.app(name: "PopularDisney",
                          platform: .iOS,
                          dependencies: [],
                          additionalTargets: ["PopularDisneyKit",
                                              "PopularDisneyUI"])
