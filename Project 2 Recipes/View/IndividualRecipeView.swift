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
    
    public var body: some View {
        VStack {
            HStack {
                Text(recipe.name)
                    .font(.title)
                Spacer()
                Button(action: {
                    recipe.isFavorite.toggle()
                    print(recipe.summaryInfo)
                }) {
                    Label("Is Favorite", systemImage: recipe.isFavorite ? "heart.fill" : "heart")
                }
            }
            Markdown(recipe.summaryInfo)
            
            Markdown(recipe.ingredients)
            Markdown(recipe.instructions)
            
            Markdown(recipe.categories)
            
//            Toggle("Is Favorite", isOn: $recipe.isFavorite)
        }
        .padding()
    }
}
