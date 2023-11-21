//
//  DataModel.swift
//  XetaAssignment
//
//  Created by Sumayya Siddiqui on 21/11/23.
//

import Foundation

// MARK: - Homepage
struct Homepage: Codable {
    let success: Bool
    let data: DataClass
    let message: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let section1: Section1
    let section2: Section2
    let section3: Section3
    let section4: Section4

    enum CodingKeys: String, CodingKey {
        case section1 = "section_1"
        case section2 = "section_2"
        case section3 = "section_3"
        case section4 = "section_4"
    }
}

// MARK: - Section1
struct Section1: Codable {
    let planName, progress: String

    enum CodingKeys: String, CodingKey {
        case planName = "plan_name"
        case progress
    }
}

// MARK: - Section2
struct Section2: Codable {
    let accuracy, workoutDuration: String
    let reps, caloriesBurned: Int

    enum CodingKeys: String, CodingKey {
        case accuracy
        case workoutDuration = "workout_duration"
        case reps
        case caloriesBurned = "calories_burned"
    }
}

// MARK: - Section3
struct Section3: Codable {
    let plan1, plan2: Plan

    enum CodingKeys: String, CodingKey {
        case plan1 = "plan_1"
        case plan2 = "plan_2"
    }
}

// MARK: - Plan
struct Plan: Codable {
    let planName, difficulty: String

    enum CodingKeys: String, CodingKey {
        case planName = "plan_name"
        case difficulty
    }
}

// MARK: - Section4
struct Section4: Codable {
    let category1, category2: Category

    enum CodingKeys: String, CodingKey {
        case category1 = "category_1"
        case category2 = "category_2"
    }
}

// MARK: - Category
struct Category: Codable {
    let categoryName, noOfExercises: String

    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case noOfExercises = "no_of_exercises"
    }
}
