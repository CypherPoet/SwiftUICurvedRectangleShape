//
// RootView.swift
// Shared
//
// Created by CypherPoet on 3/11/21.
// ✌️
//

import SwiftUI


struct RootView {
}


// MARK: - `View` Body
extension RootView: View {

    var body: some View {
        NavigationView {
            WelcomeSceneViewer()
        }
        .accentColor(.Theme2.primaryAccent)
    }
}


// MARK: - Computeds
extension RootView {
}


// MARK: - View Content Builders
private extension RootView {
}


// MARK: - Private Helpers
private extension RootView {
}


#if DEBUG
// MARK: - Preview
struct RootView_Previews: PreviewProvider {

    static var previews: some View {
        RootView()
    }
}
#endif
