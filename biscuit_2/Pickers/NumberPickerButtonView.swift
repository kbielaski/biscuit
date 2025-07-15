//
//  NumberPickerButtonView.swift
//  biscuit_2
//
//  Created by kelly on 7/13/25.
//

import SwiftUI

struct NumberPickerButtonView: View {
    @State private var editableTime: TimeInterval?
    let buttonText: String
    @Binding var isShowingNumberPicker: Bool
    @Binding var value: Int?
    let range: Array<Int>

    init(
        buttonText: String,
        isShowingNumberPicker: Binding<Bool>,
        value: Binding<Int?>,
        range: Array<Int> = Array(1...30)
    ) {
        self.buttonText = buttonText
        self._isShowingNumberPicker = isShowingNumberPicker
        self._value = value
        self.range = range
    }

    var body: some View {
        VStack {
            Picker(selection: $value, label: Text("hello world")) {
                ForEach(range, id: \.self) { num in
                    Text("\(num)").tag(num)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .presentationDetents([.fraction(0.4)])
            .presentationDragIndicator(.visible)
            Button(buttonText) {
                isShowingNumberPicker.toggle()
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
            // add a button to close picker
        }

    }

}

struct NumberPickerButtonView_Previews:
    PreviewProvider
{
    static var previews: some View {
        NumberPickerButtonView(
            buttonText: "Select calorie count",
            isShowingNumberPicker: .constant(true),
            value: .constant(4)
        )
    }
}
