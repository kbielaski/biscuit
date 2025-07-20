//
//  ObservableArray.swift
//  biscuit_2
//
//  Created by kelly on 7/19/25.
//
import SwiftUI
import Foundation
import Combine

class ObservableArray<T>: ObservableObject {

    @Published var array:[T] = []
    var cancellables: [AnyCancellable] = []

    init(array: [T]) {
        self.array = array

    }

    func observeChildrenChanges<T: ObservableObject>() -> ObservableArray<T> {
        let array2 = array as! [T]
        array2.forEach({
            let c = $0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() })

            // Important: You have to keep the returned value allocated,
            // otherwise the sink subscription gets cancelled
            self.cancellables.append(c)
        })
        return self as! ObservableArray<T>
    }


}
