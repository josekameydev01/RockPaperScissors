//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by carlosgalvankamey on 8/24/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberOfQuestion = 1
    @State private var points = 0
    @State private var showPlayerFeedback = false
    @State private var showPlayerFinalScore = false
    @State private var appChoice = "paper"
    @State private var userChoice = "paper"
    
    private var options = ["rock", "paper", "scissors"]
    
    private var alertMessage: String {
        if isATie(userChoice: userChoice) {
            return """
                It is a tie!
                App choice: \(appChoice)
                User choice: \(userChoice)
                Your score remains the same!
                """
        }
        
        if userWins(userChoice: userChoice) {
            return """
                You win!
                App choice: \(appChoice)
                User choice: \(userChoice)
                You win 1 point!
                """
        } else {
            return """
                You lose!
                App choice: \(appChoice)
                User choice: \(userChoice)
                You lose 1 point
                """
        }
    }
    
    var body: some View {
        NavigationStack {
            Spacer()
            Text("Player Score: \(points)")
                .font(.title)
                .foregroundStyle(points < 0 ? .red : .black)
            Spacer()
            VStack (alignment: .center, spacing: 25){
                ForEach(0..<3) { number in
                    VStack {
                        Button() {
                            userChoice = options[number]
                            appChoice = getAppChoice()
                            showPlayerFeedback = true
                        } label: {
                            Image(options[number])
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        Text(options[number])
                            .fontWeight(.bold)
                    }
                }
            }
            Spacer()
            Spacer()
            Text("\(numberOfQuestion) / 10")
                .navigationTitle("Rock Paper Scissors")
        }
        .alert("Result", isPresented: $showPlayerFeedback) {
            Button("OK") {
                
                if isATie(userChoice: userChoice) {
                    points = points
                } else if userWins(userChoice: userChoice) {
                    points += 1
                } else {
                    points -= 1
                }
                
                
                if numberOfQuestion >= 10 {
                    showPlayerFinalScore = true
                } else {
                    numberOfQuestion += 1
                }
            }
        } message: {
            Text(alertMessage)
        }
        .alert("Game over!", isPresented: $showPlayerFinalScore) {
            Button("Play Again") {
                points = 0
                numberOfQuestion = 1
                showPlayerFeedback = false
                showPlayerFinalScore = false
            }
        } message: {
            Text("Your final score is: \(points)")
        }
    }
    private func getAppChoice() -> String {
        options.randomElement() ?? "paper"
    }
    private func isATie(userChoice: String) -> Bool {
        return userChoice == appChoice
    }
    private func userWins(userChoice: String) -> Bool {
        
        if userChoice == "rock" && appChoice == "scissors" {
            return true
        } else if userChoice == "paper" && appChoice == "rock" {
            return true
        } else if userChoice == "scissors" && appChoice == "paper" {
            return true
        }
        
        return false
    }
}

#Preview {
    ContentView()
}
