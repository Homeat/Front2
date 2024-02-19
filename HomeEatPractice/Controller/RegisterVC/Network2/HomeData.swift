//
//  HomeData.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/18/24.
//

import Foundation

struct ExpenseData : Codable {
    let money : Int
    let type : String
    let memo : String
}

struct ExpenseResponse : Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: String
}
struct ExpenseImageResponse : Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: Int
}

struct HomeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: HomeItem?
}

struct HomeItem: Codable {
    let nickname: String
    let targetMoney: Int
    let beforeSavingPercent: Int
    let remainingMoney: Int
    let badgeCount: Int
    let remainingPercent: Int
    let beforeWeek : Int
    let message : String
}

