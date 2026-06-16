//
//  AddView.swift
//  HackingWithSwiftUI-iExpense
//
//  Created by Michael Jones on 15/06/2026.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    
    var types = ["Business", "Personal"]
    
    /// Gets the current locale settings of the user based on their device settings (region, language etc). Ensures the preferred regional currency is used when showing prices.
    let preferredCurrency = Locale.current.currency?.identifier ?? "GBP"
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: preferredCurrency))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let newExpenseItem = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(newExpenseItem)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
