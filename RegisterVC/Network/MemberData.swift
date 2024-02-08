//
//  MemberData.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/4/24.
//

import Foundation

struct MemberData : Codable {
    let email : String
    let password : String
    let nickname : String
}

struct LoginData : Codable {
    let email : String
    let password : String
}

struct LoginResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: TokenData?
}

struct TokenData: Codable {
    let token: String
    let expiredAt: String
}

struct MypageResponse : Codable{
    let isSuccess: Bool
    let code: String
    let message: String
    let data: UserData?
}

struct UserData : Codable{
    let email : String
    let nickname : String
    enum CodingKeys: String, CodingKey {
            case email
            case nickname
        }
}
