//
//  ScanViewModel.swift
//  Sakina
//
//  Created by Rayan Waked on 8/27/24.
//

// MARK: - DIAGRAM
// ScannerViewModel
//       │
//       ├── Manages ScanModel (data store)
//       ├── Coordinates with ScanManager
//       ├── Performs text recognition
//       │
//       └── Updates UI via @Published properties ──┐
//                                                  │
//                                                  ▼
//                                         Any SwiftUI View
//                                         observing the ViewModel
//                                         (e.g., ScanView)
//                                                  │
//                                                  ▼
//                                         Displays recognized text
//                                         and camera preview

// MARK: - IMPORT
import AVFoundation
import Vision
// MARK: - VIEW MODEL
class ScannerViewModel: ObservableObject {
    @Published private(set) var model = ScanModel()
    let scanManager: ScanManager
    
    init(manager: ScanManager = ScanManager()) {
        self.scanManager = manager
        self.scanManager.delegate = self
    }
    
    func checkCameraPermission() {
        scanManager.checkCameraPermission()
    }
    
    func scanText() {
        scanManager.capturePhoto()
        model.recognizedText.removeAll()
    }
}
// MARK: - PERFORM RECOGNITION
private extension ScannerViewModel {
    func performTextRecognition(_ image: CGImage) {
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            let recognizedStrings = observations.compactMap { $0.topCandidates(1).first?.string }
            DispatchQueue.main.async {
                self?.model.recognizedText.append(recognizedStrings.joined(separator: ", "))
            }
        }
        
        // Specify accurate text detection
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        // Specify English language
        request.recognitionLanguages = ["en-US"]
        
        let handler = VNImageRequestHandler(cgImage: image, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform text recognition: \(error)")
        }
    }
}
// MARK: - SCANNER DELEGATE
extension ScannerViewModel: ScanManagerDelegate {
    func scanManagerDidCapturePhoto(_ image: CGImage) {
        performTextRecognition(image)
    }
}
