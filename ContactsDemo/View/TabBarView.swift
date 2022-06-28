//
//  TabBarView.swift
//  ContactsDemo
//
//  Created by Sopnil Sohan on 21/6/22.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                
            ContentView()
                .tabItem {
                    Label("Text", systemImage: "square.and.pencil")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
