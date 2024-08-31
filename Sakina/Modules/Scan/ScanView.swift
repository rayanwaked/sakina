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
        if viewModel.model.recognizedText.isEmpty {
            content
                .onAppear {
                    viewModel.checkCameraPermission()
                }
        } else {
            ProductView(viewModel: viewModel)
        }
    }
}

// MARK: - CONTENT
private extension ScanView {
    var content: some View {
        ZStack {
            scanner
            squareOverlay
            VStack {
                Spacer()
                scanButton
            }
        }
    }
}

// MARK: - COMPONENTS
private extension ScanView {
    var scanner: some View {
        Camera(session: viewModel.scanManager.session)
            .frame(width: width, height: height)
            .clipShape(Rectangle())
    }
    
    var squareOverlay: some View {
        GeometryReader { geometry in
            let squareSize = min(width, height) * 0.8
            let origin = CGPoint(
                x: (width - squareSize) / 2,
                y: (height - squareSize) / 2
            )
            let rect = CGRect(origin: origin, size: CGSize(width: squareSize, height: squareSize))
            
            Rectangle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: squareSize, height: squareSize)
                .position(x: width / 2, y: height / 2)
                .onAppear {
                    viewModel.scanManager.setCropRect(rect)
                }
        }
    }
    
    var scanButton: some View {
        Button("Scan Text") {
            viewModel.scanText()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
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
