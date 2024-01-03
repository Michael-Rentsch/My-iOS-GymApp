//
//  BookingsView.swift
//  My iOS Gym App
//
//  Created by Michael Rentsch on 2023/12/02.
//

import SwiftUI

struct BookingsView: View {
    
    @State private var isShowingSheet = false
    @State private var date = Date()
    
    var body: some View {
        
        NavigationStack {
            
            List {
                ForEach(trainerModeldata) { trainer in
                    BookingsCell(trainer: trainer)
                        .onTapGesture {
                            isShowingSheet.toggle()
                        }
                }
                
            }
            .navigationTitle("Bookings")
            .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
                VStack {
                    Text("Personal Trainer")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    Text("Trainer name")
                        .font(.title2)
                        .padding()
                    
                    Button{
                        
                    } label: {
                        
                        Text("Pick Date")
                        Image(systemName: "calendar")
                    }
                         
                }
            }
            
        }
    }
}


func didDismiss() {
    print("Chicken")
}

#Preview {
    BookingsView()
}


struct BookingsCell: View {
    
    var trainer: TrainerModel
    
    var body: some View {
        HStack {
            Text(trainer.title + " -")
               
            Text(trainer.name)
                
            Spacer()
            Image(systemName: trainer.emote)   
                
        }
    }
}

