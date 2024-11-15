//
//  ContentView.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 11/14/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recipes: [Recipe]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink {
                        Text(recipe.name)
                        Text(recipe.instructions)
                    } label: {
                        Text(recipe.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Recipe", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Recipe(name: "New Recipe", ingredients: "These ingredients", instructions: "These are the instructions", categories: "This category")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
