//
//  HomeModel.swift
//  Sakina
//
//  Created by Rayan Waked on 8/27/24.
//

// MARK: - IMPORT
import Foundation
import SwiftUI

struct SomethingModel {
    var somethingToSay: String = ""
}

protocol SomethingManagerDelegate: AnyObject {
    func somethingManagerSaidSomething(_ something: String)
}

class SomethingManager {
    weak var delegate: SomethingManagerDelegate?
    
    func saySomething() {
        delegate?.somethingManagerSaidSomething("Hi")
    }
}

class SomethingViewModel: ObservableObject, SomethingManagerDelegate {
    @Published private(set) var model = SomethingModel()
    let manager: SomethingManager
    
    init(_ manager: SomethingManager = .init()) {
        self.manager = manager
        manager.delegate = self
    }
    
    func somethingManagerSaidSomething(_ something: String) {
        model.somethingToSay = something
    }
}

struct SomethingView: View {
    @ObservedObject var viewModel = SomethingViewModel()
    
    var body: some View {
        Text(viewModel.model.somethingToSay)
        Button("Say Something") {
            viewModel.manager.saySomething()
        }
    }
}

#Preview {
    SomethingView()
}
