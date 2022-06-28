//
//  ContentView.swift
//  ContactsDemo
//
//  Created by Sopnil Sohan on 16/6/22.
//

import SwiftUI
import Contacts

struct ContentView: View {
    @ObservedObject var vm = FetchSpecificContacts()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(vm.contacts, id: \.self) { item in
                    if item.name != nil {
                        HStack {
                            Text(item.name!)
                            Spacer()
                        }
                    }
                    HStack(spacing: 5){
                        Spacer()
                        VStack(alignment:.leading){
                            if !item.mobile.isEmpty {
                                Text("Mobile:")
                                ForEach(item.mobile, id: \.self) { number in
                                    Text(number)
                                        .onTapGesture {
                                            print("Tap in\(number) \(String(describing: item.name))")
                                        }
                                }
                            }
                            if !item.main.isEmpty{
                                Text("Main:")
                                ForEach(item.main , id: \.self) { number in
                                    Text(number)
                                }
                            }
                            if !item.other.isEmpty {
                                Text("Other:")
                                ForEach(item.other , id: \.self) { number in
                                    Text(number)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            Task.init {
                await vm.fetchAllContacts()
            }
        }
    }
}
