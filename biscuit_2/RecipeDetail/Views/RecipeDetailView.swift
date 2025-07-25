import DurationPicker
//
//  RecipeDetailView.swift
//  biscuit_2
//
//  Created by kelly on 6/24/25.
//
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var selectedTab = 0
    @State private var editMode = false
    @State private var editableName = sampleRecipes[0].name
    @State private var editableDescription = sampleRecipes[0].description
    @State private var editableIngredients: ObservableArray<IngredientGroup> =
        sampleRecipes[0]
        .ingredients
    @State private var isTitleEditable: Bool = false
    @State private var isDescriptionEditable: Bool = false
    @State private var isBookmarked: Bool = sampleRecipes[0].isBookmarked
    @State var showErrors: Bool = false
    @FocusState var focusedTextField: Focusable?

    func validateForm() -> Bool {
        var isValid = true
        if editableName.isEmpty {
            isValid = false
        } else if validateIngredients() == false {
            isValid = false
        }

        return isValid
    }

    func validateIngredients() -> Bool {
        return sampleRecipes[0].ingredients.array.firstIndex(where: {
            $0.isValid() == false
        }) == nil
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack {
                        ImageCarouselView(
                            images: recipe.images,
                            editMode: editMode
                        )

                        // Move all these statements to either a function or be nested in the component
                        if isTitleEditable || isDescriptionEditable {
                            Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    isTitleEditable = false
                                    isDescriptionEditable = false
                                }.frame(maxHeight: 200)
                        }
                    }

                    // Title section
                    if editMode && (isTitleEditable || editableName.isEmpty) {
                        VStack(alignment: .leading) {
                            TextField("Recipe Name", text: $editableName)
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .padding(.top, 5)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            showErrors && editableName.isEmpty
                                                ? Color.red : Color.clear
                                        ).frame(height: 40).padding(
                                            .horizontal,
                                            12
                                        )
                                ).onChange(of: editableName) {
                                    isTitleEditable = true
                                    showErrors = false
                                }.focused(
                                    $focusedTextField,
                                    equals: Focusable.title
                                ).onSubmit {
                                    focusedTextField = Focusable.none
                                    isTitleEditable = false
                                }

                            if showErrors && editableName.isEmpty {
                                Text("Recipe name cannot be empty").font(
                                    .caption
                                )
                                .foregroundColor(.red).padding(.leading, 8)
                            }
                        }
                    } else if editMode {
                        Text(editableName)
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5)
                            .padding(.horizontal, 5).onTapGesture {
                                isDescriptionEditable = false
                                isTitleEditable.toggle()
                                focusedTextField = Focusable.title
                            }
                    } else {
                        Text(editableName)
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5)
                            .padding(.horizontal, 5)
                    }

                    // Recipe stats section
                    ZStack {
                        VStack {
                            RecipeStatsView(
                                recipe: recipe,
                                editMode: editMode
                            )
                        }
                        if editMode
                            && (isTitleEditable || isDescriptionEditable)
                        {
                            Color.clear.frame(maxHeight: 50)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    isTitleEditable = false
                                    isDescriptionEditable = false
                                }
                        }
                    }

                    // Description section
                    if editMode && isDescriptionEditable {
                        TextEditor(text: $editableDescription)
                            .font(.body)
                            .padding(.horizontal, 5)
                            .padding(.top, 2)
                            .foregroundColor(.secondary)
                            .frame(minHeight: 80, maxHeight: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        Color.secondary.opacity(0.2),
                                        lineWidth: 1
                                    )
                            ).focused(
                                $focusedTextField,
                                equals: Focusable.description
                            ).onSubmit {
                                focusedTextField = Focusable.none
                                isDescriptionEditable = false
                            }
                    } else if editMode {
                        Text(editableDescription)
                            .font(.body)
                            .padding(.horizontal, 5).padding(.top, 2)
                            .foregroundColor(.secondary).onTapGesture {
                                isDescriptionEditable.toggle()
                                isTitleEditable = false
                                focusedTextField = Focusable.description
                            }
                    } else {
                        Text(editableDescription)
                            .font(.body)
                            .padding(.horizontal, 5).padding(.top, 2)
                            .foregroundColor(.secondary)
                    }

                    // Ingredients & Directions section
                    ZStack {
                        VStack {
                            Picker("Details", selection: $selectedTab) {
                                Text("Ingredients").tag(0)
                                Text("Directions").tag(1)
                                //                                Text("Notes").tag(2)
                            }
                            .pickerStyle(.segmented)
                            .padding(.top, 8)

                            Group {
                                if selectedTab == 0 {
                                    IngredientsView(
                                        ingredientGroups:
                                            $editableIngredients,
                                        editMode: editMode,
                                        showErrors: $showErrors
                                    )
                                } else if selectedTab == 1 {
                                    DirectionsView(recipe: recipe)
                                } else {
                                    NotesView(recipe: recipe)
                                }
                            }
                        }

                        if isTitleEditable || isDescriptionEditable {
                            Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    isTitleEditable = false
                                    isDescriptionEditable = false
                                }
                        }
                    }
                }
            }
            .toolbar {
                // Top toolbar
                ToolbarItemGroup(placement: .topBarTrailing) {
                    HStack(spacing: 4) {
                        Button(action: { isBookmarked.toggle() }) {
                            Image(
                                systemName: isBookmarked
                                    ? "bookmark.fill" : "bookmark"
                            )
                            .foregroundColor(.gray)
                        }
                        Button(action: { print("Share") }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.gray)
                        }
                        Button(action: {
                            if editMode {
                                if validateForm() {
                                    showErrors = false
                                    editMode.toggle()
                                } else {
                                    showErrors = true
                                }
                            } else {
                                editMode.toggle()
                            }

                        }) {
                            Image(systemName: editMode ? "checkmark" : "pencil")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        // show saved success message when check is clicked
    }

}

struct RecipeDetailView_Previews:
    PreviewProvider
{
    static var previews: some View {
        RecipeDetailView(recipe: sampleRecipes[0])
    }
}
