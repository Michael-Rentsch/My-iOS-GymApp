//
//  ContentView.swift
//  My iOS Gym App
//
//  Created by Michael Rentsch on 2023/11/30.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @State private var isScanning: Bool = false
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
            
            Text("Scanning will begin automatically")
                .font(.callout)
                .foregroundStyle(Color.gray)
            
            Spacer(minLength: 0)
            
            //Scanner
            GeometryReader {
                let size = $0.size
                
                ZStack {
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
                
            } label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.largeTitle)
                    .foregroundStyle(Color.gray)
            }
            Spacer(minLength: 45)
            
        }
        .padding(15)
        
    }
        func activateScannerAnimation() {
            
            //responsible for animation
            withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
                isScanning = true
            }
        }

    
}

#Preview {
    BarcodeScannerView()
}
