import UIKit
import Algorithms

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
        emitterLayer.emitterShape = .line
        emitterLayer.emitterSize = CGSize(width: self.bounds.width, height: 10)
        emitterLayer.emitterCells = self.emitterCells()
        emitterLayer.beginTime = CACurrentMediaTime()
        return emitterLayer
    }
    
    private func emitterCells() -> [CAEmitterCell] {
        let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple]
        let shapes = ConfettoShape.allCases
        return product(colors, shapes)
            .map(Confetto.init)
            .map(self.emitterCell)
            .shuffled()
    }
    
    private func emitterCell(confetto: Confetto) -> CAEmitterCell {
        let emitterCell = CAEmitterCell()
        emitterCell.beginTime = 0.1
        emitterCell.duration = 0.1
        emitterCell.lifetime = 5
        emitterCell.contents = self.image(confetto: confetto)
        emitterCell.emissionRange = CGFloat.pi
        emitterCell.birthRate = 1000
        emitterCell.velocity = 300
        emitterCell.velocityRange = 100
        emitterCell.yAcceleration = 300
        emitterCell.scaleRange = 0.2
        emitterCell.scale = 0.3
        emitterCell.spin = 0
        emitterCell.spinRange = 50
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
        case .triangle:
            let something = rectangle.width / sqrt(3)
            let path = UIBezierPath()
            path.move(to: CGPoint(x: rectangle.midX, y: rectangle.minY))
            path.addLine(to: CGPoint(x: rectangle.midX + something, y: rectangle.maxY))
            path.addLine(to: CGPoint(x: rectangle.midX - something, y: rectangle.maxY))
            path.addLine(to: CGPoint(x: rectangle.midX, y: rectangle.minY))
            return path.cgPath
        }
        
    }
}

struct Confetto {
    let color: UIColor
    let shape: ConfettoShape
}

enum ConfettoShape: CaseIterable {
    case circle
    case rectangle
    case triangle
}
