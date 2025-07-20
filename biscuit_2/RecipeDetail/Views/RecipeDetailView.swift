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
    @State private var editableRating = sampleRecipes[0].rating
    @State private var editableIngredients: ObservableArray<IngredientGroup> = sampleRecipes[0]
        .ingredients
    @State private var isTitleEditable: Bool = false
    @State private var isDescriptionEditable: Bool = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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

                    if editMode && isTitleEditable {
                        // Put limit on the number of characters
                        TextField("Recipe Name", text: $editableName)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .padding(.top, 5)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(editableName)
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5)
                            .padding(.horizontal, 5).onTapGesture {
                                isTitleEditable.toggle()
                            }
                    }

                    ZStack {
                        VStack {
                            RecipeStatsView(
                                recipe: recipe,
                                editMode: editMode
                            )

                            HStack {
                                ForEach(0..<5) { index in
                                    Image(
                                        systemName: index
                                            < Int(editableRating)
                                            ? "star.fill" : "star"
                                    )
                                    .foregroundColor(
                                        index < Int(editableRating)
                                            ? .yellow : .gray
                                    )
                                    .onTapGesture {
                                        if editMode {
                                            editableRating = Double(
                                                index + 1
                                            )
                                        }
                                    }
                                }
                            }.padding(.top, 2)
                        }
                        if editMode && (isTitleEditable || isDescriptionEditable) {
                            Color.clear.frame(maxHeight: 50)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    isTitleEditable = false
                                    isDescriptionEditable = false
                                }
                        }
                    }

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
                            )
                    } else {
                        Text(editableDescription)
                            .font(.body)
                            .padding(.horizontal, 5).padding(.top, 2)
                            .foregroundColor(.secondary).onTapGesture {
                                isDescriptionEditable.toggle()
                            }
                    }

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
                                            editableIngredients,
                                        editMode: editMode
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
            .padding(.bottom, 5)
            
            Button(action: {
                editMode.toggle()
                isTitleEditable = false
                isDescriptionEditable = false
            }) {
                Image(systemName: editMode ? "checkmark" : "pencil")
                    .font(.system(size: 24))
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: UIScreen.main.bounds.height,
                alignment: .bottomTrailing
            )
            .padding()
            // show saved success message when check is clicked
        }

    }
}

struct RecipeDetailView_Previews:
    PreviewProvider
{
    static var previews: some View {
        RecipeDetailView(recipe: sampleRecipes[0])
    }
}
