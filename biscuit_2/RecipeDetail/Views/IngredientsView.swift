//
//  IngredientsView.swift
//  biscuit_2
//
//  Created by kelly on 6/24/25.
//

import SwiftUI

struct IngredientsView: View {
    enum Focusable: CustomStringConvertible, Hashable {
        case none
        case row(group: Int, item: Int)

        var description: String {
            switch self {
            case .row(let group, let item): return "Row \(group), Item \(item)"
            default: return "None"
            }
        }
    }

    @ObservedObject var ingredientGroups: ObservableArray<IngredientGroup>
    let editMode: Bool
    @FocusState var focusedTextField: Focusable?

    // move ingredient
    // edit headings
    // add ingredient group

    var body: some View {
        List {
            ForEach(
                Array(ingredientGroups.array.enumerated()),
                id: \.element.heading
            ) { groupIndex, ingredientGroup in
                Section {
                    ForEach(
                        Array(ingredientGroup.items.enumerated()),
                        id: \.element
                    ) { itemIndex, item in
                        if !editMode {
                            Text(item)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical, 2).deleteDisabled(
                                    !editMode
                                )
                        } else {
                            HStack {
                                TextField(
                                    "Edit item",
                                    text:
                                        Binding(
                                            get: {
                                                ingredientGroups.array[
                                                    groupIndex
                                                ]
                                                .items[itemIndex]
                                            },
                                            set: { newValue in
                                                ingredientGroups.array[
                                                    groupIndex
                                                ]
                                                .items[itemIndex] = newValue
                                            }
                                        )
                                ).focused(
                                    $focusedTextField,
                                    equals: Focusable.row(
                                        group: groupIndex,
                                        item: itemIndex
                                    )
                                )
                                Spacer()

                                Button(action: {
                                    // Handle the action for the button
                                    print("Button tapped for item: \(item)")
                                }) {
                                    Image(systemName: "line.3.horizontal")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }.deleteDisabled(!editMode)  // HStack

                        }  // else
                    }  // List (nested)
                    .onDelete { indexSet in
                        ingredientGroups.array[groupIndex].items.remove(
                            atOffsets: indexSet
                        )
                    }

                    if editMode {
                        Button(action: {
                            var updateItem = ingredientGroups.array[
                                groupIndex
                            ].items
                            if(updateItem.last?.isEmpty == false) {
                                updateItem.append("")
                            }
                            ingredientGroups.array[groupIndex] =
                                IngredientGroup(
                                    heading: ingredientGroup.heading,
                                    items: updateItem
                                )
                            focusedTextField = Focusable.row(
                                group: groupIndex,
                                item: updateItem.count - 1
                            )
                        }) {
                            Text("+ Add Ingredient").font(.body)
                                .foregroundColor(.blue)
                        }
                    }

                } header: {
                    // update header name
                    Text(ingredientGroup.heading)
                        .font(.headline)
                    // add a minus sign to delete group
                }
            }
        }.listStyle(PlainListStyle())
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height,
                alignment: .center
            ).scrollDisabled(true)

    }
}

struct IngredientsView_Previews:
    PreviewProvider
{
    static var previews: some View {
        IngredientsView(
            ingredientGroups: ObservableArray(array: [
                IngredientGroup(heading: "Fruits", items: ["Apple", "Banana"]),
                IngredientGroup(
                    heading: "Vegetables",
                    items: ["Carrot", "Broccoli"]
                ),
            ]),
            editMode: true
        )
    }
}
