//
//  ScanManager.swift
//  Sakina
//
//  Created by Rayan Waked on 8/27/24.
//

// MARK: - DIAGRAM
// ScanManager
//       │
//       ├── Manages camera permission
//       ├── Sets up camera session
//       ├── Captures photo
//       │
//       └── Sends photo to delegate ──┐
//                                     │
//                                     ▼
//                            Any class conforming to
//                            ScanManagerDelegate
//                            (e.g., ScannerViewModel)
//                                     │
//                                     ▼
//                            Processes the image
//                            (e.g., text recognition)

// MARK: - IMPORT
import AVFoundation
import UIKit

// MARK: - PROTOCOL
protocol ScanManagerDelegate: AnyObject {
    func scanManagerDidCapturePhoto(_ image: CGImage)
}

// MARK: - CAPTURE MANAGER
class ScanManager: NSObject {
    weak var delegate: ScanManagerDelegate?
    
    let session = AVCaptureSession()
    let sessionQueue = DispatchQueue(label: "sessionQueue")
    let capturePhotoOutput = AVCapturePhotoOutput()
    
    var cropRect: CGRect?
    
    override init() {
        super.init()
        setupCaptureSession()
    }
    
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            sessionQueue.async { [weak self] in
                self?.session.startRunning()
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    self?.sessionQueue.async {
                        self?.session.startRunning()
                    }
                }
            }
        default:
            break
        }
    }
    
    private func setupCaptureSession() {
        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            self.session.beginConfiguration()
            
            guard let camera = AVCaptureDevice.default(for: .video),
                  let input = try? AVCaptureDeviceInput(device: camera) else { return }
            
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.capturePhotoOutput) {
                self.session.addOutput(self.capturePhotoOutput)
            }
            
            self.session.commitConfiguration()
        }
    }
    
    func capturePhoto() {
        guard session.isRunning else { return }
        let settings = AVCapturePhotoSettings()
        capturePhotoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func setCropRect(_ rect: CGRect) {
            cropRect = rect
        }
        
        private func cropToSquare(_ inputImage: CGImage) -> CGImage? {
            let width = inputImage.width
            let height = inputImage.height
            let size = min(width, height)
            
            let x = (width - size) / 2
            let y = (height - size) / 2
            
            let cropRect = cropRect ?? CGRect(x: x, y: y, width: size, height: size)
            
            return inputImage.cropping(to: cropRect)
    }
}

// MARK: - CAPTURE DELEGATE
extension ScanManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData)?.cgImage else { return }
        
        delegate?.scanManagerDidCapturePhoto(image)
    }
}
