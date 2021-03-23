//
// WelcomeOptionsView.swift
// CurvedRectangleShapeDemo
//
// Created by CypherPoet on 3/16/21.
// ✌️
//

import SwiftUI


struct WelcomeOptionsView<Destination>
    where Destination: View
{
    @ScaledMetric private var baseFontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
    
    var buildDestination: ((WelcomeSceneOption) -> Destination)
}


// MARK: - `View` Body
extension WelcomeOptionsView: View {

    var body: some View {
        LazyVGrid(
            columns: gridLayout,
            spacing: baseFontSize
        ) {
            ForEach(WelcomeSceneOption.allCases, id: \.self) { sceneOption in
                NavigationLink(
                    destination: buildDestination(sceneOption),
                    label: {
                        WelcomeOptionCardView(title: sceneOption.titleForDisplay)
                            .frame(height: baseFontSize * 8)
                    }
                )
            }
        }
    }
}


// MARK: - Computeds
extension WelcomeOptionsView {
    
    var gridLayout: [GridItem] {
        [
            GridItem(.flexible(), spacing: baseFontSize),
            GridItem(.flexible(), spacing: baseFontSize),
        ]
    }
    
}


// MARK: - View Content Builders
private extension WelcomeOptionsView {
}


// MARK: - Private Helpers
private extension WelcomeOptionsView {
}


private struct WelcomeOptionCardView  {
    @ScaledMetric private var baseFontSize = UIFont.preferredFont(forTextStyle: .body).pointSize

    var title: String
}


extension WelcomeOptionCardView: View {

    var body: some View {
        CurvedRectangle(
            curveAxis: .vertical,
            leadingDepthPercentage: -20,
            trailingDepthPercentage: 20
        )
        .fill(ThemeColors.primaryAccent)
        .shadow(radius: baseFontSize * 0.7)
        .overlay(
            Text(title)
                .foregroundColor(.white)
                .font(.title2)
                .fontWeight(.semibold)
        )
    }
}




#if DEBUG
// MARK: - Preview
struct WelcomeOptionsView_Previews: PreviewProvider {

    static var previews: some View {
        WelcomeOptionsView(
            buildDestination: { _ in EmptyView() }
        )
        .accentColor(ThemeColors.primaryAccent)
        .previewLayout(.sizeThatFits)
    }
}
#endif
