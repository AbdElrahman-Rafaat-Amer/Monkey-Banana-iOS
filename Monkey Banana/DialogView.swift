//
//  DialogView.swift
//  Monkey Banana
//
//  Created by Abdelrahman Rafaat on 20/09/2023.
//

import SwiftUI

struct DialogView: View {
    @Binding var playerScore: Int
    @Binding var bestScore  : Int
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack{
            Color(.black)
                .opacity(0.7)
            
            VStack{
                Text("Game Over")
                    .padding(.bottom, 40)
                    .font(.system(size: 35, weight: .bold, design: .default))
                
                Text("Your Score: \(playerScore)")
                    .padding(.bottom, 10)
                    .font(.system(size: 25))
                
                Text("Best Score: \(bestScore)")
                    .padding(.bottom, 40)
                    .font(.system(size: 25))
                
                Button {
                    print("Abdo Cancel button Clicked")
                    isPresented = false
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.red)
                        
                        Text("Cancel")
                            .foregroundColor(.white)
                            .padding()
                            .font(.system(size: 20, weight: .bold))
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
//            .padding(.horizontal, 90)
            .padding(20)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
        }.ignoresSafeArea()
    }
}

struct DialogView_Previews: PreviewProvider {
    @State static var playerScore = 100
    @State static var bestScore = 204
    @State static var isPresented = true
    static var previews: some View {
        DialogView(playerScore: $playerScore, bestScore: $bestScore, isPresented: $isPresented)
    }
}
