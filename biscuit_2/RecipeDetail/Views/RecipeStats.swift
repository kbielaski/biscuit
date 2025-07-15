//
//  RecipeStats.swift
//  biscuit_2
//
//  Created by kelly on 7/13/25.
//

import SwiftUI

struct RecipeStatsView: View {
    let recipe: Recipe
    let editMode: Bool

    @State private var isShowingPrepTimePicker = false
    @State private var isShowingCookTimePicker = false
    @State private var isShowingServingSizePicker = false
    @State private var isShowingCalorieCountPicker = false

    @State private var editablePrepTime: TimeInterval? = {
        let prepTime = sampleRecipes[0].prepTime
        if prepTime != nil {
            let prepTimeDouble = Double(prepTime!)
            if prepTimeDouble > 0 {
                return prepTimeDouble * 60
            }
        }
        return nil
    }()

    @State private var editableCookTime: TimeInterval? = {
        let cookTime = sampleRecipes[0].cookTime
        if cookTime != nil {
            let cookTimeDouble = Double(cookTime!)
            if cookTimeDouble > 0 {
                return cookTimeDouble * 60
            }
        }
        return nil
    }()

    @State private var editableServingSizeValue: Int? = sampleRecipes[0]
        .servingSize

    @State private var editableCalorieCountValue: Int? = sampleRecipes[0]
        .calories

    //    @State private var editableCalories: Int? = sampleRecipes[0].calories

    // Converts editablePrepTime (TimeInterval?) to a string in hours and minutes (e.g., "2 hrs 0 min")
    func timeString(time: TimeInterval?) -> String? {
        if time == nil || time! <= 0 {
            return nil
        }
        let hours = Int(time!) / 3600
        let minutes = (Int(time!) % 3600) / 60
        var result = ""
        if hours > 0 {
            result += "\(hours) hr"
            if hours > 1 { result += "s" }
        }
        if minutes > 0 {
            if !result.isEmpty { result += " " }
            result += "\(minutes) min"
        }
        return result
    }

    var body: some View {
        VStack {
            HStack(spacing: 4) {
                let prepTime = timeString(time: editablePrepTime) ?? ""
                let cookTime = timeString(time: editableCookTime) ?? ""
                // Prep time
                if !prepTime.isEmpty {
                    Text(
                        "Prep time: \(prepTime)\(!cookTime.isEmpty ? ", " : "")"
                    )
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        if editMode {
                            isShowingPrepTimePicker.toggle()
                        }
                    }.sheet(isPresented: $isShowingPrepTimePicker) {
                        VStack {
                            DurationPickerButtonView(
                                buttonText: "Select prep time",
                                isShowingDurationPicker:
                                    $isShowingPrepTimePicker,
                                duration: $editablePrepTime
                            )
                        }
                        
                    }.frame(alignment: .bottom)
                }
                // Cook time
                Text("Cook time: \(cookTime)").font(.footnote)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        if editMode {
                            isShowingCookTimePicker.toggle()
                        }
                    }.sheet(isPresented: $isShowingCookTimePicker) {
                        VStack {
                            DurationPickerButtonView(
                                buttonText: "Select cook time",
                                isShowingDurationPicker:
                                    $isShowingCookTimePicker,
                                duration: $editableCookTime
                            )
                        }
                    }.frame( alignment: .bottom)
            }
            
            HStack(spacing: 4) {
                let servingSize = editableServingSizeValue
                let calorieCount = editableCalorieCountValue
                // Serving size
                if servingSize != nil || servingSize! > 0 {
                    Text(
                        "Servings: \(servingSize != nil ? "\(servingSize!)" : "")\(calorieCount != nil && calorieCount! > 0 ? ", " : "")"
                    )
                    .font(.footnote).foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        if editMode {
                            isShowingServingSizePicker.toggle()
                        }
                    }.sheet(isPresented: $isShowingServingSizePicker) {
                        // update value here
                        NumberPickerButtonView(
                            buttonText: "Select serving size",
                            isShowingNumberPicker: $isShowingServingSizePicker,
                            value: $editableServingSizeValue,
                            
                        )
                    }
                }
                // Calories per serving
                if (calorieCount != nil && calorieCount! > 0){
                    Text("\(calorieCount!) Calories").font(.footnote).foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .onTapGesture {
                            if editMode {
                                isShowingCalorieCountPicker.toggle()
                            }
                        }.sheet(isPresented: $isShowingCalorieCountPicker) {
                            // update value here
                            NumberPickerButtonView(
                                buttonText: "Select calorie count",
                                isShowingNumberPicker: $isShowingCalorieCountPicker,
                                value: $editableCalorieCountValue,
                                range: Array(stride(from: 25, through: 2000, by: 25))
                            )
                            
                        }
                }
                
            }
        }

        // if it isn't empty show edit mode or shadow
    }

}

struct RecipeStatsView_Previews:
    PreviewProvider
{
    static var previews: some View {
        RecipeStatsView(recipe: sampleRecipes[0], editMode: true)

    }
}
