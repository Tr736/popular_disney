import PopularDisneyUI
import SwiftUI

@main
struct PopularDisneyApp: App {
    var body: some Scene {
        WindowGroup {
            Home(viewModel: HomeViewModel(dataProvider: HomeDataProvider()))
        }
    }
}
