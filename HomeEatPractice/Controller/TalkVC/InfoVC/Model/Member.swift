//
//  Member.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/02/18.
//

struct Member: Codable {
    let createdAt: String
    let updatedAt: String
    let id: Int
    let email: String
    let password: String
    let nickname: String
    let profileImgUrl: String? // 옵셔널로 변경
    let loginType: String
    let status: String

    // 초기화
    init(createdAt: String,updatedAt: String,id: Int, email: String, password: String, nickname: String, profileImgUrl: String?, loginType: String, status: String) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.id = id
        self.email = email
        self.password = password
        self.nickname = nickname
        self.profileImgUrl = profileImgUrl
        self.loginType = loginType
        self.status = status
    }
}
