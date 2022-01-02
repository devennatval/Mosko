//
//  OnboardingData.swift
//  Mosko
//
//  Created by Deven Nathanael on 30/12/21.
//

import Foundation

let tabs: [Page] = [
    Page(image: "Missing", title: "See Anywhere Anytime", text: "We help you to manage your pond better! By using our tech, you can easily monitor your pond with a single touch"),
    Page(image: "Missing", title: "Secure the Temperature", text: "By the help of our automation system, worry no more about the temperature changed. We'll automatically adjust it for you!"),
    Page(image: "Missing" ,title: "Get Notify" ,text: "We can also notify you when the temperature hits the limit or when the device is disconnected."),
    Page(image: "", title: "", text: "")
    
]

struct Page {
    let image: String
    let title: String
    let text: String
}
