//
//  DetailText.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 12/15/20.
//

import SwiftUI

struct DetailText: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .thin, design: .rounded))
            .foregroundColor(.white)
    }
}

struct DetailText_Previews: PreviewProvider {
    static var previews: some View {
        DetailText("Text")
    }
}
