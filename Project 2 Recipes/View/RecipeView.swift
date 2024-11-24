//
//  ContentView.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 11/14/24.
//

import SwiftUI
import SwiftData

struct RecipeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var viewModel: RecipeViewModel
    @Query private var recipes: [Recipe]
    
    @State private var searchString: String = ""
    
    var body: some View {
        NavigationSplitView {
            //            List {
            //                Text("Recipes")
            //                Text("No Recipes")
            //            }
            //        } content: {
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
            .searchable(text: $searchString)
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Recipe(name: "New Recipe", ingredients: "These ingredients", instructions: "These are the instructions", categories: "This category")
            modelContext.insert(newItem)
            //viewModel.fetchData()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
            //viewModel.fetchData()
        }
    }
}

#Preview {
    RecipeView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
