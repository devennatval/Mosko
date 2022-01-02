//
//  TabDetailsView.swift
//  SwiftUI_OnBoarding
//
//  Created by Deven Nathanael on 30/12/21.
//

import SwiftUI

struct TabDetailsView: View {
    let index: Int
    
    var body: some View {
        VStack {
            Image(tabs[index].image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
            Text(tabs[index].title)
                .font(.title)
                .bold()
                .padding(.vertical)
            Text(tabs[index].text)
        }
        .foregroundColor(.black)
        .padding(.horizontal,30)
    }
}

struct TabDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            TabDetailsView(index: 2)
        }
    }
}
