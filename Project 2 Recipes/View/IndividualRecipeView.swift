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
    @EnvironmentObject var viewModel: RecipeViewModel
    let recipe: Recipe
    
    public var body: some View {
        Markdown(
            """
            # \(recipe.name)
            ### \(recipe.summary)
            """
        )
        
        
        
        Text(recipe.instructions)
        Text(recipe.category?.name ?? "No category")
    }
}
