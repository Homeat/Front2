//
//  RegisterData.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/19/24.
//

import Foundation

struct verifyRequest : Codable{
    let email : String
}

struct verifyResponse : Codable{
    let isSuccess : Bool
    let code : String
    let message : String
    let data : verifyData?
}

struct verifyData : Codable{
    let authCode : String
}

struct extraRequest : Codable{
    let gender : String
    let birth : String
    let income : Int
    let goalPrice : Int
}

struct extraResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: ExtraData
}

struct ExtraData: Codable {
    let memberInfoId: Int
    let createdAt: String
}
