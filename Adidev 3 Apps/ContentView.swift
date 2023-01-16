//
//  ContentView.swift
//  Adidev 3 Apps
//
//  Created by Joshua Boelman on 1/13/23.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
    
        NavigationView {
                    List {
                        NavigationLink(destination: ZocDocView()) {
                            Text("ZocDoc")
                        }
                        NavigationLink(destination: ADPView()) {
                            Text("ADP")
                        }
                        NavigationLink(destination: DoorDashView()) {
                            Text("Doordash")
                        }
                        Text("Touch the top title element of each demo to revert back to this page.")
                        
                    }.navigationBarTitle("Select a Demo")
                
                }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
