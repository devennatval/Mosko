//
//  PageTabView.swift
//  SwiftUI_OnBoarding
//
//  Created by Deven Nathanael on 30/12/21.
//

import SwiftUI

struct PageTabView: View {
    @State var topic: String = ""
    @State var password: String = ""
    @Binding var selection: Int
    @Binding var isOnboardingViewShowing: Bool

    var body: some View {
        TabView(selection: $selection) {
            ForEach(tabs.indices, id: \.self) { index in
                if index != 3 {
                    TabDetailsView(index: index)
                }
                else {
                    VStack {
                        Spacer()
                        Text("Connect Device")
                            .font(.title)
                            .bold()
                            .padding(.vertical)
                        Text("Please input your device's topic")
                        TextField("My Topic", text: $topic)
                            .autocapitalization(.none)
                            .padding()
                            .background(.white)
                            .cornerRadius(15)
                            .padding(.top)
                            .padding(.horizontal,30)
                            .shadow(color: .gray.opacity(0.25), radius: 5, x: 0, y: 0)
                        SecureField("Enter a password", text: $password)
                            .padding()
                            .background(.white)
                            .cornerRadius(15)
                            .padding(.vertical)
                            .padding(.horizontal,30)
                            .shadow(color: .gray.opacity(0.25), radius: 5, x: 0, y: 0)
                        Button(action: {
                            if topic != "" && password != "" {
                                UDHelper.sharedUD.setUsername(username: topic.components(separatedBy: "/")[0])
                                UDHelper.sharedUD.setPassword(password: password)
                                UDHelper.sharedUD.setTopic(topic: topic)
                                UDHelper.sharedUD.setNewUser(new: false)
                                print(UDHelper.sharedUD.getUsername())
                                print(UDHelper.sharedUD.getPassword())
                                print(UDHelper.sharedUD.getTopic())
                                print(UDHelper.sharedUD.isNewUser())

                                withAnimation {
                                    isOnboardingViewShowing.toggle()
                                }
                            }
                        }, label: {
                            Text("Connect")
                                .bold()
                                .frame(width: 300, height: 44)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                                .padding()
                                
                        })
                        Spacer()

                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct PageTabView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PageTabView(topic: "", selection: Binding.constant(3), isOnboardingViewShowing: Binding.constant(true))
        }
    }
}
