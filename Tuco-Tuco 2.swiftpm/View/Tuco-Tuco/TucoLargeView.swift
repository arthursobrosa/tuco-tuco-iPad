import SwiftUI

struct TucoLargeView: View {
    var body: some View {
        TucoLargeModel.image
            .resizable()
            .frame(width: TucoLargeModel.width, height: TucoLargeModel.height)
            .position(TucoLargeModel.position)
    }
}

