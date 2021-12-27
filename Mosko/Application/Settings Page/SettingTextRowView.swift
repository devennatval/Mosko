//
//  SettingTextRowView.swift
//  mosko
//
//  Created by Deven Nathanael on 18/11/21.
//

import SwiftUI

struct SettingTextRowView: View {
    let titleSetting: String
    
    let inputPlaceholder: String
    @Binding var inputText: String
    
    var body: some View {
        HStack {
            Text(titleSetting)
            TextField(inputPlaceholder, text: $inputText)
//                .foregroundColor(Color.gray)
                .multilineTextAlignment(.trailing)
        }
    }
}

//struct SettingTextRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingTextRowView(titleSetting: "Pond's Name", inputPlaceholder:"Kolam 1")
//    }
//}
