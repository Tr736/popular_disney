import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/kean/Nuke",
                requirement: .upToNextMajor(from: "12.0")),
    ],
    platforms: [.iOS]
)
