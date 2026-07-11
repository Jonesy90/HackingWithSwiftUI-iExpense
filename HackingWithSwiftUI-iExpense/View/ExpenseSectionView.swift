//
//  ExpenseSectionView.swift
//  HackingWithSwiftUI-iExpense
//
//  Created by Michael Jones on 11/07/2026.
//

import SwiftUI

struct ExpenseSection: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    /// Gets the current locale settings of the user based on their device settings (region, language etc). Ensures the preferred regional currency is used when showing prices.
    let preferredCurrency = Locale.current.currency?.identifier ?? "GBP"
    
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                        
                        Spacer()
                        
                        HStack {
                            Text(item.amount, format: .currency(code: preferredCurrency))
                                .foregroundStyle(item.amount <= 10.00 ? Color.green : item.amount > 10.00 && item.amount <= 100.00 ? Color.orange : Color.red)
                                .style(for: item)
                        }
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}
