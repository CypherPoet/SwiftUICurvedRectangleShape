//
// AnimationExamplesViewer.swift
// CurvedRectangleShapeDemo
//
// Created by CypherPoet on 3/22/21.
// ✌️
//

import SwiftUI


struct AnimationExamplesViewer {
    @ScaledMetric private var baseFontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
    
    @State private var screenHeight: CGFloat = 0.0
    @State private var shapeAnimationState: ShapeAnimationState = .default
}


// MARK: - `View` Body
extension AnimationExamplesViewer: View {
    
    var body: some View {
        ZStack {
            backgroundGradient
            
            VStack(spacing: baseFontSize) {
                headerSection
                
                descriptionSection
                    .padding(.horizontal)
                    .fixedSize(horizontal: false, vertical: true)
                
                animationButton
                
                Spacer()
                
                demoShape
                    .offset(
                        x: 0,
                        y: shapeAnimationState == .expanded ? 0 : screenHeight / 2
                    )
            }
        }
        .edgesIgnoringSafeArea(.all)
        .readingFrameSize { newSize in
            screenHeight = newSize.height
        }
    }
}


// MARK: - Computeds
extension AnimationExamplesViewer {
    var headerHeight: CGFloat { baseFontSize * 7 }
}


// MARK: - View Content Builders
private extension AnimationExamplesViewer {
    
    var backgroundGradient: some View {
        LinearGradient(gradient: CustomGradients.screenBackground1, startPoint: .top, endPoint: .bottom)
    }

    var headerSection: some View {
        CurvedRectangle(
            trailingDepthPercentage: 12
        )
        .fill(Color.Theme2.background1)
        .frame(height: headerHeight)
        .shadow(radius: baseFontSize * 0.74)
    }
    
    
    var animationButton: some View {
        Button(
            action: handleAnimationButtonPress,
            label: {
                Text("Animate")
            }
        )
        .buttonStyle(ButtonStyles.OutlinedCallToAction())
    }
    
    
    var descriptionSection: some View {
        VStack(spacing: baseFontSize * 2) {
            Text("Animation")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("As a `Shape`, CurvedRectangle adopts the Animatable protocol by setting its leading and trailing curve offset amounts as \"animatable data.\"")
        }
        .foregroundColor(.Theme2.secondaryAccent3)
    }
    
    
    var demoShape: some View {
        CurvedRectangle(
            curveAxis: .vertical,
            leadingDepthPercentage: shapeAnimationState == .expanded ? -20 : 10
        )
    }
}


// MARK: - Private Helpers
extension AnimationExamplesViewer {
    func handleAnimationButtonPress() {
        withAnimation(.easeInOut) {
            shapeAnimationState = shapeAnimationState == .expanded ?
                .default
                : .expanded
        }
    }
}

// MARK: - ShapeAnimationState
extension AnimationExamplesViewer {
    
    enum ShapeAnimationState {
        case `default`
        case expanded
    }
}



#if DEBUG

// MARK: - Preview

import SwiftUIPreviewUtils

struct AnimationExamplesViewer_Previews: PreviewProvider {
    
    static var previews: some View {
        AnimationExamplesViewer()
            .openedFromNavigationLink(startsActive: true)
            .previewInColorSchemes(withLayout: .device)
            .accentColor(.Theme2.primaryAccent)
    }
}
#endif
