import SwiftUI

@main
struct MyApp: App {
    init() {
        addFont()
    }
    
    var body: some Scene {
        WindowGroup {
            InitialPageView()
        }
    }
}

