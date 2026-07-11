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
        
        //Purpose: Designed to remove one or more items from the 'expenses.item' array at the specified positions.
        //How it works?: The parameter represents a set of indexes that should be removes. With the convenience method (provided in Swift for arrays), it will remove all elements in the array at the indexes specified.
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
