//
// Trapezoid.swift
// Shared
//
// Created by CypherPoet on 3/11/21.
// ✌️
//

// References
//  - http://www.amathsdictionaryforkids.com/qr/t/trapezium.html
//  - https://en.wikipedia.org/wiki/Trapezoid


import SwiftUI


public struct Trapezoid {
    public var leadingAnchor: RectangleCorner
    public var trailingAnchor: RectangleCorner

    public var leadingLegInsetPercentage: CGFloat
    public var trailingLegInsetPercentage: CGFloat
    
    
    // MARK: - Init
    public init(
        leadingAnchor: RectangleCorner = .bottomLeading,
        trailingAnchor: RectangleCorner = .bottomTrailing,
        leadingLegInsetPercentage: CGFloat = CGFloat(25.0),
        trailingLegInsetPercentage: CGFloat = CGFloat(25.0)
    ) {
        self.leadingAnchor = leadingAnchor
        self.trailingAnchor = trailingAnchor
        self.leadingLegInsetPercentage = leadingLegInsetPercentage
        self.trailingLegInsetPercentage = trailingLegInsetPercentage
    }
    
    
    public init(
        leadingAnchor: RectangleCorner,
        leadingLegInsetPercentage: CGFloat,
        trailingLegInsetPercentage: CGFloat
    ) {
        var trailingAnchor: RectangleCorner
        
        // Infer a default `trailingAnchor` from the `leadingAnchor`.
        switch leadingAnchor {
        case .topLeading:
            trailingAnchor = .bottomLeading
        case .topTrailing:
            trailingAnchor = .topLeading
        case .bottomLeading:
            trailingAnchor = .bottomTrailing
        case .bottomTrailing:
            trailingAnchor = .topTrailing
        }
        
        
        self.init(
            leadingAnchor: leadingAnchor,
            trailingAnchor: trailingAnchor,
            leadingLegInsetPercentage: leadingLegInsetPercentage,
            trailingLegInsetPercentage: trailingLegInsetPercentage
        )
    }
}


// MARK: - Shape
extension Trapezoid: Shape {
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: bottomLeadingPoint(in: rect))
        
        path.addLine(to: topLeadingPoint(in: rect))
        path.addLine(to: topTrailingPoint(in: rect))
        path.addLine(to: bottomTrailingPoint(in: rect))
        
        path.closeSubpath()

        return path
    }
}


// MARK: - Inset Amounts
extension Trapezoid {
    
    private func leadingLegInsetAmount(in rect: CGRect) -> CGFloat {
        switch leadingAnchor {
        case .bottomLeading,
             .topTrailing:
            return rect.width * (leadingLegInsetPercentage / 100)
        case .topLeading,
             .bottomTrailing:
            return rect.height * (leadingLegInsetPercentage / 100)
        }
    }
    
    private func trailingLegInsetAmount(in rect: CGRect) -> CGFloat {
        switch trailingAnchor {
        case .topTrailing,
             .bottomLeading:
            return rect.height * (trailingLegInsetPercentage / 100)
        case .bottomTrailing,
             .topLeading:
            return rect.width * (trailingLegInsetPercentage / 100)
        }
    }
}



// MARK: - Point Computation
extension Trapezoid {
    
    private func bottomLeadingPoint(in rect: CGRect) -> CGPoint {

        if leadingAnchor == .bottomTrailing {
            // Adjust for Inset
            return CGPoint(
                x: rect.bottomLeading.x,
                y: rect.bottomLeading.y - leadingLegInsetAmount(in: rect)
            )
        } else if trailingAnchor == .topLeading {
            // Adjust for Inset
            return CGPoint(
                x: rect.bottomLeading.x + trailingLegInsetAmount(in: rect),
                y: rect.bottomLeading.y
            )
        } else {
            return rect.bottomLeading
        }
    }
    
    
    private func topLeadingPoint(in rect: CGRect) -> CGPoint {
        
        if leadingAnchor == .bottomLeading {
            // Adjust for Inset
            return CGPoint(
                x: rect.topLeading.x + leadingLegInsetAmount(in: rect),
                y: rect.topLeading.y
            )
        } else if trailingAnchor == .topTrailing {
            // Adjust for Inset
            return CGPoint(
                x: rect.topLeading.x,
                y: rect.topLeading.y + trailingLegInsetAmount(in: rect)
            )
        } else {
            return rect.topLeading
        }
    }
    
    
    private func topTrailingPoint(in rect: CGRect) -> CGPoint {
        if leadingAnchor == .topLeading {
            // Adjust for Inset
            return CGPoint(
                x: rect.topTrailing.x,
                y: rect.topTrailing.y + leadingLegInsetAmount(in: rect)
            )
        } else if trailingAnchor == .bottomTrailing {
            // Adjust for Inset
            return CGPoint(
                x: rect.topTrailing.x - trailingLegInsetAmount(in: rect),
                y: rect.topTrailing.y
            )
        } else {
            return rect.topTrailing
        }
    }
    
    
    private func bottomTrailingPoint(in rect: CGRect) -> CGPoint {
        
        if leadingAnchor == .topTrailing {
            // Adjust for Inset
            return CGPoint(
                x: rect.bottomTrailing.x - leadingLegInsetAmount(in: rect),
                y: rect.bottomTrailing.y
            )
        } else if trailingAnchor == .bottomLeading {
            // Adjust for Inset
            return CGPoint(
                x: rect.bottomTrailing.x,
                y: rect.bottomTrailing.y - trailingLegInsetAmount(in: rect)
            )
        } else {
            return rect.bottomTrailing
        }
    }
    
}


// MARK: - AnimatableData
extension Trapezoid {

    public var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(leadingLegInsetPercentage, trailingLegInsetPercentage)
        }
        set {
            leadingLegInsetPercentage = newValue.first
            trailingLegInsetPercentage = newValue.second
        }
    }
}



#if DEBUG

import SwiftUIPreviewUtils

// MARK: - Preview
struct TrapezoidShape_Previews: PreviewProvider {

    static var previews: some View {
        
        VStack {
            Text("Trapezoids!")
            
            Trapezoid()
            
            Trapezoid(leadingLegInsetPercentage: 10)
                .fill(Color.yellow)
                .frame(height: 100, alignment: .center)
            
            Trapezoid(
                leadingLegInsetPercentage: 30,
                trailingLegInsetPercentage: 33
            )
            .fill(Color.yellow)
            .frame(height: 100, alignment: .center)
            
            
            Trapezoid(
                leadingAnchor: .bottomTrailing,
                trailingAnchor: .topLeading,
                leadingLegInsetPercentage: 20,
                trailingLegInsetPercentage: 20
            )
        }
        
        Group {
            Trapezoid()
        }
        .previewLayout(.fixed(width: 333, height: 222))
    }
}
#endif
