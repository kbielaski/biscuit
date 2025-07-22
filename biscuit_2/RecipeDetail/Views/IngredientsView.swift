//
//  IngredientsView.swift
//  biscuit_2
//
//  Created by kelly on 6/24/25.
//

import SwiftUI

enum Focusable: CustomStringConvertible, Hashable {
    case none
    case section(group: UUID)
    case row(group: UUID, item: UUID)

    var description: String {
        switch self {
        case .row(let group, let item):
            return "Row \(group.description), Item \(item.description)"
        case .section(let group): return "Group \(group.description)"
        default: return "None"
        }
    }
}

struct SectionHeader: View {
    @Binding var title: String
    let groupId: UUID
    let editMode: Bool
    @FocusState.Binding var focusedTextField: Focusable?
    let deleteIngredientGroup: (_ groupId: UUID) -> Void
    let closeIngredientGroup: (_ groupId: UUID) -> Void
    // pass in isRenaming
    @State var isRenaming: Bool = false

    var body: some View {
        if editMode {
            HStack {
                Button(action: {
                    closeIngredientGroup(groupId)
                }) {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }

                if isRenaming {
                    TextField(
                        "Section name",
                        text: $title,
                        onCommit: {
                            // Handle the commit action, e.g., save the new title
                            // needs to be a non-empty string
                            isRenaming = false
                        }
                    ).font(.headline)
                        .foregroundColor(.secondary)
                        .focused(
                            $focusedTextField,
                            equals: Focusable.section(
                                group: groupId
                            )
                        )
                } else {
                    Menu(title) {
                        Button(
                            "Rename",
                            action: {
                                // make focus the header
                                isRenaming.toggle()
                                focusedTextField = Focusable.section(
                                    group: groupId
                                )
                            }
                        )
                        Button(
                            role: .destructive,
                            action: {
                                deleteIngredientGroup(groupId)
                            }
                        ) {
                            Text("Remove ingredient section")
                        }
                    }.font(.headline)
                        .foregroundColor(.secondary)

                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)

                }
            }
        } else {
            Text(title).font(.headline)
                .foregroundColor(.secondary)
        }
    }
}

struct IngredientsView: View {
    @State var ingredientGroups: ObservableArray<IngredientGroup>
    let editMode: Bool
    @FocusState var focusedTextField: Focusable?

    // move ingredient
    // edit headings
    // add ingredient group

    func addIngredient(groupId: UUID, ingredientGroupHeading: String) {
        if let groupIndex = ingredientGroups.array.firstIndex(where: {
            $0.id == groupId
        }) {

            var updateItem = ingredientGroups.array[
                groupIndex
            ].items
            if updateItem.count == 0 || updateItem.last?.name.isEmpty == false {
                updateItem.append(Ingredient(name: ""))
            }
            ingredientGroups.array[groupIndex] =
                IngredientGroup(
                    heading: ingredientGroupHeading,
                    items: updateItem
                )
            if let itemId = updateItem.last?.id {
                focusedTextField = Focusable.row(
                    group: ingredientGroups.array[groupIndex].id,
                    item: itemId
                )
            }

        }

    }

    func closeIngredientGroup(groupId: UUID) {
        if let groupIndex = ingredientGroups.array.firstIndex(where: {
            $0.id == groupId
        }) {
            ingredientGroups.array[groupIndex].isExpanded.toggle()
        }
    }

    func deleteIngredientGroup(groupId: UUID) {
        if let groupIndex = ingredientGroups.array.firstIndex(where: {
            $0.id == groupId
        }) {
            ingredientGroups.array.remove(at: groupIndex)
        }
    }

    var body: some View {
        VStack(spacing: 0) {

            List {
                ForEach(
                    $ingredientGroups.array
                ) { $ingredientGroup in
                    Section(
                        isExpanded: $ingredientGroup.isExpanded
                    ) {
                        ForEach(
                            $ingredientGroup.items,
                        ) { $item in
                            if !editMode {
                                Text(item.name)
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
                                                    item.name
                                                },
                                                set: { newValue in
                                                    item.name = newValue
                                                }
                                            )
                                    ).focused(
                                        $focusedTextField,
                                        equals: Focusable.row(
                                            group: ingredientGroup.id,
                                            item: item.id
                                        )
                                    )
                                    Spacer()
                                    Button(action: {}) {
                                        Image(systemName: "line.3.horizontal")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }.deleteDisabled(!editMode)  // HStack
                            }  // else
                        }  // List (nested)
                        .onDelete { indexSet in
                            ingredientGroup.items.remove(atOffsets: indexSet)
                        }
                        if editMode {
                            Button(action: {
                                addIngredient(
                                    groupId: ingredientGroup.id,
                                    ingredientGroupHeading: ingredientGroup
                                        .heading
                                )
                            }) {
                                Text("+ Add Ingredient").font(.body)
                                    .foregroundColor(.blue)
                            }
                        }
                    } header: {
                        SectionHeader(
                            title: $ingredientGroup.heading,
                            groupId: ingredientGroup.id,
                            editMode: editMode,
                            focusedTextField: $focusedTextField,
                            deleteIngredientGroup: deleteIngredientGroup,
                            closeIngredientGroup: closeIngredientGroup
                        )
                    }

                }

                if editMode {
                    Button(action: {
                        if ingredientGroups.array.count == 0
                            || ingredientGroups.array.last?.heading.isEmpty
                                == false
                        {
                            ingredientGroups.array.append(
                                IngredientGroup(heading: "")
                            )
                            let groupId = ingredientGroups.array.last?.id {
                                focusedTextField = Focusable.section(
                                    group:groupId
                                )
                            }
                        }
                    }) {
                        Text("Create new ingredient section")
                            .frame(
                                width: UIScreen.main.bounds.width - 30,
                                height: 50
                            )
                            .background(Color.gray.opacity(0.1))
                            .padding(.vertical, 2)
                            .ignoresSafeArea()
                            .cornerRadius(12)

                    }
                }
            }.listStyle(PlainListStyle())
                .scrollDisabled(true)
        }.frame(
            width: .infinity,
            height: editMode
                ? UIScreen.main.bounds.height  // + 300
                : UIScreen.main.bounds.height,  // calculate this manually
            alignment: .center
        )

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
