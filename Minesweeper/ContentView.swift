import SwiftUI

struct ContentView: View {
    var body: some View {
        MinesweeperBoardView()
            .padding()
    }
}

struct MinesweeperBoardView: View {
    @State var viewModel = MinesweeperBoardViewModel(10, 10)
    
    var body: some View {
        ResponsiveStackView {
            Toggle("Flag mode", isOn: $viewModel.flagMode)
            ForEach(viewModel.rows, content: rowView)
                .disabled(viewModel.playState != .inProgress)
            Button("Reset") {
                viewModel.reset()
            }
        }
        .minimumScaleFactor(0.00001)
        .font(.largeTitle)
        .overlay {
            if viewModel.playState == .won {
                ConfettiView().allowsHitTesting(false)
            }
        }
    }
    
    private func rowView(_ row: MinesweeperRow) -> some View {
        HStack {
            ForEach(row.cells, content: cellView)
        }
    }
    
    private func cellView(cell: MinesweeperCell) -> CellView {
        CellView(cell: cell) {
            viewModel.cellAction(for: cell)
        }
    }
}

struct ResponsiveStackView<Content: View>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private let spacing: CGFloat?
    private let content: () -> Content
    
    init(spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        switch horizontalSizeClass {
        case .compact, .none:
            VStack(content: self.content)
        case .regular:
            HStack(content: self.content)
        @unknown default:
            VStack(content: self.content)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// TODO: Fix ResponsiveStackView so it works in landscape mode
// TODO: refactor
// TODO: animations when losing a game
