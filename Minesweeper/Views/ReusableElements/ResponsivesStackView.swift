import SwiftUI

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
