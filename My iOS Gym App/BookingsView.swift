//
//  BookingsView.swift
//  My iOS Gym App
//
//  Created by Michael Rentsch on 2023/12/02.
//

import SwiftUI

struct BookingsView: View {
    
    @State private var isShowingSheet = false
    @State private var date = Date.now
    @State private var time = Date.now
    
    @State private var activity = "Personal Trainer"
    @State private var trainerName  = "Trainer name"
    
    var body: some View {
        
        NavigationStack {
            
            List {
                ForEach(trainerModeldata) { trainer in
                    BookingsCell(trainer: trainer)
                        .onTapGesture {
                            isShowingSheet.toggle()
                            activity = trainer.title
                            trainerName = trainer.name
                            
                        }
                }
                
            }
            .navigationTitle("Bookings")
            .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
                VStack {
                
                    HStack {
                        Spacer()
                        
                        Button {
                            isShowingSheet = false
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 45, height: 45)
                                .foregroundColor(Color(.label))
                                .padding()
                                
                        }
                    }
                
                    
                    Text(activity)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    Text(trainerName)
                        .font(.title2)
                        .padding()
                                    
                    DatePicker(selection: $date, displayedComponents: .date) {
                                    Text("Select a date")
                                }
                    .padding()
                    
                    DatePicker(selection: $time, displayedComponents: .hourAndMinute) {
                                    Text("Select a Time")
                                }
                    .padding()
                   Spacer()
                }
                .padding(.top)
            }
            
        }
    }
}


func didDismiss() {
    
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

