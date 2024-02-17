//
//  FoodRecipe.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/02/17.
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
