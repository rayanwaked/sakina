//
//  ScanModel.swift
//  Sakina
//
//  Created by Rayan Waked on 8/27/24.
//

// MARK: - IMPORT
import Foundation
import SwiftUI

// MARK: - MODEL
struct ScanModel {
    var recognizedText: [String] = []
    var problematicIngredients: [String] = ["Water"]
    var isProblematic: Bool = false
}
