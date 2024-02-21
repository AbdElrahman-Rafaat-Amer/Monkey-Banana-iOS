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
                        NavigationLink(destination: ContentView()){
                            Text("Cancel")
                                .foregroundColor(.white)
                                .padding()
                                .font(.system(size: 20, weight: .bold))
                        }
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(20)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
        }.ignoresSafeArea()
    }
}

struct DialogView_Previews: PreviewProvider {
    static var previews: some View {
        DialogView(playerScore: .constant(10), bestScore: .constant(90) ,isPresented: .constant(true))
    }
}
