import UIKit

class UIConfettiView: UIView {
    private var emitterLayer: CAEmitterLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpView()
    }
    
    private func setUpView() {
        self.emitterLayer = self.emitter()
        self.layer.addSublayer(self.emitterLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.emitterLayer.frame = self.bounds
        self.emitterLayer.emitterPosition = CGPoint(x: self.bounds.midX, y: 100)
    }
    
    private func emitter() -> CAEmitterLayer {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterCells = self.emitterCells()
        emitterLayer.beginTime = CACurrentMediaTime()
        return emitterLayer
    }
    
    private func emitterCells() -> [CAEmitterCell] {
        let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple]
        let confetti: [Confetto] = colors.map {
            Confetto(color: $0, shape: .rectangle)
        }
        return confetti.map(self.emitterCell)
    }
    
    private func emitterCell(confetto: Confetto) -> CAEmitterCell {
        let emitterCell = CAEmitterCell()
        emitterCell.beginTime = 0.1
        emitterCell.duration = 5
        emitterCell.lifetime = 5
        emitterCell.contents = self.image(confetto: confetto)
        emitterCell.emissionRange = CGFloat.pi
        emitterCell.birthRate = 10
        emitterCell.velocity = 100
        emitterCell.velocityRange = 100
        emitterCell.yAcceleration = 150
        emitterCell.scaleRange = 0.1
        emitterCell.scale = 0.4
        return emitterCell
    }
        
    private func image(confetto: Confetto) -> CGImage? {
        let rectangle = CGRect(x: 0, y: 0, width: 10, height: 10)
        let path = path(confettoShape: confetto.shape, in: rectangle)
        let renderer = UIGraphicsImageRenderer(size: rectangle.size)
        return renderer.image { context in
            context.cgContext.setFillColor(confetto.color.cgColor)
            context.cgContext.addPath(path)
            context.cgContext.fillPath()
        }.cgImage
    }
    
    private func path(confettoShape: ConfettoShape, in rectangle: CGRect) -> CGPath {
        switch confettoShape {
        case .circle:
            return CGPath(ellipseIn: rectangle, transform: nil)
        case .rectangle:
            return CGPath(rect: rectangle, transform: nil)
        }
        
    }
}

struct Confetto {
    let color: UIColor
    let shape: ConfettoShape
}

enum ConfettoShape {
    case circle
    case rectangle
}
