//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by carlosgalvankamey on 8/24/25.
//

import SwiftUI

struct ContentView: View {
    
    enum RoundResult {
        case tie, win, lose
    }
    
    @State private var numberOfQuestion = 1
    @State private var points = 0
    @State private var showPlayerFeedback = false
    @State private var showPlayerFinalScore = false
    @State private var appChoice = "paper"
    @State private var userChoice = "paper"
    
    private var options = ["rock", "paper", "scissors"]
    
    private var roundResult: RoundResult {
        if userChoice == appChoice {
            return .tie
        }
        else if userChoice == "rock" && appChoice == "scissors" {
            return .win
        } else if userChoice == "paper" && appChoice == "rock" {
            return .win
        } else if userChoice == "scissors" && appChoice == "paper" {
            return .win
        } else {
            return .lose
        }
    }
    
    private var alertTitle: String {
        switch roundResult {
        case .tie:
            return "It's a Tie"
        case .win:
            return "You Win!"
        case .lose:
            return "You Lose!"
        }
    }
    
    private var results: String {
        """
        App choice: \(appChoice)
        User choice: \(userChoice)
        """
    }
    
    private var alertMessage: String {
        switch roundResult {
        case .tie:
            return """
                \(results)
                Your score remains the same!
                """
        case .win:
            return """
                \(results)
                You win 1 point!
                """
        case .lose:
            return """
                \(results)
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
                            startRound(with: options[number])
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
        .alert(alertTitle, isPresented: $showPlayerFeedback) {
            Button("OK", action: completeRound)
        } message: {
            Text(alertMessage)
        }
        .alert("Game over!", isPresented: $showPlayerFinalScore) {
            Button("Play Again", action: resetGame)
        } message: {
            Text("Your final score is: \(points)")
        }
    }
    private func startRound(with choice: String) {
        appChoice = options.randomElement() ?? "paper"
        userChoice = choice
        showPlayerFeedback = true
    }
    private func completeRound() {
        switch roundResult {
        case .tie:
            break
        case .lose:
            points -= 1
        case .win:
            points += 1
        }
        
        if numberOfQuestion >= 10 {
            showPlayerFinalScore = true
        } else {
            numberOfQuestion += 1
        }
    }
    private func resetGame() {
        points = 0
        numberOfQuestion = 1
        showPlayerFeedback = false
        showPlayerFinalScore = false
    }
}

#Preview {
    ContentView()
}
