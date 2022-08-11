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
                Color.mint
                if count != 0 {
                    Text(String(count))
                }
            }
            .aspectRatio(1, contentMode: .fit)
        case .hidden:
            Button(action: self.action) {
                Color.green
                    .aspectRatio(1, contentMode: .fit)
            }
        case .flagged:
            Button(action: self.action) {
                ZStack {
                    Color.green
                    Image(systemName: "flag.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(5)
                        .foregroundColor(.red)
                }
                .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}
