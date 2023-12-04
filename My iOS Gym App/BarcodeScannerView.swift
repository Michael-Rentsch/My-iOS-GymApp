//
//  ContentView.swift
//  My iOS Gym App
//
//  Created by Michael Rentsch on 2023/11/30.
//

import SwiftUI
import AVKit

struct BarcodeScannerView: View {
    // QR Code scanner properties
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    // QR Scanner AV Output
    @State private var errorMessage: String = ""
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var showError: Bool = false
    
    @Environment(\.openURL) private var openURL
    
    @StateObject private var qrDelegate = QRScannerDelegate()
    
    @State private var scannedCode: String = ""
    
    
    var body: some View {
        VStack(spacing: 15) {
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundStyle(Color.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Place QR code inside the area")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Scanning will begin automatically")
                .font(.callout)
                .foregroundStyle(Color.gray)
            
            Spacer(minLength: 0)
            
            //Scanner
            GeometryReader {
                let size = $0.size
                
                ZStack {
                    CameraView(frameSize: CGSize(width: size.width, height: size.width), session: $session)
                        .scaleEffect(0.97)
                    
                    ForEach(0...4, id: \.self) { index in
                        let rotation = Double(index) * 90
                        
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            .trim(from:  0.61, to: 0.64)
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: rotation))
                    }
                }
                .frame(width: size.width, height: size.width)
                .overlay(alignment: .top, content: {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: 2.5)
                        .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: 15)
                        .offset(y: isScanning ? size.width : 0)
                })
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, 45)
            
            Spacer(minLength: 15)
            
            Button {
                if !session.isRunning && cameraPermission == .approved {
                    reactivateCamera()
                    activateScannerAnimation()
                }
            } label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.largeTitle)
                    .foregroundStyle(Color.gray)
            }
            Spacer(minLength: 45)
            
        }
        .padding(15)
        .onAppear(perform: {
            checkCameraPermission()
        })
        .alert(errorMessage, isPresented: $showError) {
            if cameraPermission == .denied {
                Button("Settings") {
                    let settingsString = UIApplication.openSettingsURLString
                    if let settingsURL = URL(string: settingsString) {
                        openURL(settingsURL)
                    }
                }
                
                Button("Cancel", role: .cancel) {
                    
                }
            }
        }
        
        .onChange(of: qrDelegate.scannedCode, initial: true) { oldValue,newValue in
            if let code = newValue {
                scannedCode = code
                session.stopRunning()
                DeActivateScannerAnimation()
                qrDelegate.scannedCode = nil
            }
        }
        
    }
    
    func reactivateCamera()  {
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
        func activateScannerAnimation() {
            
            //responsible for animation
            withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
                isScanning = true
            }
        }
    
    func DeActivateScannerAnimation() {
        
        //responsible for animation
        withAnimation(.easeInOut(duration: 0.85)) {
            isScanning = false
        }
    }
    
    func checkCameraPermission()  {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty {
                    setupCamera()
                } else {
                    session.startRunning()
                }
                
            case .notDetermined:
                
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    cameraPermission = .denied
                    presentError("Please provide access to camera for scanning QR codes")
                }
                
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Please provide access to camera for scanning QR codes")
            default: break
            }
        }
    }
    
    func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("UNKNOWN ERROR")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("UNKNOWN ERROR")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            
            qrOutput.metadataObjectTypes = [.qr]
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activateScannerAnimation()
            
        } catch {
            presentError(error.localizedDescription)
        }
    }

    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
    
}

#Preview {
    BarcodeScannerView()
}
