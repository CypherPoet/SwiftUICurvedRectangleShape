// References
//  - https://rechneronline.de/pi/curved-rectangle.php
//  - https://medium.com/@dennismphil/one-side-rounded-rectangle-using-svg-fb31cf318d90


import SwiftUI


public struct CurvedRectangle {
    public var leadingDepthPercentage: CGFloat
    public var trailingDepthPercentage: CGFloat

    public var curveAxis: Axis = .vertical
    
    
    // MARK: - Init
    public init(
        curveAxis: Axis = .vertical,
        leadingDepthPercentage: CGFloat = 0,
        trailingDepthPercentage: CGFloat = 0
    ) {
        self.curveAxis = curveAxis
        self.leadingDepthPercentage = leadingDepthPercentage
        self.trailingDepthPercentage = trailingDepthPercentage
    }
}


// MARK: - Shape
extension CurvedRectangle: Shape {
    
    public func path(in rect: CGRect) -> Path {
        switch curveAxis {
        case .horizontal:
            return horizontalCurvedRectanglePath(in: rect)
        case .vertical:
            return verticalCurvedRectanglePath(in: rect)
        }
    }
}


// MARK: - AnimatableData
extension CurvedRectangle {
    
    public var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(leadingDepthPercentage, trailingDepthPercentage)
        }
        set {
            leadingDepthPercentage = newValue.first
            trailingDepthPercentage = newValue.second
        }
    }
}


// MARK: - Curve Depth Amounts
extension CurvedRectangle {
    
    private func leadingCurveDepthAmount(in rect: CGRect) -> CGFloat {
        switch curveAxis {
        case .horizontal:
            return rect.width * (leadingDepthPercentage / 100)
        case .vertical:
            return rect.height * (leadingDepthPercentage / 100)
        }
    }
    
    
    private func trailingCurveDepthAmount(in rect: CGRect) -> CGFloat {
        switch curveAxis {
        case .horizontal:
            return rect.width * (trailingDepthPercentage / 100)
        case .vertical:
            return rect.height * (trailingDepthPercentage / 100)
        }
    }
}
    
 
// MARK: - Control Point Computation
extension CurvedRectangle {
    
    private func leadingControlPoint(in rect: CGRect) -> CGPoint {
        switch curveAxis {
        case .horizontal:
            return .init(
                x: rect.minX - leadingCurveDepthAmount(in: rect),
                y: rect.midY
            )
        case .vertical:
            return .init(
                x: rect.midX,
                y: rect.minY - leadingCurveDepthAmount(in: rect)
            )
        }
    }
    
    
    private func trailingControlPoint(in rect: CGRect) -> CGPoint {
        switch curveAxis {
        case .horizontal:
            return .init(
                x: rect.maxX + trailingCurveDepthAmount(in: rect),
                y: rect.midY
            )
        case .vertical:
            return .init(
                x: rect.midX,
                y: rect.maxY + trailingCurveDepthAmount(in: rect)
            )
        }
    }
}

// MARK: - Vertex Point Computation
extension CurvedRectangle {
    
