//
//  FruitView.swift
//  LottoSpinner
//
//  Created by ranjet on 24.5.2020.
//  Copyright © 2020 ranjet. All rights reserved.
//

import SwiftUI

struct FruitView: View {
  
  @Binding var fruit:String;
  @Binding var bgColor:Color
  
  var body: some View {
    
      Image(fruit)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .background(bgColor.opacity(0.5))
        .cornerRadius(20)
      
  }
}

struct FruitView_Previews: PreviewProvider {
  static var previews: some View {
    FruitView(
      fruit: Binding.constant("cherry"),
      bgColor: Binding.constant(Color.green)
    )
  }
}
