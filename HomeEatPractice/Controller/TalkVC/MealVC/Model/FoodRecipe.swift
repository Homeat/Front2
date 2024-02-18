//
//  FoodRecipe.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2/17/24.
//

import Foundation
struct FoodRecipe: Codable {
    let createdAt: String
    let updatedAt: String
    let id: Int
    let recipe: String
    let ingredient: String
    let tip: String
    let foodRecipePictures: [FoodRecipePicture]
}
