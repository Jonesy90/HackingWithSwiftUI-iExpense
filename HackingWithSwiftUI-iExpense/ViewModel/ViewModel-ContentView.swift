//
//  ViewModel-ContentView.swift
//  HackingWithSwiftUI-iExpense
//
//  Created by Michael Jones on 11/07/2026.
//

import SwiftData
import SwiftUI
import Foundation

extension ContentView {
    @Observable
    class ViewModel {
        
        var allExpenses = [ExpenseItem]()
        
        func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem], modelContext: ModelContext) {
            for offset in offsets {
                let expense = inputArray[offset]
                modelContext.delete(expense)
            }
        }
    }
}
