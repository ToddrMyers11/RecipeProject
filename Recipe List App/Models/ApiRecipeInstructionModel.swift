//
//  ApiRecipeInstructions.swift
//  Recipe List App
//
//  Created by Sazza on 7/11/22.
//

import Foundation


// MARK: - WelcomeElement
struct InstructionElement: Codable {
    let name: String?
    let steps: [Step]?
}

// MARK: - Step
struct Step: Codable, Identifiable {
    let id = UUID()
    let number: Int?
    let step: String?
    let ingredients, equipment: [Ent]?
    let length: Length?
}

// MARK: - Ent
struct Ent: Codable {
    let id: Int?
    let name, localizedName, image: String?
    let temperature: Length?
}

// MARK: - Length
struct Length: Codable {
    let number: Int
    let unit: String
}

typealias ApiRecipeInstruction = [InstructionElement]
