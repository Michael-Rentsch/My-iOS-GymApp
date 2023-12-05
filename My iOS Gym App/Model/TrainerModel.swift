//
//  TrainerModel.swift
//  My iOS Gym App
//
//  Created by Michael Rentsch on 2023/12/06.
//

import Foundation


struct TrainerModel: Identifiable {
    
    let id = UUID()
    let title: String
    let name: String
    let emote: String
    
}


let trainerModeldata: [TrainerModel] = [

    TrainerModel(title: "Personal Trainer",
                 name: "John",
                 emote: "dumbbell"),
    
    TrainerModel(title: "Personal Trainer",
                 name: "Sam",
                 emote: "dumbbell"),
    
    TrainerModel(title: "Massage",
                 name: "Emily",
                 emote: "figure.mind.and.body"),
    
    TrainerModel(title: "Tennis Coach",
                 name: "Ashley",
                 emote: "figure.tennis"),
    
    TrainerModel(title: "Boxing Coach",
                 name: "Jim",
                 emote: "figure.boxing"),
    
    TrainerModel(title: "Rock Climbing Coach",
                 name: "Chad",
                 emote: "figure.climbing"),
    
    TrainerModel(title: "Dancing Class",
                 name: "Julia",
                 emote: "figure.dance"),
    
    TrainerModel(title: "Cycling Class",
                 name: "Emily",
                 emote: "figure.indoor.cycle"),
    
    TrainerModel(title: "Swimming Class",
                 name: "Megan",
                 emote: "figure.pool.swim"),

]
