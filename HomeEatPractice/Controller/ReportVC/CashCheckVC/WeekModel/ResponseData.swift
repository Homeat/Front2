//
//  ResponseData.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2/18/24.
//
import UIKit
struct ResponseData: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: UserResponseData
}

struct UserResponseData: Codable {
    let tierStatus: String
    let nickname: String
}
