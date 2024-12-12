//
//  IndividualRecipeView.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 12/2/24.
//

import Foundation
import SwiftUI
import MarkdownUI

public struct IndividualRecipeView: View {
    @Environment(RecipeViewModel.self) var viewModel
    @Bindable var recipe: Recipe
    
    @State private var isEditing: Bool = false
    
    public var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack {
                        Rectangle().fill(Color.blue).opacity(0.5)
                        // Summary
                        if !recipe.summaryInfo.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Summary")
                                    .font(.headline)
                                    .padding(.top, 8)
                                ForEach(separateListItems(recipe.summaryInfo), id: \.self) { metaInfo in
                                    Markdown(metaInfo)
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding()
                        }
                    }
                    .padding()
                    ZStack {
                        Rectangle().fill(Color.orange).opacity(0.5)
                        // Ingredients
                        if !recipe.ingredients.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Ingredients")
                                    .font(.headline)
                                    .padding(.top, 8)
                                ForEach(separateListItems(recipe.ingredients), id: \.self) { ingredient in
                                    Markdown("- \(ingredient)")
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding()
                        }
                    }
                    .padding()
                    
                    // Instructions
                    if !recipe.instructions.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Instructions")
                                .font(.headline)
                            Markdown(recipe.instructions)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Notes
                    if !recipe.notes.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notes")
                                .font(.headline)
                            Markdown(recipe.notes)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Categories
                    if !recipe.categories.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Categories")
                                .font(.headline)
                            ForEach(separateListItems(recipe.categories), id: \.self) { category in
                                Markdown("- \(category)")
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle(recipe.name)
            .onChange(of: recipe.isFavorite) { viewModel.refreshData() }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        withAnimation {
                            viewModel.markFavorite(recipe)
                        }
                    }, label: {
                        Image(systemName: recipe.isFavorite ? "star.fill" : "star")
                            .foregroundStyle(.yellow)
                    })
                }
                ToolbarItem {
                    Button(action: editItem) {
                        Label("Edit", systemImage: "pencil")
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                AddEditRecipe(editRecipe: recipe)
            }
        }
    
    private func editItem() {
        isEditing.toggle()
    }
    
    private func separateListItems(_ list: String) -> [String] {
        let separators = CharacterSet(charactersIn: ",-\n")
        
        return list
            .components(separatedBy: separators)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}
