//
//  DurationPickerButtonView.swift
//  biscuit_2
//
//  Created by kelly on 7/13/25.
//

import SwiftUI

struct DurationPickerButtonView: View {
    @State private var editableTime: TimeInterval?
    let buttonText: String
    @Binding var isShowingDurationPicker: Bool
    @Binding var duration: TimeInterval?

    var body: some View {
        VStack{
            DurationPickerView(
                duration: Binding(
                    get: { duration ?? 0 },
                    set: { duration = $0 }
                )
            )
            .presentationDetents([.fraction(0.4)])
            .presentationDragIndicator(.visible)
            Button(buttonText) {
                isShowingDurationPicker.toggle()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(
                color: .gray.opacity(0.4),
                radius: 4,
                x: 0,
                y: 2
            )
            .frame(maxWidth: .infinity)
        }

    }

}

struct DurationPickerButtonView_Previews:
    PreviewProvider
{
    static var previews: some View {
        DurationPickerButtonView(
            buttonText: "Select prep time",
            isShowingDurationPicker: .constant(true),
            duration: .constant(60)
        )
    }
}
