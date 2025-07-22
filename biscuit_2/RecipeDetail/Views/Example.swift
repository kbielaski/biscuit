//
//  Example.swift
//  biscuit_2
//
//  Created by kelly on 7/20/25.
//

import Observation
import SwiftUI

struct SectionData: Identifiable {
    let id = UUID()
    let title: String
}

struct LoginForm: View {
    @State private var array = [SectionData(title: "hi"),SectionData(title: "hello"),SectionData(title: "apple")]
   
    var body: some View {
        List {
            ForEach(
                Array(array.enumerated()),
                id: \.element.id
            ) { groupIndex, ingredientGroup in
                Text(array[groupIndex].title)
            }
            Button(action: {
                array.remove(at: 0)
            }) {
                Text("Button").foregroundColor(.blue)
            }
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height,
            alignment: .center
        )
    }
}

struct LoginForm_Previews:
    PreviewProvider
{
    static var previews: some View {
        LoginForm()
    }
}
