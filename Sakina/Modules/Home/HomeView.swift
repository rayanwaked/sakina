//
//  HomeView.swift
//  Sakina
//
//  Created by Rayan Waked on 8/27/24.
//

// MARK: - IMPORT
import SwiftUI

// MARK: - VIEW
struct HomeView: View {
    var body: some View {
        NavigationStack {
            content
        }
    }
}

// MARK: - CONTENT
private extension HomeView {
    var content: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                title
                manageKeywords
            }
            .padding(.bottom, 18.5)
            greetUser
                .padding(.bottom, 2)
            scanCounter
            scan
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 22.5)
        .backgroundGradient()
    }
}

// MARK: - COMPONENTS
private extension HomeView {
    var title: some View {
        Text("Riffle")
            .font(.title3.bold())
    }
    
    var manageKeywords: some View {
        HStack {
            Text("Manage Keywords")
            Image(systemName: "chevron.down")
        }
        .foregroundStyle(Color.gray.opacity(0.9))
    }
    
    var greetUser: some View {
        Text("Hello, User")
            .font(.largeTitle.bold())
    }
    
    var scanCounter: some View {
        Text("You've scanned 0 products so far")
            .font(.largeTitle.bold())
            .foregroundStyle(
                LinearGradient(
                    colors: [Color.red.opacity(0.6), Color.purple.opacity(0.6)],
                    startPoint: .leading,
                    endPoint: .trailing
            ))
    }
    
    var scan: some View {
        NavigationLink(destination: ScanView()) {
            HStack {
                Image(systemName: "rectangle.and.text.magnifyingglass")
                
                Text("Scan a label")
                
                Spacer()
            }
            .padding(.horizontal, 14)
        }
        .frame(maxWidth: width, maxHeight: 50)
        .foregroundStyle(Color.gray.opacity(0.7))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - MODIFIERS
struct BackgroundGradient: ViewModifier {
    func body(content: Content) -> some View {
        content
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.background, location: 0),
                    .init(color: Color.white, location: 0.6)
                ]),
                startPoint: .top,
                endPoint: .bottom
            ))
    }
}

extension View {
    func backgroundGradient() -> some View {
        modifier(BackgroundGradient())
    }
}

// MARK: - PREVIEW
#Preview {
    HomeView()
}
