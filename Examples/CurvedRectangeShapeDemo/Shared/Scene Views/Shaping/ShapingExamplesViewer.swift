//
// ShapingExamplesViewer.swift
// CurvedRectangleShapeDemo
//
// Created by CypherPoet on 3/17/21.
// ✌️
//

import SwiftUI


struct ShapingExamplesViewer {
    @ScaledMetric private var baseFontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
}


// MARK: - `View` Body
extension ShapingExamplesViewer: View {
    
    var body: some View {
        VStack(spacing: 0) {
            headerSection
            
            ScrollView {
                VStack(spacing: sectionSpacing) {
                    curveAxisSection
                    curveDepthSection
                    depthPercentagesSection
                    otherNotesSection
                }
                .padding(.horizontal)
                .padding(.top)
                .foregroundColor(.Theme2.secondaryAccent3)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}


// MARK: - Computeds
extension ShapingExamplesViewer {
    var headerHeight: CGFloat { baseFontSize * 10 }
    var sectionSpacing: CGFloat { baseFontSize * 2.4 }
    var sectionTitleSpacing: CGFloat { baseFontSize * 1.6 }
    var sectionLineSpacing: CGFloat { baseFontSize * 1.2 }
}


// MARK: - View Content Builders
private extension ShapingExamplesViewer {
    
    var headerSection: some View {
        CurvedRectangle(
            curveAxis: .vertical,
            trailingDepthPercentage: 10
        )
        .fill(Color.Theme2.background1)
        .shadow(color: Color.Theme2.secondaryAccent2.opacity(0.7), radius: baseFontSize)
        .overlay(
            Text("Customization Options")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .shadow(color: .primary.opacity(0.24), radius: baseFontSize * 0.5, x: 1, y: 2.5)
                .padding(.horizontal)
                .padding(.top)
                .padding(.top)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .blendMode(.sourceAtop)
        )
        .frame(height: headerHeight)
    }
    
    
    var curveAxisSection: some View {
        Section {
            VStack(spacing: sectionTitleSpacing) {
                VStack(spacing: sectionLineSpacing / 2) {
                    Text("Curve Axis")
                        .font(.title)
                        .fontWeight(.light)
                    
                    Text("This is the set of sides you wish to curve while keeping the rectangle's other sets of sides parallel.")
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                
                VStack(spacing: sectionLineSpacing) {
                    ExampleCurveView(
                        title: "Horizontal-Side Curving",
                        curveAxis: .horizontal,
                        leadingDepthPercentage: 10,
                        trailingDepthPercentage: 10
                    )
                    
                    ExampleCurveView(
                        title: "Vertical-Side Curving",
                        curveAxis: .vertical,
                        leadingDepthPercentage: 10,
                        trailingDepthPercentage: 10
                    )
                }
                .padding(.horizontal)
            }
        }
    }
    
    
    var curveDepthSection: some View {
        Section {
            VStack(spacing: sectionTitleSpacing) {
                
                VStack(spacing: sectionLineSpacing / 2) {
                    Text("Curve Depth")
                        .font(.title)
                        .fontWeight(.light)
                    
                    Text("This is a percentage of the overall length of the shape along the curved-side axis.")
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                
                VStack(spacing: sectionLineSpacing) {
                    Text("It can be set for the \"leading\" side along the curved axis:")
                        .font(.callout)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing: baseFontSize) {
                        ExampleCurveView(
                            title: "Horizontal Axis",
                            curveAxis: .horizontal,
                            leadingDepthPercentage: 21
                        )
                        ExampleCurveView(
                            title: "Vertical Axis",
                            curveAxis: .vertical,
                            leadingDepthPercentage: 21
                        )
                    }
                }
                
                
                VStack(spacing: sectionLineSpacing) {
                    Text("Or the \"trailing\" side.")
                        .font(.callout)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing: baseFontSize) {
                        ExampleCurveView(
                            title: "Horizontal Axis",
                            curveAxis: .horizontal,
                            trailingDepthPercentage: 21
                        )
                        ExampleCurveView(
                            title: "Vertical Axis",
                            curveAxis: .vertical,
                            trailingDepthPercentage: 21
                        )
                    }
                }
                
                VStack(spacing: sectionLineSpacing) {
                    Text("Or both!")
                        .font(.callout)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing: baseFontSize) {
                        ExampleCurveView(
                            title: "Horizontal Axis",
                            curveAxis: .horizontal,
                            leadingDepthPercentage: 21,
                            trailingDepthPercentage: 21
                        )
                        ExampleCurveView(
                            title: "Vertical Axis",
                            curveAxis: .vertical,
                            leadingDepthPercentage: 21,
                            trailingDepthPercentage: 21
                        )
                    }
                }
            }
        }
    }
    
    
    var depthPercentagesSection: some View {
        Section {
            VStack(spacing: sectionTitleSpacing) {
                
                Text("Concave or Convex")
                    .font(.title)
                    .fontWeight(.light)
                
                
                VStack(spacing: sectionLineSpacing) {
                    
                    Text("Depth percentages can be positive to create convex curves:")
                        .font(.callout)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing: baseFontSize) {
                        ExampleCurveView(
                            curveAxis: .horizontal,
                            leadingDepthPercentage: 24,
                            trailingDepthPercentage: 24
                        )
                        ExampleCurveView(
                            curveAxis: .vertical,
                            leadingDepthPercentage: 24,
                            trailingDepthPercentage: 24
                        )
                    }
                }
            }
            
            
            VStack(spacing: sectionLineSpacing) {
                Text("Or negative to create concave curves:")
                    .font(.callout)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack(spacing: baseFontSize) {
                    ExampleCurveView(
                        curveAxis: .horizontal,
                        leadingDepthPercentage: -24,
                        trailingDepthPercentage: -24
                    )
                    ExampleCurveView(
                        curveAxis: .vertical,
                        leadingDepthPercentage: -24,
                        trailingDepthPercentage: -24
                    )
                }
            }
            
            
            VStack(spacing: sectionLineSpacing) {
                Text("You can also mix and match:")
                    .font(.callout)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack(spacing: baseFontSize) {
                    ExampleCurveView(
                        leadingDepthPercentage: 24,
                        trailingDepthPercentage: -24
                    )
                    
                    ExampleCurveView(
                        leadingDepthPercentage: -24,
                        trailingDepthPercentage: 24
                    )
                }
            }
        }
    }
    
    var otherNotesSection: some View {
        Section {
            
            VStack(spacing: sectionTitleSpacing) {
                
                Text("Additional Notes")
                    .font(.title)
                    .fontWeight(.light)
                
                
                VStack(spacing: sectionLineSpacing) {
                    
                    ExampleCurveView(
                        title: "By default, no depth assumptions are made -- you'll get a standard rectangle."
                    )
                    
                    Text("Also worth noting: Rectangle vertex points are adjusted to keep the shape within its frame.")
                    
                    ExampleCurveView(
                        leadingDepthPercentage: 30,
                        trailingDepthPercentage: -30
                    )
                    .border(Color.blue, width: 2)
                }
            }
        }
    }
}


// MARK: - Private Helpers
private extension ShapingExamplesViewer {
}


// MARK: - Example View
private extension ShapingExamplesViewer {
    
