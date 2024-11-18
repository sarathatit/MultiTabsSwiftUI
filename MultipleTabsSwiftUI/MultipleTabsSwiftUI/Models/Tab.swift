//
//  Tab.swift
//  MultipleTabsSwiftUI
//
//  Created by Sarath kumar on 18/11/24.
//

import Foundation

enum Tab: String, CaseIterable {
    case chats = "Chats"
    case calls = "Calls"
    case settings = "Settings"
    
    var systemImage: String {
        switch self {
        case .chats :
            return "phone"
        case .calls :
            return "bubble.left.and.bubble.right"
        case .settings :
            return "gear"
        }
    }
}
