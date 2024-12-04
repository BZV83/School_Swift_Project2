//
//  AddRecipeView.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 12/2/24.
//

import Foundation
import SwiftUI

struct AddRecipeView: View {
    @Environment(RecipeViewModel.self) var viewModel
    
    @Binding var isVisible: Bool
    
    @State private var recipeName: String = ""
    @State private var recipeDescription: String = ""
    @State private var ingredients: String = ""
    @State private var instructions: String = ""
    @State private var category: String = ""
    @State private var notes: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Recipe Name", text: $recipeName)
                    TextField("Short Summary", text: $recipeDescription, axis: .vertical)
                }
                
                Section(header: Text("Recipe Ingredients (Entered in bullet points)")) {
                    TextEditor(text: $ingredients)
                }
                
                Section(header: Text("Recipe Instructions (Bullet points, numbered, or just plain text)")) {
                    TextEditor(text: $instructions)
                }
                
                Section(header: Text("Category")) {
//                            Picker("Select Category", selection: $selectedCategory) {
//                                ForEach(categories, id: \.self) { category in
//                                    Text(category)
//                                }
//                            }
//                            .pickerStyle(MenuPickerStyle())
                }
                
                Section {
                    Button("Save") {
                        //saveRecipe()
                    }
                }
            }
            .navigationTitle("Add New Recipe")
            .navigationBarItems(trailing: Button("Cancel") {
                isVisible = false
            })
        }
    }
        
    //TODO: - Function into view model
    
//    private func saveRecipe() {
//        guard !recipeName.isEmpty, !recipeDescription.isEmpty, !ingredients.isEmpty, !instructions.isEmpty else {
//            return
//        }
//        
//        let newRecipe = Recipe(
//            name: recipeName,
//            summaryInfo: recipeDescription,
//            ingredients: ingredients,
//            instructions: instructions,
//            categories: category,
//            notes: notes,
//            isFavorite: false
//        )
//
//        viewModel.modelContext.insert(newRecipe)
//        isVisible = false
//    }
}
