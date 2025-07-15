//
//  DurationPickerView.swift
//  biscuit_2
//
//  Created by kelly on 7/12/25.
//

import DurationPicker
import SwiftUI

struct DurationPickerView: UIViewRepresentable {
    @Binding var duration: TimeInterval

    func makeUIView(context: Context) -> DurationPicker {
        let picker = DurationPicker()
        picker.pickerMode = .hourMinute
        picker.hourInterval = 1
        picker.minuteInterval = 5
        picker.minimumDuration = 1 * 60  // 1 minute
        picker.maximumDuration = 12 * 3600  // 12 hours
        picker.duration = duration
        picker.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return picker
    }

    func updateUIView(_ uiView: DurationPicker, context: Context) {
        uiView.duration = duration
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: DurationPickerView

        init(_ parent: DurationPickerView) {
            self.parent = parent
        }

        @objc func valueChanged(_ sender: DurationPicker) {
            parent.duration = sender.duration
        }
    }
}
