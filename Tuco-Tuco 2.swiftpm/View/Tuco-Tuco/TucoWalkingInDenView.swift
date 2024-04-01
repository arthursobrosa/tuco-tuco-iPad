import SwiftUI

struct TucoWalkingInDenView: View {
    @StateObject private var vm = TucoWalkingInDenViewModel() 
    
    @Binding var presentStandingTuco: Bool
    
    var body: some View {
        vm.currentImage
            .resizable()
            .ignoresSafeArea()
            .onChange(of: vm.presentStandingTuco) { _, newValue in
                presentStandingTuco = newValue
            }
    }
}

