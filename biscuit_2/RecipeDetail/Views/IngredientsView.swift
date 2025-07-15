//
//  IngredientsView.swift
//  biscuit_2
//
//  Created by kelly on 6/24/25.
//

import SwiftUI

struct IngredientsView: View {
    @Binding var ingredientGroups: [IngredientGroup]
    let editMode: Bool
    @State private var newIngredientGroup: String = ""
    @State private var focusedIndex: Int = -1
    @FocusState private var isCreateIngredientGroupFocused: Bool

    //    @State var formattedIngredients: [String] = []

    // move groups
    // deal with headings
    // edit existing groups

    func deleteIngredientGroup(at offsets: IndexSet) {
        ingredientGroups.remove(atOffsets: offsets)
    }

    func move(from source: IndexSet, to destination: Int) {
        ingredientGroups.move(fromOffsets: source, toOffset: destination)
    }

    // Make header bold
    var body: some View {
        VStack {
            List {
                ForEach(
                    Array(ingredientGroups.enumerated()),
                    id: \.element.heading
                ) { index, ingredientGroup in
                    VStack(alignment: .leading) {
                        @State var formattedGroup =
                            ingredientGroup.heading + "\n"
                            + ingredientGroup.items
                            .joined(separator: "\n")

                        if !editMode {
                            Text(
                                formattedGroup
                            )
                        } else if focusedIndex != index {
                            Text(
                                formattedGroup
                            ).onTapGesture {
                                focusedIndex = index
                            }
                        } else {
                            // nothing
                        }

                        if editMode && focusedIndex == index {
                            // maybe add a check to updatee

                            TextEditor(text: $formattedGroup)
                                .font(.body)
                                .padding(.horizontal, 5)
                                .padding(.top, 2)
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity
                                )
                                .background(Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            Color.secondary.opacity(0.2),
                                            lineWidth: 1
                                        )
                                )

                        }
                    }
                }.onDelete(perform: deleteIngredientGroup)
                    .onMove(perform: move)
                if editMode {
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $newIngredientGroup)
                            .focused($isCreateIngredientGroupFocused)
                            .onChange(of: isCreateIngredientGroupFocused) {

                                //                                ingredientGroups.append(
                                //                                    IngredientGroup(
                                //                                        header: "",
                                //                                        items: newIngredientGroup.components(
                                //                                            separatedBy: "\n"
                                //                                        ).filter { !$0.isEmpty }
                                //                                    )
                                //                                )
                            }
                            .font(.body)
                            .padding(.horizontal, 5)
                            .padding(.top, 2)
                            .frame(height: 100)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        Color.secondary.opacity(0.2),
                                        lineWidth: 1
                                    )
                            )

                        if newIngredientGroup.isEmpty {
                            Text("Enter new ingredient group...")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                        }
                    }

                }
                Button(action: {
                    // Add your action to handle adding a new ingredient group
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.accentColor)
                }
                .padding(.top, 4)
                .frame(
                    maxWidth: .infinity,
                    alignment: .bottomLeading
                )

            }

            .listStyle(PlainListStyle())
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .padding(.leading, 12)
    }

}

struct IngredientsView_Previews:
    PreviewProvider
{
    static var previews: some View {
        IngredientsView(
            ingredientGroups: .constant(sampleRecipes[0].ingredients),
            editMode: true
        )
    }
}
