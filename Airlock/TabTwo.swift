//
//  TabTwo.swift
//  Airlock
//
//  Created by Laurent B on 28/08/2020.
//


import SwiftUI

struct TabTwo: View {
    @State var toggleIsOn: Bool = false
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    var body: some View {
        ZStack{
            BackgroundGradient()
            GeometryReader { geometry in
            
                Form {
                    Section(header: Text("Settings")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .bold()
                                .padding()
                    ) {
                        Text("About This App").font(.title)
                        Text("Dark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode SettingsDark Mode Settings")
                        
                        //Toggle()
                    }.listRowBackground(BackgroundGradient().opacity(0.8))
                    
                    Section(header: Text(""), footer: Text("ok").bold() )
                     {
                        Text("Dark Mode Settings").font(.title)
                        Toggle(isOn: $toggleIsOn, label: {
                            Text("DarkMode?")
                        })
                    }.listRowBackground(BackgroundGradient().opacity(0.8))
                    
                }
                
            }.clipShape(RoundedRectangle(cornerRadius: 25.0)).padding(40)
        }
        
    }
}

struct TabTwo_Previews: PreviewProvider {
    static var previews: some View {
        TabTwo()
            .preferredColorScheme(.light)
    }
}
