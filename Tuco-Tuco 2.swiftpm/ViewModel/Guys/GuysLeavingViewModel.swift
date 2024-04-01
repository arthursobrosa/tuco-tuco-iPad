import SwiftUI

class GuysLeavingViewModel: ObservableObject {
    var guysViews: [GuyLeavingView] = {
        var guysViews: [GuyLeavingView] = []
        
        for i in 0...1 {
            let guyView = GuyLeavingView(vm: GuyLeavingViewModel(guyIndex: i))
            guysViews.append(guyView)
        }
        
        return guysViews
    }()
}

