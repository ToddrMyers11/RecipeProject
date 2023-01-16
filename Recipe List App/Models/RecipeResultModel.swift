//
//  RecipeResultModel.swift
//  Recipe List App
//
//  Created by Sazza on 28/10/22.
//

import Foundation

// MARK: - RecipeResultModel
struct RecipeResultModel: Codable {
    let results: [Result]
    let offset, number, totalResults: Int
}

// MARK: - Result
struct Result: Codable,Identifiable {
    let id: Int
    let title: String
    let image: String
    let imageType: ImageType
}

enum ImageType: String, Codable {
    case jpeg = "jpeg"
    case jpg = "jpg"
    case png = "png"
}
