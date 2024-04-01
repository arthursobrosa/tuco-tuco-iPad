import SwiftUI

struct TucoSpeechTextView: View {
    @Binding var text: String
    let isOutside: Bool
    
    var body: some View {
        Text(text)
            .font(.custom(fontName, size: formatSize(value: 60, with: .width)))
            .multilineTextAlignment(.center)
            .padding()
            .frame(
                width: isOutside ? TucoSpeechTextModel.outsideSize.width : TucoSpeechTextModel.insideSize.width,
                height: isOutside ? TucoSpeechTextModel.outsideSize.height : TucoSpeechTextModel.insideSize.height,
                alignment: .center)
            .foregroundStyle(isOutside ? TucoSpeechTextModel.outsideTextColor : TucoSpeechTextModel.insideTextColor)
            .background(
                Rectangle()
                    .foregroundStyle(isOutside ? TucoSpeechTextModel.outsideFrameColor : TucoSpeechTextModel.insideFrameColor)
                    .opacity(0.6)
                    .cornerRadius(isOutside ? TucoSpeechTextModel.outsideFrameCornerRadius : TucoSpeechTextModel.insideFrameCornerRadius)
            )
            .position(isOutside ? TucoSpeechTextModel.outsidePosition : TucoSpeechTextModel.insidePosition)
    }
}

