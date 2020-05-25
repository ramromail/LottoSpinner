//
//  SlotView.swift
//  LottoSpinner
//
//  Created by ranjet on 24.5.2020.
//  Copyright © 2020 ranjet. All rights reserved.
//

import SwiftUI

struct SlotView: View {
  
  @Binding var arr:Array<Int>
  
  var body: some View {
    
    VStack {
      Group {
        
        self.arr.map { i in
          return Label(String(i))
        }
        
      }
    }
  }
}

struct SlotView_Previews: PreviewProvider {
  static var previews: some View {
    SlotView()
  }
}