    struct ExampleCurveView: View {
        @ScaledMetric private var baseFontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
        
        var title: String = ""
        var curveAxis: Axis = .vertical
        var leadingDepthPercentage: CGFloat = 0
        var trailingDepthPercentage: CGFloat = 0
        var fillColor: Color = .Theme2.primaryAccent
        
        
        var body: some View {
            baseShape
                .overlay(
                    baseShape
                        .opacity(0.6)
                        .blur(radius: rectangleHeight * 0.1)
                )
                .overlay(
                    Text(title)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .padding()
                )
                .frame(height: rectangleHeight)
        }
        
        
        var baseShape: some View {
            CurvedRectangle(
                curveAxis: curveAxis,
                leadingDepthPercentage: leadingDepthPercentage,
                trailingDepthPercentage: trailingDepthPercentage
            )
            .fill(fillColor)
        }
        
        
        var rectangleHeight: CGFloat {
            baseFontSize * 8
        }
    }
}




#if DEBUG

// MARK: - Preview

import SwiftUIPreviewUtils


struct ShapingExamplesViewer_Previews: PreviewProvider {
    
    static var previews: some View {
        ShapingExamplesViewer()
            .openedFromNavigationLink()
            .previewLayout(.device)
            .previewInColorSchemes()
    }
}

#endif
