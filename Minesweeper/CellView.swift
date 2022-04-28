import SwiftUI

struct CellView: View {
    let viewModel: CellViewModel
    @State var isHidden = true
    
    init(viewModel: CellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if isHidden {
            Button {
                isHidden = false
            } label: {
                Color.gray
                    .aspectRatio(1, contentMode: .fit)
            }
        } else {
            switch viewModel.state {
            case .mine:
                ZStack {
                    Color.red
                    Text("💣")
                }
                .aspectRatio(1, contentMode: .fit)
            case .sweep(let count):
                ZStack {
                    Color.gray
                    Text(String(count))
                }
                .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}
