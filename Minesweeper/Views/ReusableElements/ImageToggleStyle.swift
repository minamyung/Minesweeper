import SwiftUI

struct ImageToggleStyle: ToggleStyle {
    let onImage: Image
    let offImage: Image
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Button(
                action: { self.action(configuration: configuration) },
                label: { image(configuration: configuration) }
            )
        }
    }
    
    private func action(configuration: Configuration) {
        configuration.isOn.toggle()
    }
    
    private func image(configuration: Configuration) -> some View {
        return configuration.isOn ? self.onImage : self.offImage
    }
}
