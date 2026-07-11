//
//  ViewModel-ContentView.swift
//  HackingWithSwiftUI-iExpense
//
//  Created by Michael Jones on 11/07/2026.
//

import SwiftUI
import Foundation

extension ContentView {
    @Observable
    class ViewModel {
        var expenses = Expenses()
        
        func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
            var objectsToDelete = IndexSet()
            
            for offset in offsets {
                let item = inputArray[offset]
                
                if let index = expenses.items.firstIndex(of: item) {
                    objectsToDelete.insert(index)
                }
            }
            
            expenses.items.remove(atOffsets: offsets)
        }
    }
}
