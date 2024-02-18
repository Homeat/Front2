//
//  FoodTalkComment.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2/17/24.
//

import Foundation
struct FoodTalkComment: Codable {
    let createdAt: String
    let updatedAt: String
    let id: Int
    let content: String
    let replyList: [Reply]
}
