//
//  InfoReply.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/02/20.
//

import Foundation
struct InfoReply: Codable {
    let createdAt: String
    let updatedAt: String
    let id: Int
    let content: String // 댓글 내용
}
