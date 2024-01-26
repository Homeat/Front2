//
//  MealSource.swift
//  HomeEatPractice
//
//  Created by 이지우 on 2024/01/20.
//

import UIKit

struct MealSource {
    let mealLabel: String
    let mealImage: UIImage?
    
    init(mealLabel: String, mealImage: UIImage?) {
        self.mealLabel = mealLabel
        self.mealImage = mealImage
    }
}
