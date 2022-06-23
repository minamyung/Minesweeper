import SwiftUI
import UIKit

struct ConfettiView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIConfettiView()
        view.backgroundColor = .gray
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct ConfettiView_Previews: PreviewProvider {
    static var previews: some View {
        ConfettiView()
    }
}
