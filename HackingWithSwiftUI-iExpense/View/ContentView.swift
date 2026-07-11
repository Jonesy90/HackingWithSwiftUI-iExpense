//
//  ContentView.swift
//  HackingWithSwiftUI-iExpense
//
//  Created by Michael Jones on 14/06/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ExpenseSection(title: "Personal", expenses: viewModel.expenses.personalItems, deleteItems: removePersonalItems)
                ExpenseSection(title: "Business", expenses: viewModel.expenses.businessItems, deleteItems: removeBusinessItems)
            }
            .navigationTitle("iExpense")
            .navigationBarBackButtonHidden()
            .toolbar {
                NavigationLink {
                    AddView(expenses: viewModel.expenses)
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }
    
    private func removePersonalItems(at offsets: IndexSet) {
        viewModel.removeItems(at: offsets, in: viewModel.expenses.personalItems)
    }
    
    private func removeBusinessItems(at offsets: IndexSet) {
        viewModel.removeItems(at: offsets, in: viewModel.expenses.businessItems)
    }
}

#Preview {
    ContentView()
}