    private func topLeadingPoint(in rect: CGRect) -> CGPoint {
        switch curveAxis {
        case .horizontal:
            return .init(
                x: max(
                    rect.topLeading.x,
                    rect.topLeading.x + leadingCurveDepthAmount(in: rect)
                ),
                y: rect.topLeading.y
            )
        case .vertical:
            return .init(
                x: rect.topLeading.x,
                y: max(
                    rect.topLeading.y,
                    rect.topLeading.y + leadingCurveDepthAmount(in: rect)
                )
            )
        }
    }
    
    
    private func topTrailingPoint(in rect: CGRect) -> CGPoint {
        switch curveAxis {
        case .horizontal:
            return .init(
                x: min(
                    rect.topTrailing.x,
                    rect.topTrailing.x - trailingCurveDepthAmount(in: rect)
                ),
                y: rect.topTrailing.y
            )
        case .vertical:
            return .init(
                x: rect.topTrailing.x,
                y: max(
                    rect.topTrailing.y,
                    rect.topTrailing.y + leadingCurveDepthAmount(in: rect)
                )
            )
        }
    }
    
    
    private func bottomTrailingPoint(in rect: CGRect) -> CGPoint {
        switch curveAxis {
        case .horizontal:
            return .init(
                x: min(
                    rect.bottomTrailing.x,
                    rect.bottomTrailing.x - trailingCurveDepthAmount(in: rect)
                ),
                y: rect.bottomTrailing.y
            )
        case .vertical:
            return .init(
                x: rect.bottomTrailing.x,
                y: min(
                    rect.bottomTrailing.y,
                    rect.bottomTrailing.y - trailingCurveDepthAmount(in: rect)
                )
            )
        }
    }
    
    
    private func bottomLeadingPoint(in rect: CGRect) -> CGPoint {
        switch curveAxis {
        case .horizontal:
            return .init(
                x: max(
                    rect.bottomLeading.x,
                    rect.bottomLeading.x + leadingCurveDepthAmount(in: rect)
                ),
                y: rect.bottomLeading.y
            )
        case .vertical:
            return .init(
                x: rect.bottomLeading.x,
                y: min(
                    rect.bottomLeading.y,
                    rect.bottomLeading.y - trailingCurveDepthAmount(in: rect)
                )
            )
        }
    }
}


// MARK: - Path Drawing Helpers
private extension CurvedRectangle {
    
    private func horizontalCurvedRectanglePath(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: topTrailingPoint(in: rect))
        
        path.addQuadCurve(
            to: bottomTrailingPoint(in: rect),
            control: trailingControlPoint(in: rect)
        )
        
        path.addLine(to: bottomLeadingPoint(in: rect))
        
        path.addQuadCurve(
            to: topLeadingPoint(in: rect),
            control: leadingControlPoint(in: rect)
        )
        
        path.closeSubpath()
        
        return path
    }
    
    
    private func verticalCurvedRectanglePath(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: topLeadingPoint(in: rect))
        
        path.addQuadCurve(
            to: topTrailingPoint(in: rect),
            control: leadingControlPoint(in: rect)
        )
        
        path.addLine(to: bottomTrailingPoint(in: rect))
        
        path.addQuadCurve(
            to: bottomLeadingPoint(in: rect),
            control: trailingControlPoint(in: rect)
        )
        
        path.closeSubpath()
        
        return path
    }
}


#if DEBUG

struct CurveSidedRectangle_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            CurvedRectangle(curveAxis: .horizontal)
                .previewDisplayName("Horizontal Axis: Default")
            
            CurvedRectangle(
                curveAxis: .horizontal,
                leadingDepthPercentage: 25,
                trailingDepthPercentage: 25
            )
            .previewDisplayName("Horizontal Axis: Both positive")
            
            CurvedRectangle(
                curveAxis: .horizontal,
                leadingDepthPercentage: -25,
                trailingDepthPercentage: -25
            )
            .previewDisplayName("Horizontal Axis: Both negative")

            
            CurvedRectangle(
                curveAxis: .horizontal,
                trailingDepthPercentage: 25
            )
            .stroke(Color.blue, lineWidth: 2.0)
            .previewDisplayName("Horizontal Axis: Positive Trailing Only")
        }
//        .border(Color.yellow, width: 4)
        .padding(40)
        .frame(height: 200)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Horizontal Axis")
        
        
        Group {
            CurvedRectangle(curveAxis: .vertical)
            
            CurvedRectangle(
                curveAxis: .vertical,
                leadingDepthPercentage: 25,
                trailingDepthPercentage: 25
            )
            
            CurvedRectangle(
                curveAxis: .vertical,
                leadingDepthPercentage: -25,
                trailingDepthPercentage: -25
            )
            
            CurvedRectangle(
                curveAxis: .vertical,
                trailingDepthPercentage: 25
            )
            .stroke(Color.blue, lineWidth: 2.0)
        }
//        .border(Color.yellow, width: 4)
        .padding(40)
        .frame(height: 200)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Vertical Axis")
    }
}

#endif
