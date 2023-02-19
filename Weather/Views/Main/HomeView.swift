//
//  HomeView.swift
//  Weather
//
//  Created by Ahmet Özkan on 18.02.2023.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable{
    case top = 0.83 // 702/844
    case middle = 0.385 // 325/844
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    
    var bottomSheetTranslationProated: CGFloat{
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                ZStack{
                    // MARK: Backgound Color
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationProated * imageOffset)
                    
                    // MARK: House Image
                    Image("House")
                        .frame(maxHeight: .infinity,alignment: .top)
                        .padding(.top,257)
                        .offset(y: -bottomSheetTranslationProated * imageOffset)
                    
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProated)) {
                        Text("Montreal")
                            .font(.largeTitle)
                        
                        VStack{
                            Text(attributedString)
                            
                            Text("H:24'    L:18'")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslationProated)
                        }
                        Spacer()
                    }
                    .padding(.top,51)
                    .offset(y: -bottomSheetTranslationProated * 46)
                    
                    // MARK: Bottom Sheet
                    BottomSheetView(position: $bottomSheetPosition){
                        Text(bottomSheetTranslationProated.formatted())
                    } content: {
                        ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProated)
                    }
                    .onBottomSheetDrag{ translation in
                        bottomSheetTranslation = translation / screenHeight
                        
                        withAnimation(.easeOut){
                            if bottomSheetPosition == BottomSheetPosition.top{
                                hasDragged = true
                                
                            }else{
                                hasDragged = false
                            }
                        }
                    }
                    // MARK: Tab Bar
                    TabBar(action: {
                        bottomSheetPosition = .top
                    })
                    .offset(y: bottomSheetTranslationProated * 156)
                }
                .navigationBarHidden(true)
            }
        }
    }
    
    private var attributedString: AttributedString{
        var string = AttributedString("19'" + (hasDragged ? " | " :  "\n ") + "Mostly Clear")
        
        if let temp = string.range(of: "19'") {
            string[temp].font = .system(size: (96 - (bottomSheetTranslationProated * (96 - 20))) ,weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProated)
        }
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
