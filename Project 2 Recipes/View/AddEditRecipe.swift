//
//  AddEditRecipe.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 12/2/24.
//

import Foundation
import SwiftUI

struct AddEditRecipe: View {
    @Environment(RecipeViewModel.self) var viewModel
    @Environment(\.presentationMode) var presentationMode
    
    let editRecipe: Recipe?

    @State private var recipe: Recipe = Recipe(
        name: "",
        summaryInfo: "",
        ingredients: "",
        instructions: "",
        categories: "",
        notes: "",
        isFavorite: false
    )
    
    // Summary info fields
    @State private var author = ""
    @State private var date = ""
    @State private var timeRequired = ""
    @State private var servings = ""
    @State private var difficulty = ""
    @State private var calories = ""
    
    init(editRecipe: Recipe?) {
        self.editRecipe = editRecipe
        
        if let recipeToEdit = editRecipe {
            recipe.name = recipeToEdit.name
            recipe.summaryInfo = recipeToEdit.summaryInfo
            recipe.ingredients = recipeToEdit.ingredients
            recipe.instructions = recipeToEdit.instructions
            recipe.categories = recipeToEdit.categories
            recipe.notes = recipeToEdit.notes
            recipe.isFavorite = recipeToEdit.isFavorite
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Recipe Name", text: $recipe.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                
                Section(header: Text("Recipe Summary")) {
                    TextField("Author", text: $author)
                    TextField("Date", text: $date)
                    TextField("Time Required", text: $timeRequired)
                    TextField("Servings", text: $servings)
                    TextField("Difficulty", text: $difficulty)
                    TextField("Calories", text: $calories)
                }
                
                Section(header: Text("Recipe Ingredients (Separated by a new line)")) {
                    TextEditor(text: $recipe.ingredients)
                        .frame(height: 100)
                }
                
                Section(header: Text("Recipe Instructions (plain text)")) {
                    TextEditor(text: $recipe.instructions)
                        .frame(height: 200)
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $recipe.notes)
                }
                
                Section(header: Text("Category")) {
                    TextField("Categories (comma separated)", text: $recipe.categories)
                }
                
                Section {
                    Toggle("Favorite this item?", isOn: $recipe.isFavorite)
                }
                
                Section {
                    Button("Save") {
                        saveRecipe()
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit Recipe" : "Add New Recipe")
            .onAppear {
                if let recipeToEdit = editRecipe {
                    parseSummaryInfo(recipeToEdit.summaryInfo)
                }
            }
        }
    }
    
    private var isEditing: Bool {
        editRecipe != nil
    }
    
    private func saveRecipe() {
        recipe.summaryInfo = formatSummaryInfo()
        
        if isEditing {
            if let recipeToEdit = editRecipe {
                recipeToEdit.name = recipe.name
                recipeToEdit.summaryInfo = recipe.summaryInfo
                recipeToEdit.ingredients = recipe.ingredients
                recipeToEdit.instructions = recipe.instructions
                recipeToEdit.categories = recipe.categories
                recipeToEdit.notes = recipe.notes
                recipeToEdit.isFavorite = recipe.isFavorite
            }
            viewModel.update(recipe)
        } else {
            viewModel.save(recipe)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
    
    private func formatSummaryInfo() -> String {
        return """
        *Author*: \(author)
        *Date*: \(date)
        *Time Required*: \(timeRequired)
        *Servings*: \(servings)
        *Difficulty*: \(difficulty)
        *Calories*: \(calories)
        """
    }
    
    // Chat help generated
    private func parseSummaryInfo(_ summary: String) {
        let lines = summary.split(separator: "\n")
        for line in lines {
            if line.contains("*Author*") {
                author = line.replacingOccurrences(of: "*Author*: ", with: "")
            } else if line.contains("*Date*") {
                date = line.replacingOccurrences(of: "*Date*: ", with: "")
            } else if line.contains("*Time Required*") {
                timeRequired = line.replacingOccurrences(of: "*Time Required*: ", with: "")
            } else if line.contains("*Servings*") {
                servings = line.replacingOccurrences(of: "*Servings*: ", with: "")
            } else if line.contains("*Difficulty*") {
                difficulty = line.replacingOccurrences(of: "*Difficulty*: ", with: "")
            } else if line.contains("*Calories*") {
                calories = line.replacingOccurrences(of: "*Calories*: ", with: "")
            }
        }
    }
}
