//
// WelcomeSceneViewer.swift
// Shared
//
// Created by CypherPoet on 3/14/21.
// ✌️
//

import SwiftUI
import SwiftUIStarterKit


struct WelcomeSceneViewer {
    @State private var screenHeight = CGFloat(0)
    @ScaledMetric private var baseFontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
}


// MARK: - `View` Body
extension WelcomeSceneViewer: View {

    var body: some View {
        VStack {
            headerSection
         
            Spacer()
            
            WelcomeOptionsView(
                buildDestination: buildDestination(for:)
            )
            .padding(.horizontal)
            
            Spacer()
            
            footerSection
        }
        .navigationBarHidden(true)
        .background(ThemeColors.background1)
        .edgesIgnoringSafeArea(.vertical)
        .readingFrameSize { newSize in
            screenHeight = newSize.height
        }
    }
}


// MARK: - Computeds
extension WelcomeSceneViewer {
    
    var headerHeight: CGFloat {
        screenHeight * 0.25
    }
}


// MARK: - View Content Builders
private extension WelcomeSceneViewer {
    
    var headerSection: some View {
        ZStack {
            ImageAssets.earthAtNight
                .resizable()
                .scaledToFill()
                .frame(height: headerHeight)
                .mask(
                    CurvedRectangle(
                        curveAxis: .vertical,
                        trailingDepthPercentage: 14
                    )
                )
                .shadow(color: .black, radius: baseFontSize * 0.8)
                
            
            Text("Curved Rectangle")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
        }
    }
    
    
    var footerSection: some View {
        CurvedRectangle(
            curveAxis: .vertical,
            leadingDepthPercentage: 24
        )
        .fill(ThemeColors.secondaryAccent3)
        .frame(height: headerHeight * 0.5)
        .shadow(radius: baseFontSize)
    }
}


// MARK: - Private Helpers
private extension WelcomeSceneViewer {
    
    @ViewBuilder
    func buildDestination(for option: WelcomeSceneOption) -> some View {
        switch option {
        case .shaping:
            ShapingExamplesViewer()
        case .clipping:
            ClippingExamplesViewer()
        case .layering:
            LayeringExamplesViewer()
        case .animating:
            AnimationExamplesViewer()
        }
    }
}


#if DEBUG

// MARK: - Preview

import SwiftUIPreviewUtils

struct CurveSidedRectangleViewer_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            WelcomeSceneViewer()
        }
        .accentColor(ThemeColors.primaryAccent)
        .previewInColorSchemes()
    }
}

#endif
