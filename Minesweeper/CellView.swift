import SwiftUI

struct CellView: View {
    private let state: MinesweeperCell.State
    private let action: () -> Void
    
    init(cell: MinesweeperCell, action: @escaping () -> Void) {
        self.state = cell.state
        self.action = action
    }
    
    var body: some View {
        switch self.state {
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
        case .hidden:
            Button(action: self.action) {
                Color.gray
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}
