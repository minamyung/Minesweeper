import SwiftUI
import CustomUI

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
