import SwiftUI

struct TucoEscapingView: View {
    @StateObject private var vm = TucoEscapingViewModel()
    
    var body: some View {
        vm.currentImage
            .resizable()
            .ignoresSafeArea()
    }
}

