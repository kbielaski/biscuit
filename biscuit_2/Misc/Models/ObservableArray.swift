import Combine
import Foundation
import Observation
//
//  ObservableArray.swift
//  biscuit_2
//
//  Created by kelly on 7/19/25.
//
import SwiftUI

@Observable class ObservableArray<T>: MutableCollection {

    var array: [T] = []
    var cancellables: [AnyCancellable] = []

    // Required by Collection
    var startIndex: Int { array.startIndex }
    var endIndex: Int { array.endIndex }

    init(array: [T]) {
        self.array = array
    }

    // Required by Collection
    func index(after i: Int) -> Int { array.index(after: i) }

    // Required by MutableCollection: read-write subscript
    subscript(position: Int) -> T {
        get { array[position] }
        set { array[position] = newValue }
    }

    //    func observeChildrenChanges<T: ObservableObject>() -> ObservableArray<T> {
    //        let array2 = array as! [T]
    //        array2.forEach({
    //            let c = $0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() })
    //
    //            // Important: You have to keep the returned value allocated,
    //            // otherwise the sink subscription gets cancelled
    //            self.cancellables.append(c)
    //        })
    //        return self as! ObservableArray<T>
    //    }
}
