//
//  ScanView.swift
//  Sakina
//
//  Created by Rayan Waked on 8/27/24.
//

// MARK: - IMPORT
import SwiftUI
import AVFoundation

// MARK: - VIEW
struct ScanView: View {
    @StateObject private var viewModel = ScannerViewModel()
    
    var body: some View {
        content
        .onAppear {
            viewModel.checkCameraPermission()
        }
    }
}

// MARK: - CONTENT
private extension ScanView {
    var content: some View {
        VStack {
            scanner
            scanButton
            ingredients
        }
    }
}

// MARK: - COMPONENTS
private extension ScanView {
    var title: some View {
        Text("Hi")
    }
    
    var scanner: some View {
        Camera(session: viewModel.scanManager.session)
            .aspectRatio(3/4, contentMode: .fit)
    }
    
    var scanButton: some View {
        Button("Scan Text") {
            viewModel.scanText()
        }
    }
    
    var ingredients: some View {
        Text("\(viewModel.model.recognizedText)")
    }
}

// MARK: - CAMERA
struct Camera: UIViewRepresentable {
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

// MARK: - PREVIEW
#Preview {
    ScanView()
}
