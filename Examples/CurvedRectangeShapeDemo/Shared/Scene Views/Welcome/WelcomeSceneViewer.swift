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
        .background(Color(.systemGroupedBackground))
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
            Image("EarthAtNight")
                .resizable()
                .scaledToFill()
                .frame(height: headerHeight)
                .mask(
                    CurvedRectangle(
                        curveAxis: .vertical,
                        trailingDepthPercentage: 14
                    )
                )
                .shadow(radius: baseFontSize * 0.8)
                
            
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
    
    
    var footerSection: some View {
        CurvedRectangle(
            curveAxis: .vertical,
            leadingDepthPercentage: 24
        )
        .fill(Color.Theme2.primaryAccent)
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
            Text("clipping all the things")
        case .layering:
            Text("layering all the things")
        case .animating:
            Text("animating all the things")
        }
    }
}


#if DEBUG
// MARK: - Preview
struct CurveSidedRectangleViewer_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            WelcomeSceneViewer()
        }
        .accentColor(.Theme2.primaryAccent)
    }
}
#endif
