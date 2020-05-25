//
//  ContentView.swift
//  LottoSpinner
//
//  Created by ranjet on 23.5.2020.
//  Copyright © 2020 ranjet. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var credit = 1000;
  
  @State private var symbols = ["apple", "star", "cherry"]
  @State private var numbers = Array(repeating: 0, count: 9)
  
  @State private var bgColor = Color.white
  @State private var betAmmount = 5
  
  var count = 0
  
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.orange)
        .edgesIgnoringSafeArea(.all)
      
      Rectangle()
        .foregroundColor(.yellow)
        .rotationEffect(Angle(degrees: 65))
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        HStack {
          Spacer()
          
          Image(systemName: "star.fill")
            .font(.title)
            .foregroundColor(.yellow)
          
          Spacer()
          
          Text("Lotto Lotto")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.white)
          
          
          Spacer()
          
          Image(systemName: "star.fill")
            .font(.title)
            .foregroundColor(.yellow)
          
          Spacer()
        }
        .shadow(radius: 0.1, x:1, y:1)
        
        Spacer()
        
        Text("Credits: " + String(credit))
          .padding(.all, 10)
          .background(Color.white.opacity(0.5))
          .cornerRadius(20)
        
        Spacer()
      
        VStack {
          HStack {
            
            FruitView(
              fruit: $symbols[numbers[0]],
              bgColor: $bgColor
            )
            
            FruitView(
              fruit: $symbols[numbers[1]],
              bgColor: $bgColor
            )
            
            FruitView(
              fruit: $symbols[numbers[2]],
              bgColor: $bgColor
            )
          }
          
          HStack {
            
            FruitView(
              fruit: $symbols[numbers[3]],
              bgColor: $bgColor
            )
            
            FruitView(
              fruit: $symbols[numbers[4]],
              bgColor: $bgColor
            )
            
            FruitView(
              fruit: $symbols[numbers[5]],
              bgColor: $bgColor
            )
          }
          
          HStack {
            
            FruitView(
              fruit: $symbols[numbers[6]],
              bgColor: $bgColor
            )
            
            FruitView(
              fruit: $symbols[numbers[7]],
              bgColor: $bgColor
            )
            
            FruitView(
              fruit: $symbols[numbers[8]],
              bgColor: $bgColor
            )
          }
        }
        
        Spacer()
        
        HStack {
          Spacer()
          
          VStack {
            Button(action: {
              self.spin(false)
              
            }, label: {
              Text("Spin")
                .bold()
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .background(Color.red)
                .cornerRadius(20)
              
            })
            
            Text("Cost: \(betAmmount) credits")
              .font(.caption)
              .padding(.top)
          }
          
          Spacer()
          
          VStack {
            Button(action: {
              self.spin(true)
              
            }, label: {
              
              Text("Max Spin")
                .bold()
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .background(Color.red)
                .cornerRadius(20)
              
            })
            
            Text("Cost: \(betAmmount * 5) credits")
              .font(.caption)
              .padding(.top)
          }
          
          Spacer()
        }
        
        Spacer()
      }
      
    }
    .background(/*@START_MENU_TOKEN@*/Color.orange/*@END_MENU_TOKEN@*/)
  }
  
  func spin(_ maxSpin:Bool) {
    self.bgColor = Color.white
    
    if maxSpin {
      self.numbers = self.numbers.map({ _ in
        Int.random(in: 0...2)
      })
    }
    else {
      self.numbers = self.numbers.map({ _ in
        0
      })
      
      self.numbers[3] = Int.random(in: 0...2)
      self.numbers[4] = Int.random(in: 0...2)
      self.numbers[5] = Int.random(in: 0...2)
    }
    
    
    // check for winnings
    processWins(maxSpin)
    
  }
  
  func processWins(_ maxSpin:Bool) {
    
    var matches = 0
    
    if maxSpin {
      // check for first row match
      if checkForMatch(self.numbers[0],self.numbers[1],self.numbers[2]) {
        matches += 1
      }
      
      // check for second row match
      if checkForMatch(self.numbers[3],self.numbers[4],self.numbers[5]) {
        matches += 1
      }
      
      // check for 3rd row match
      if checkForMatch(self.numbers[6],self.numbers[7],self.numbers[8]) {
        matches += 1
      }
      
      // check for diagonal match, top left to bottom right
      if checkForMatch(self.numbers[0],self.numbers[4],self.numbers[8]) {
        matches += 1
      }
      
      // check for diagonal match, top right to bottom left
      if checkForMatch(self.numbers[2],self.numbers[4],self.numbers[6]) {
        matches += 1
      }
    }
    else {
      if checkForMatch(self.numbers[3],self.numbers[4],self.numbers[5]) {
        matches += 1
      }
    }
    
    if maxSpin {
      if matches > 0 {
        self.credit += matches * self.betAmmount * 5
      }
      else {
        self.credit -= self.betAmmount * 10
      }
    }
    else {
      if matches > 0 {
        self.credit += self.betAmmount * 10
      }
      else {
        self.credit -= self.betAmmount
      }
    }
}
  
  func checkForMatch(_ index1:Int, _ index2:Int, _ index3:Int) -> Bool {
    if index1 == index2 && index2 == index3 {
      return true
    }
    
    return false
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
