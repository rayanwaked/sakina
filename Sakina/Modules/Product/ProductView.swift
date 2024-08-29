//
//  ProductView.swift
//  Sakina
//
//  Created by Rayan Waked on 8/27/24.
//

// MARK: - IMPORT
import SwiftUI

// MARK: - VIEW
struct ProductView: View {
    var body: some View {
        content
    }
}

// MARK: - CONTENT
private extension ProductView {
    var content: some View {
        VStack {
            title
            Divider()
            synopsis
            Divider()
            ingredients
            Divider()
        }
        .padding()
    }
}

// MARK: - COMPONENTS
private extension ProductView {
    // Title
    var title: some View {
        Text("Protein Shake")
    }
    
    // Synopsis
    var synopsis: some View {
        Text("Gluten")
    }
    
    // Ingredients
    var ingredients: some View {
        Text("Wheat")
    }
}

// MARK: - PREVIEW
#Preview {
    ProductView()
}
