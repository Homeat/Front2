//
//  FoodTalkComment.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/02/17.
//


import Foundation
struct FoodTalkComment: Codable {
    let createdAt: String
    let updatedAt: String
    let id: Int
    let content: String
    let replyList: [Reply]
}
