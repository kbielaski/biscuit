//
//  NotesView.swift
//  biscuit_2
//
//  Created by kelly on 6/26/25.
//

import SwiftUI

struct NotesView: View {
    let recipe: Recipe
    
    func source() -> String {
        if let summary = recipe.source {
            return "Source: \(summary.author) (\(summary.url))"
        } else {
            return ""
        }
    }

    var body: some View {
        VStack {
            // add source here
            let sourceText = source()
            HStack {
                if (!sourceText.isEmpty) {
                    Text(sourceText)
                        .font(.footnote)
                        .padding(.bottom, 4)
                }
            }
            ForEach(recipe.notes, id: \.self) { noteItem in
                Text(noteItem)
                    .font(.body)
                    .multilineTextAlignment(.leading).frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    ).padding(.bottom, 4)
            }
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        ).padding(.leading, 12)
    }

}

struct NotesView_Previews:
    PreviewProvider
{
    static var previews: some View {
        NotesView(recipe: sampleRecipes[0])
    }
}
