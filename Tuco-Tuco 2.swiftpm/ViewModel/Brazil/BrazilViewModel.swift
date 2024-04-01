import SwiftUI
import Combine

class BrazilViewModel: ObservableObject {
    @Published var opacity = 0.0
    @Published var currentImage = BrazilModel.images[0]
    
    @Published var isMapHidden = false
    @Published var hasImageChanged = false
    
    public func showMap() {
        opacity = 1.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.hasImageChanged = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) { [weak self] in
            guard let self = self else { return }
            self.isMapHidden = true
        }
    }
    
    public func hideMap() {
        opacity = 0.0
    }
    
    public func changeImage() {
        currentImage = BrazilModel.images[1]
    }
}

