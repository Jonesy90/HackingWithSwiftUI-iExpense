//
//  ExpenseItem.swift
//  HackingWithSwiftUI-iExpense
//
//  Created by Michael Jones on 11/07/2026.
//

import SwiftData
import Foundation

@Model
class ExpenseItem {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
