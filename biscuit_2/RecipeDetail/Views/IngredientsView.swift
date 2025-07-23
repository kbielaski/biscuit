//
//  IngredientsView.swift
//  biscuit_2
//
//  Created by kelly on 6/24/25.
//

import SwiftUI

struct SectionHeader: View {
    @Binding var title: String
    let groupId: UUID
    let editMode: Bool
    @Binding var isRenaming: Bool
    @FocusState.Binding var focusedTextField: Focusable?
    let deleteIngredientGroup: (_ groupId: UUID) -> Void
    let closeIngredientGroup: (_ groupId: UUID) -> Void
    @Binding var showErrors: Bool

    var body: some View {
        if editMode {
            HStack {
                Button(action: {
                    closeIngredientGroup(groupId)
                }) {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }

                if isRenaming || showErrors {
                    VStack(alignment: .leading) {
                        TextField(
                            "Section name",
                            text: $title,
                            onCommit: {
                                isRenaming = false
                            }
                        ).font(.headline)
                            .foregroundColor(.secondary)
                            .focused(
                                $focusedTextField,
                                equals: Focusable.ingredientSection(
                                    group: groupId
                                )
                            ).overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        showErrors && title.isEmpty
                                            ? Color.red : Color.clear
                                    ).frame(height: 30).padding(.leading, -4)
                            )

                        if showErrors && title.isEmpty {
                            Text("Section title cannot be empty").font(.caption)
                                .foregroundColor(.red)
                        }

                    }
                } else {
                    Menu {
                        Button(
                            title.isEmpty ? "Create name" : "Rename",
                            action: {
                                isRenaming.toggle()
                                focusedTextField = Focusable.ingredientSection(
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
                    } label: {
                        if title.isEmpty {
                            Text("New Section")
                                .foregroundColor(.secondary.opacity(0.5))
                        } else {
                            Text(title)
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
    @Binding var ingredientGroups: ObservableArray<IngredientGroup>
    let editMode: Bool
    @Binding var showErrors: Bool
    @FocusState var focusedTextField: Focusable?

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
                focusedTextField = Focusable.ingredientRow(
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
                                        equals: Focusable.ingredientRow(
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
                            VStack(alignment: .leading){
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
                                if(showErrors && ingredientGroup.items.count == 0) {
                                    Text("Ingredient list cannot be empty").font(.caption).foregroundColor(.red)
                                }
                            }
                        }
                    } header: {
                        SectionHeader(
                            title: $ingredientGroup.heading,
                            groupId: ingredientGroup.id,
                            editMode: editMode,
                            isRenaming: $ingredientGroup.isRenaming,
                            focusedTextField: $focusedTextField,
                            deleteIngredientGroup: deleteIngredientGroup,
                            closeIngredientGroup: closeIngredientGroup,
                            showErrors: $showErrors
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
                                IngredientGroup(heading: "", isRenaming: true)
                            )
                            if let groupId = ingredientGroups.array.last?.id {
                                focusedTextField = Focusable.ingredientSection(
                                    group: groupId
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
            height: UIScreen.main.bounds.height + 300,
                 // calculate this manually
            alignment: .center
        )

    }
}

struct IngredientsView_Previews:
    PreviewProvider
{
    static var previews: some View {
        IngredientsView(
            ingredientGroups: .constant(ObservableArray(array: [
                IngredientGroup(heading: "Fruits", items: ["Apple", "Banana"]),
                IngredientGroup(
                    heading: "Vegetables",
                    items: ["Carrot", "Broccoli"]
                ),
            ])),
            editMode: true,
            showErrors: .constant(true)
        )
    }
}
