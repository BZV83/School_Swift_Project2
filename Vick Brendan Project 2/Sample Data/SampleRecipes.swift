//
//  SampleRecipes.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 12/3/24.
//

import Foundation

let sampleRecipes = [
    Recipe(
        name: "Chicken and Dumplings",
        summaryInfo: """
            *Author*: Brendan Vick
            *Date*: 11/12/24
            *Time Required*: 30 minutes
            *Servings*: 10
            *Difficulty*: Extreme
            *Calories*: 500
            """,
        ingredients: """
            - 2 Potatoes
            - 2 Cups Flour
            - 1/2 Cup Sugar
            - 5 Eggs
            """,
        instructions: """
            1. Make
            2. Eat
            3. Probably enjoy
            """,
        categories: """
            Dinner, American
            """,
        notes: """
            
            """,
        isFavorite: false
    ),
    Recipe(
        name: "Cookies",
        summaryInfo: """
            *Author*: Brendan Vick
            *Date*: 11/12/24
            *Time Required*: 30 minutes
            *Servings*: 10
            *Difficulty*: Easy
            *Calories*: 1000
            """,
        ingredients: """
            - 2 Eggs
            - 1 Cup Flour
            - 1/2 Cup Sugar
            - 1 Cup Chocolate Chips
            """,
        instructions: """
            1. Mix
            2. Bake
            3. Devour
            """,
        categories: """
            Dessert, Snacks
            """,
        notes: """
            
            """,
        isFavorite: true
    )
]
