//
//  HomeModel.swift
//  Sakina
//
//  Created by Rayan Waked on 8/27/24.
//

// MARK: - IMPORT
import SwiftUI

struct SomethingModel {
    var something: String = ""
}

protocol SomethingManagerDelegate: AnyObject {
    func somethingManagerSaidSomething(_ something: String)
}

class SomethingManager {
    weak var delegate: SomethingManagerDelegate?
    
    func saySomething() {
        delegate?.somethingManagerSaidSomething("Hello")
    }
}

class SomethingViewModel: ObservableObject, SomethingManagerDelegate {
    @Published private(set) var model = SomethingModel()
    var manager: SomethingManager
    
    init(manager: SomethingManager = .init()) {
        self.manager = manager
        manager.delegate = self
    }
    
    func somethingManagerSaidSomething(_ something: String) {
        model.something = something
    }
}

struct SomethingView: View {
    @StateObject var viewModel = SomethingViewModel()
        
    var body: some View {
        Text(viewModel.model.something)
        Button("Say Something") {
            viewModel.manager.saySomething()
        }
    }
}

#Preview {
    SomethingView()
}
