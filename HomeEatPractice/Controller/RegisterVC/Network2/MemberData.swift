//
//  MemberData.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/4/24.
//

import Foundation

struct RegisterData : Codable {
    let email : String
    let password : String
    let nickname : String
}

struct RegisterResponse : Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data : registerData?
}

struct registerData : Codable {
    let token : String
    let memberId : Int
    let createdAt : String
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
    let data: Userdata?
}

struct Userdata : Codable{
    let email : String
    let nickname : String
    let profileImgUrl : URL?
    let gender : String
    let birth : String
    let income : Int
}
