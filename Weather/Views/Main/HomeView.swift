//
//  HomeView.swift
//  Weather
//
//  Created by Ahmet Özkan on 18.02.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            // MARK: Backgound Color
            Color.background
                .ignoresSafeArea()
            
            // MARK: Background Image
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            
            // MARK: House Image
            Image("House")
                .frame(maxHeight: .infinity,alignment: .top)
                .padding(.top,257)
            
            VStack{
                Text("Montreal")
                    .font(.largeTitle)
                
                VStack{
                    Text("19'" + "\n" + "Mostly Clear")
                    
                    Text("H:24'    L:18'")
                        .font(.title3.weight(.semibold))
                }
                Spacer()
            }
            .padding(.top,51)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
