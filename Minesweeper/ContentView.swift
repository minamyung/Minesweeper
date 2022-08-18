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
            ResponsiveStackView(isInverted: true) {
                Toggle(isOn: $viewModel.flagMode) { }
                    .toggleStyle(ImageToggleStyle(onImage: Image(systemName: "flag.circle.fill"), offImage: Image(systemName: "flag.slash.circle.fill")))
                Spacer()
                Button(
                    action: { self.viewModel.reset() },
                    label: { Image(systemName: "arrow.counterclockwise.circle.fill") }
                    )
            }
            
            VStack {
                ForEach(viewModel.rows, content: rowView)
                    .disabled(viewModel.playState != .inProgress)
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
    private let isInverted: Bool
    private let content: () -> Content
    
    init(spacing: CGFloat? = nil, isInverted: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.isInverted = isInverted
        self.content = content
    }
    
    var body: some View {
        switch self.naturalAxis.inverted(self.isInverted) {
        case .vertical:
            VStack(content: self.content)
        case .horizontal:
            HStack(content: self.content)
        }
    }
    
    private var naturalAxis: Axis {
        switch horizontalSizeClass {
        case .compact, .none:
            return .vertical
        case .regular:
            return .horizontal
        @unknown default:
            return .vertical
        }
    }
    
    private enum Axis {
        case vertical
        case horizontal
        
        func inverted(_ isInverted: Bool) -> Self {
            isInverted ? inverted() : self
        }
        
        func inverted() -> Self {
            switch self {
            case .vertical: return .horizontal
            case .horizontal: return .vertical
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

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

// TODO: refactor
// TODO: animations when losing a game
