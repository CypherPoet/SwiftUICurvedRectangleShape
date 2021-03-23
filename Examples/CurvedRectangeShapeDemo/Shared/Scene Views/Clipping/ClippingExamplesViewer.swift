//
// ClippingExamplesViewer.swift
// CurvedRectangleShapeDemo
//
// Created by CypherPoet on 3/19/21.
// ✌️
//

import SwiftUI


struct ClippingExamplesViewer {
    @ScaledMetric private var baseFontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
}


// MARK: - `View` Body
extension ClippingExamplesViewer: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: baseFontSize) {
                headerSection
                
                descriptionSection
                    .padding(.horizontal)
                    .fixedSize(horizontal: false, vertical: true)
                
                ImageCollageView()
                
                Spacer()
            }
            .background(ThemeColors.background1)
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}


// MARK: - Computeds
extension ClippingExamplesViewer {
    var headerHeight: CGFloat { baseFontSize * 12.5 }
}


// MARK: - View Content Builders
private extension ClippingExamplesViewer {
    
    var headerSection: some View {
        Image("Clips")
            .resizable()
            .scaledToFill()
            .frame(height: headerHeight)
            .clipShape(
                CurvedRectangle(
                    trailingDepthPercentage: 12
                )
            )
            .overlay(
                Text("Clipping")
                    .font(.system(size: baseFontSize * 4, weight: .black, design: .rounded))
                    .textCase(.uppercase)
                    .foregroundColor(.white)
                    .opacity(0.8)
                    .blendMode(.colorDodge)
                    .shadow(color: .black, radius: baseFontSize * 0.74)
            )
            .shadow(radius: baseFontSize * 0.74)
    }
    
    
    var descriptionSection: some View {
        VStack(spacing: baseFontSize * 2) {
            Text("A huge advantage of using the `Shape` type is that we can apply is as a mask using the `clipShape` modifier.")
            
            Text("This can be especially useful for images that might not otherwise conform to our... geometrical gestalt.")
        }
        .foregroundColor(ThemeColors.secondaryAccent3)
    }
}


private extension ClippingExamplesViewer {
    
    struct ImageCollageView {
        //    @State private var frameSize: CGSize = .init()
    }
}


extension ClippingExamplesViewer.ImageCollageView: View {
    
    var body: some View {
        VStack {
            Image("NightSky1")
                .resizable()
                .scaledToFill()
                .frame(height: 200, alignment: .center)
                .clipShape(
                    CurvedRectangle(
                        curveAxis: .vertical,
                        leadingDepthPercentage: 100,
                        trailingDepthPercentage: -120
                    )
                )
                .padding(.horizontal)
                .padding(.horizontal)
            
            
            Image("Mountain")
                .resizable(
                    capInsets: .init(
                        top: 40,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    ),
                    resizingMode: .stretch
                )
                .scaledToFill()
                .frame(height: 120, alignment: .center)
                .clipShape(
                    CurvedRectangle(
                        curveAxis: .horizontal,
                        leadingDepthPercentage: 8,
                        trailingDepthPercentage: 8
                    )
                )
                .padding(.horizontal)
            
            Image("NightSky2")
                .resizable()
                .scaledToFill()
                .frame(height: 200, alignment: .center)
                .clipShape(
                    CurvedRectangle(
                        curveAxis: .vertical,
                        leadingDepthPercentage: -120,
                        trailingDepthPercentage: 100
                    )
                )
                .padding(.horizontal)
                .padding(.horizontal)
        }
    }
}



#if DEBUG

// MARK: - Preview

import SwiftUIPreviewUtils

struct ClippingExamplesViewer_Previews: PreviewProvider {
    
    static var previews: some View {
        ClippingExamplesViewer()
            .previewDevice("iPhone 8")
            .openedFromNavigationLink(startsActive: true)
    }
}
#endif
