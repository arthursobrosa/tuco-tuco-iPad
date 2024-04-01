import SwiftUI

struct GuysLeavingView: View {
    @StateObject private var vm = GuysLeavingViewModel()
    
    var body: some View {
        ZStack {
            ForEach(vm.guysViews) { guyView in
                guyView
            }
        }
    }
}

