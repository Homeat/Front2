//
//  FoodItemData.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/28.
//
import Foundation

struct FoodItemData: Codable {
    let name: String
    let memo: String
    let tag: String
    let imgUrl: [String]?
}
