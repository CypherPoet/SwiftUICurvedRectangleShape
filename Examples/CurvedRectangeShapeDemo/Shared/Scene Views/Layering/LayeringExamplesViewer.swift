//
// LayeringExamplesViewer.swift
// CurvedRectangleShapeDemo
//
// Created by CypherPoet on 3/21/21.
// ✌️
//

import SwiftUI


struct LayeringExamplesViewer {
    @ScaledMetric private var baseFontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
    
    @State private var screenHeight: CGFloat = 0.0
}


// MARK: - `View` Body
extension LayeringExamplesViewer: View {
    
    var body: some View {
        ZStack {
            LayeredBackgroundView(
                totalHeight: screenHeight
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: baseFontSize) {
                headerSection
                
                descriptionSection
                    .padding(.horizontal)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .readingFrameSize { newSize in
            screenHeight = newSize.height
        }
    }
}


// MARK: - Computeds
extension LayeringExamplesViewer {
    var headerHeight: CGFloat { baseFontSize * 7 }
}


// MARK: - View Content Builders
private extension LayeringExamplesViewer {
    
    var headerSection: some View {
        CurvedRectangle(
            trailingDepthPercentage: 12
        )
        .fill(Color.Theme2.background1)
        .frame(height: headerHeight)
        .shadow(radius: baseFontSize * 0.74)
    }
    
    
    var descriptionSection: some View {
        VStack(spacing: baseFontSize * 2) {
            Text("Layering & Compositing")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.Theme2.secondaryAccent3)
    }
}



#if DEBUG

// MARK: - Preview

import SwiftUIPreviewUtils

struct LayeringExamplesViewer_Previews: PreviewProvider {
    
    static var previews: some View {
        LayeringExamplesViewer()
            .openedFromNavigationLink(startsActive: true)
            .previewInColorSchemes(withLayout: .device)
    }
}
#endif
