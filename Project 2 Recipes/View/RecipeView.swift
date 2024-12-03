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
    @State private var isAddModalVisible: Bool = false
    
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
                        IndividualRecipeView(recipe: recipe)
                            .environment(\.modelContext, modelContext)
                    } label: {
                        Text(recipe.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAddModalVisible.toggle()
                    }) {
                        Label("Add Recipe", systemImage: "plus")
                    }
                }
            }
            .searchable(text: $searchString)
        } detail: {
            Text("Select a recipe")
        }
        .sheet(isPresented: $isAddModalVisible) {
            AddRecipeView(isVisible: $isAddModalVisible)
                .environment(\.modelContext, modelContext)
        }
    }
    
//    private func addItem() {
//        let theCategory = Category(name: "Potatoes")
//        let newItem = Recipe(
//            name: "Recipe Name",
//            ingredients: "These are the ingredients",
//            instructions: "These are the instructions",
//            category: theCategory
//        )
//        modelContext.insert(newItem)
//        //viewModel.fetchRecipes()
//    }

    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(recipes[index])
        }
        //viewModel.fetchRecipes()
    }
}
