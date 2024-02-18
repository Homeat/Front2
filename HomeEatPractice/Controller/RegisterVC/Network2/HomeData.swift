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

struct HomeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: HomeItem?
}

struct HomeItem: Codable {
    let nickname: String
    let targetMoney: Int
    let lastWeekSavingPercent: Int
    let usedMoney: Int
    let badgeCount: Int
    let usedPercent: Int
}
