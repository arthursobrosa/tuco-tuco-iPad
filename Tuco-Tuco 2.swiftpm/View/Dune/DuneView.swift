import SwiftUI

struct DuneView: View {
    var body: some View {
        DuneModel.image
            .resizable()
            .frame(width: DuneModel.width, height: DuneModel.height)
            .position(DuneModel.position)
    }
}

