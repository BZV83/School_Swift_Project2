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
        Markdown(
            """
            # \(recipe.name)
            ### \(recipe.summaryInfo)
            """
        )
        
        Text(recipe.ingredients)
        Text(recipe.instructions)
        Text(recipe.categories)
        Toggle("Is Favorite", isOn: $recipe.isFavorite)
    }
}
