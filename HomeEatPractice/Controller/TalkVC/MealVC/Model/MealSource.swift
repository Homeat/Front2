//
//  MealSource.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/20.
//

import Foundation

struct MealSource: Codable {
        let createdAt: String?
        let updatedAt: String?
        let id: Int
        let name: String?
        let memo: String?
        let tag: String?
        let love: Int?
        let view: Int?
        let commentNumber: Int?
        let setLove: Bool?
        let save: String?
        let foodPictures: [FoodPicture]
        let foodRecipes: [FoodRecipe]
        let foodTalkComments: [FoodTalkComment]

    // 초기화
    init(createdAt: String, updatedAt: String, id: Int, name: String, memo: String, tag: String, love: Int, view: Int, commentNumber: Int, setLove: Bool, save: String, foodPictures: [FoodPicture], foodRecipes: [FoodRecipe], foodTalkComments: [FoodTalkComment]) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.id = id
        self.name = name
        self.memo = memo
        self.tag = tag
        self.love = love
        self.view = view
        self.commentNumber = commentNumber
        self.setLove = setLove
        self.save = save
        self.foodPictures = foodPictures
        self.foodRecipes = foodRecipes
        self.foodTalkComments = foodTalkComments
    }
}
