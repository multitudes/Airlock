//
//  TabTwo.swift
//  Airlock
//
//  Created by Laurent B on 28/08/2020.
//

import UIKit
import SwiftUI
import AVFoundation


struct Device {
    
    // MARK: - Singletons
    static var name: String {
        struct Singleton {
            static let deviceName = UIDevice.current.name
        }
        
        return Singleton.deviceName
    }
    static var osVersion: String {
        struct Singleton {
            static let deviceVersion = UIDevice.current.systemVersion
        }
        
        return Singleton.deviceVersion
    }
}

struct TabTwo: View {
    
    @EnvironmentObject var settings: UserSettings
    
    //@Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    @State var toggleIsOn: Bool = false
    @State var vibrateIsOn: Bool = false

    init(){
        UITableView.appearance().backgroundColor = .clear
        print(Device.name)
        print(Device.osVersion)
    }
    
    var body: some View {
        NavigationView {
           
            ZStack{
                
                BackgroundGradient().opacity(0.2)
                GeometryReader { geometry in
                    
                    Form {
                        Section(header: Text("General"), footer: Text("©Laurent Brusa v1.0 2020")
                        ) {
                            NavigationLink(destination: AboutThisApp()) {
                                HStack {
                                    Image(systemName: "info.circle").padding(5)
                                    Text("About This App")
                                }
                            }
                            NavigationLink(destination: AboutThisApp()) {
                                HStack {
                                    Image(systemName: "hand.thumbsup").padding(5)
                                    Text("Recommend App")
                                }
                            }
                            NavigationLink(destination: AboutThisApp()) {
                                HStack {
                                    Image(systemName: "star").padding(5)
                                    Text("Rate App")
                                }
                            }
                            NavigationLink(destination: AboutThisApp()) {
                                HStack {
                                    Image(systemName: "bubble.left").padding(5)
                                    Text("Feedback")
                                }
                            }
                            NavigationLink(destination: AboutThisApp()) {
                                HStack {
                                    Image(systemName: "doc.text.magnifyingglass").padding(5)
                                    Text("Privacy")
                                }
                            }
                        }
                        
                        .listRowBackground(BackgroundGradient().opacity(0.8))
//                        .onAppear( perform: {
//                            UITableView.appearance().backgroundColor = .clear
//                        })
                        
                        
//                        Section(header: Text("Settings"), footer: Text("©Laurent Brusa v1.0 2020").bold())
//                        {
//                        if Device.name.contains("iPhone") {
//                            Toggle(isOn: $settings.vibrate, label: {
//                                    Text("Vibrate")
//
//                                })
//                            }
//                        Toggle(isOn: $toggleIsOn, label: {
//                                Text("DarkMode")
//                            })
                        
                            // volume doesnt seeem to do anything
//                            Stepper(onIncrement: {
//                                (settings.volume += 0.1)
//                            }, onDecrement: {
//                                (settings.volume -= 0.1)
//                            }){Text("Volume: \(settings.volume)")}
                        
                    //    }
                    //.listRowBackground(BackgroundGradient().opacity(0.8))
                        
                    }
                    
                }
                
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing:
            Button("Done") {
                print("done")
                presentationMode.wrappedValue.dismiss()
            })
        }.accentColor(Color.gradientStartRed.opacity(0.8))
        
    }
}

struct TabTwo_Previews: PreviewProvider {
    static var previews: some View {
        TabTwo()
            .preferredColorScheme(.light)
    }
}
struct TabTwo_Previews_dark: PreviewProvider {
    static var previews: some View {
        TabTwo()
            .preferredColorScheme(.dark)
    }
}
