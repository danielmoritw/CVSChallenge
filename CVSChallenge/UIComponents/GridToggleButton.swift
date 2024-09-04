//
//  GridToggleButton.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import SwiftUI

struct GridToggleButton: View {
    @Binding var gridWithMultipleLines: Bool
    
    var body: some View {
        Button(action: {
            gridWithMultipleLines.toggle()
        }, label: {
            Image(systemName: gridWithMultipleLines == false ? "square.grid.3x2.fill" : "rectangle.grid.1x2.fill")
                .symbolEffect(.bounce.byLayer, value: gridWithMultipleLines)
        })
        .accessibilityAddTraits(.isToggle)
        .accessibilityLabel("Toggles between grid view and inline view. Current state is \(gridWithMultipleLines == false ? "inline." : "grid.")")
    }
}

#Preview {
    GridToggleButton(gridWithMultipleLines: .constant(false))
}
