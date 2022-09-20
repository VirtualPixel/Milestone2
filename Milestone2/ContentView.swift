//
//  ContentView.swift
//  Milestone2
//
//  Created by Justin Wells on 9/19/22.
//

import SwiftUI

struct ContentView: View {
    var moves = ["Rock", "Paper", "Scissors"]
    
    @State var computerMoveSelection = Int.random(in: 0..<3)
    @State var didWin = false
    @State var winLoseText = ""
    @State var outcome = Bool.random()
    @State var gameCount = 0
    @State var playerScore = 0
    @State var gameOver = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.15, green: 0.5, blue: 0.8), location: 0.3),
                .init(color: Color(red: 0.143, green: 0.188, blue: 0.219), location: 0.3),
            ], center: .top, startRadius: 150, endRadius: 700)
                .ignoresSafeArea()
                
            VStack {
                Text("Player Score: \(playerScore)")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("🤔")
                    .font(.system(size: 150))
                
                Spacer()
                
                Text(winLoseText)
                    .font(.largeTitle).bold()
                    .foregroundColor(didWin ? .green : .red)
                
                Spacer()
                
                Text("The computer chose \(moves[computerMoveSelection]) for it's move.")
                    .foregroundColor(.white)
                
                VStack {
                    Text("Which option would you \(outcome ? "win" : "lose") with?")
                        .foregroundColor(.white)
                    
                    ForEach (0..<3){ number in
                        Button {
                            winOrLose(result: gameLogic(playerChoice: number))
                        } label: {
                            Text(moves[number])
                        }
                        .frame(width: 100, height: 35)
                        .background(Color .blue)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: 350)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
            }
            .alert("Game Over!", isPresented: $gameOver){
                Button("Restart", role: .cancel){
                    restartGame()
                }
            } message: {
                Text("The game is now over! You ended with a score of \(playerScore).")
            }
        }
    }
    func nextRound(){
        if gameCount < 9 {
            randomMove()
            outcome.toggle()
            gameCount += 1
            winLoseText = didWin ? "Correct!" : "Wrong!"
        } else {
            gameOver = true
        }
    }
    
    func restartGame(){
        gameCount = 0
        winLoseText = ""
        outcome = Bool.random()
        
    }
    
    func randomMove(){
        let oldMove = computerMoveSelection
        computerMoveSelection = Int.random(in: 0..<moves.count)
        
        if oldMove == computerMoveSelection {
            randomMove()
        }
    }
    
    func winOrLose(result: Bool){
        if result {
            playerScore += 1
        } else {
            playerScore -= 1
        }
        
        didWin = result
        nextRound()
    }
    
    func gameLogic(playerChoice: Int) -> Bool{
        if outcome {
            if moves[computerMoveSelection] == "Rock" && moves[playerChoice] == "Paper"{
                return true
            }
            if moves[computerMoveSelection] == "Paper" && moves[playerChoice] == "Scissors"{
                return true
            }
            if moves[computerMoveSelection] == "Scissors" && moves[playerChoice] == "Rock"{
                return true
            }
        } else {
            if moves[computerMoveSelection] == "Rock" && moves[playerChoice] == "Scissors"{
                return true
            }
            if moves[computerMoveSelection] == "Paper" && moves[playerChoice] == "Rock"{
                return true
            }
            if moves[computerMoveSelection] == "Scissors" && moves[playerChoice] == "Paper"{
                return true
            }
        }
            
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
