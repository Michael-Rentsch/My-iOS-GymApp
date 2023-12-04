//
//  TabView.swift
//  My iOS Gym App
//
//  Created by Michael Rentsch on 2023/12/02.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        
        TabView {
            BarcodeScannerView()
                .tabItem { Label("Scanner", systemImage: "qrcode.viewfinder") }
            
            BookingsView()
                .tabItem { Label("Bookings", systemImage: "calendar.badge.clock") }
        }
        
    }
}

#Preview {
    MainTabView()
}
