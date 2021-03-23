//
// LayeringExamplesViewer+LayeredBackgroundView.swift
// CurvedRectangleShapeDemo
//
// Created by CypherPoet on 3/22/21.
// ✌️
//

import SwiftUI

fileprivate typealias LayeredBackgroundView = LayeringExamplesViewer.LayeredBackgroundView


extension LayeringExamplesViewer {
    struct LayeredBackgroundView {
        var layerCount: Int = 20
        var totalHeight: CGFloat
    }
}


// MARK: - `View` Body
extension LayeredBackgroundView: View {

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundGradient
            
            ForEach(0..<layerCount, id: \.self) { index in
                CurvedRectangle(
                    leadingDepthPercentage: CGFloat(
                        80 *
                        (CGFloat(index) / CGFloat(layerCount))
                    )
                )
                .fill(ThemeColors.secondaryAccent1)
                .opacity(opacityScalar * Double(index))
                .frame(
                    height: totalHeight - (heightReductionScalar * CGFloat(index)),
                    alignment: .center
                )
            }
        }
    }
    
    
    var heightReductionScalar: CGFloat {
        totalHeight / CGFloat(layerCount)
    }
    
    
    var opacityScalar: Double {
//        (1.0 / Double(layerCount)) * 0.9
        (0.35 / Double(layerCount))
    }
    
    
    var backgroundGradient: LinearGradient {
        .init(
            gradient: CustomGradients.screenBackground1,
            startPoint: .top,
            endPoint: .bottom
        )
    }
}


// MARK: - Computeds
extension LayeredBackgroundView {
}


// MARK: - View Content Builders
private extension LayeredBackgroundView {
}


// MARK: - Private Helpers
private extension LayeredBackgroundView {
}


#if DEBUG
// MARK: - Preview
struct LayeringExamplesViewer_LayeredBackgroundView_Previews: PreviewProvider {

    static var previews: some View {
        LayeredBackgroundView(
            totalHeight: 1000
        )
        .edgesIgnoringSafeArea(.all)
    }
}
#endif
