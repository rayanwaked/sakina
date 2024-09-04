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
    @ObservedObject var viewModel: ScannerViewModel
    
    var body: some View {
        content
    }
}

// MARK: - CONTENT
private extension ProductView {
    var content: some View {
        VStack {
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
    // Synopsis
    var synopsis: some View {
        if viewModel.model.isProblematic {
            Text("Caution: This item contains ingredients you want to avoid")
        } else {
            Text("You're good to go!")
        }
    }
    
    // Ingredients
    var ingredients: some View {
        Text("\(viewModel.model.recognizedText)")
    }
}

// MARK: - PREVIEW
#Preview {
    ProductView(viewModel: ScannerViewModel())
}
