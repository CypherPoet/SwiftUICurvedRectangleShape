import SwiftUI


extension CGRect {
    
    var topLeading: CGPoint {
        .init(x: minX, y: minY)
    }
    
    var topTrailing: CGPoint {
        .init(x: maxX, y: minY)
    }
    
    var bottomTrailing: CGPoint {
        .init(x: maxX, y: maxY)
    }
    
    var bottomLeading: CGPoint {
        .init(x: minX, y: maxY)
    }
    
    var center: CGPoint {
        .init(x: midX, y: midY)
    }
}
