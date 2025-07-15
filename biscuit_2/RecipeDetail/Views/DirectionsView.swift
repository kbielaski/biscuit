//
//  DirectionsView.swift
//  biscuit_2
//
//  Created by kelly on 6/26/25.
//

import SwiftUI

struct DirectionsView: View {
    let recipe: Recipe

    var body: some View {
        VStack {
            ForEach(Array(recipe.directions.enumerated()), id: \.element) {
                index,
                directionItem in
                HStack(alignment: .top) {
                    Text("\(index + 1).")
                        .font(.body)
                        .bold()
                    Text(directionItem)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.bottom, 4)
            }
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        ).padding(.leading, 12)
    }

}

struct DirectionsView_Previews:
    PreviewProvider
{
    static var previews: some View {
        DirectionsView(recipe: sampleRecipes[0])
    }
}
