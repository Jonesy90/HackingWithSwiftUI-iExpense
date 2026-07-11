//
//  ExpenseItem.swift
//  HackingWithSwiftUI-iExpense
//
//  Created by Michael Jones on 11/07/2026.
//

import Foundation

/// This stores all the information needed for a single Expense. With built-in support for unique identification and saving/loading.
struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
