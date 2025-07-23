//
//  Focusable.swift
//  biscuit_2
//
//  Created by kelly on 7/23/25.
//
import SwiftUI

enum Focusable: CustomStringConvertible, Hashable {
    case none
    case title
    case description
    case ingredientSection(group: UUID)
    case ingredientRow(group: UUID, item: UUID)

    var description: String {
        switch self {
        case .title: return "title"
        case .description: return "description"
        case .ingredientRow(let group, let item):
            return "Row \(group.description), Item \(item.description)"
        case .ingredientSection(let group): return "Group \(group.description)"
        default: return "None"
        }
    }
}
