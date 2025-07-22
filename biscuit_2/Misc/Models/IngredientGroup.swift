//
//  IngredientGroup.swift
//  biscuit_2
//
//  Created by kelly on 6/24/25.
//

import SwiftUI
import Observation

struct Ingredient: Identifiable, Equatable, Hashable {
    var name: String
    let id = UUID()
}

@Observable class IngredientGroup: Identifiable {
    var heading: String
    var items: [Ingredient]
    var id = UUID()
    var isExpanded: Bool = true
    var isRenaming: Bool = false
    
    func isValid() -> Bool {
        return heading.isEmpty ? false : items.count > 0
    }
    
    init(heading: String) {
        self.heading = heading
        self.items = []
    }
    
    init(heading: String, isRenaming: Bool) {
        self.heading = heading
        self.isRenaming = isRenaming
        self.items = []
    }

    init(heading: String, items: [String]) {
        self.heading = heading
        self.items = items.map({ Ingredient(name: $0) })
    }
    
    init(heading: String, items: [Ingredient]) {
        self.heading = heading
        self.items = items
    }
}



