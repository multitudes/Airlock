//
//  SettingsView.swift
//  Airlock
//
//  Created by Laurent B on 28/08/2020.
//

import UIKit
import SwiftUI
import AVFoundation
import MessageUI

struct Device {
    
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

struct ActivityViewController: UIViewControllerRepresentable {
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
    
}

struct SettingsView: View {
    
    @EnvironmentObject var settings: UserSettings
    @Environment(\.presentationMode) var presentationMode
    @State var toggleIsOn: Bool = false
    @State var vibrateIsOn: Bool = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var alertNoMail = false
    
    var isPhone: Bool {
        Device.name.contains("iPhone")
    }
    init(){
        UITableView.appearance().backgroundColor = .clear
        //    print(Device.name)
        //  print(Device.osVersion)
    }
    
    @State private var isRecommendAppPresented: Bool = false
    
    
    
    var body: some View {
        NavigationView {
            ZStack{
                BackgroundGradient().opacity(0.2)
                Form {
                    Section(header: Text("General"), footer: isPhone ? Text("") : Text("©Laurent Brusa v1.0 2020")
                    ) {
                        NavigationLink(destination: AboutThisApp()) {
                            HStack {
                                Image(systemName: "info.circle").padding(5)
                                Text("About This App")
                            }
                        }
                        
                        Button(action: {
                            self.isRecommendAppPresented = true
                        }, label: {
                            HStack {
                                Image(systemName: "hand.thumbsup").padding(5)
                                Text("Recommend App")
                            }.sheet(isPresented: $isRecommendAppPresented, onDismiss: {
                                print("Dismiss")
                            }, content: {
                                ActivityViewController(activityItems: [URL(string: "https://www.apple.com")!])
                            })
                        })
                        
                        
                        Link(destination: URL(string: "https://www.apple.com/")!) {
                            HStack {
                                Image(systemName: "star").padding(5)
                                Text("Rate App")
                            }
                        }
                        
                        
                        Button(action: {
                            isShowingMailView = true
                        }) {
                            HStack {
                                Image(systemName: "bubble.left").padding(5)
                                Text("Feedback")
                            }.onTapGesture {
                                MFMailComposeViewController.canSendMail() ? self.isShowingMailView.toggle() : self.alertNoMail.toggle()
                            }
                            //            .disabled(!MFMailComposeViewController.canSendMail())
                            .sheet(isPresented: $isShowingMailView) {
                                MailView(result: self.$result)
                            }
                            .alert(isPresented: self.$alertNoMail) {
                                Alert(title: Text("Please set up your email account on your Apple device to send a feedback"))
                            }
                            MailView(result: self.$result)
                            }
                            
                            NavigationLink(destination: AboutThisApp()) {
                                HStack {
                                    Image(systemName: "doc.text.magnifyingglass").padding(5)
                                    Text("Privacy")
                                }
                            }
                        }.listRowBackground(BackgroundGradient().opacity(0.8))
                        
                        if isPhone{
                            Section(header: Text("Settings"), footer: Text("©Laurent Brusa v1.0 2020").bold())
                            {
                                
                                Toggle(isOn: $settings.vibrate, label: {
                                    HStack {
                                        Image(systemName: "speaker.slash").padding(5)
                                        Text("Vibrate Only")
                                    }
                                })
                            }
                            .listRowBackground(BackgroundGradient().opacity(0.8))
                        }
                    }
                    
                }
                .navigationBarTitle("Settings")
                .navigationBarItems(trailing:
                                        Button("Done") {
                                            presentationMode.wrappedValue.dismiss()
                                        }.foregroundColor(Color.gradientStartRed.opacity(0.8))
                )
                
            }.accentColor(Color.gradientStartRed.opacity(0.8))
        }
    }
    
    
    struct TabTwo_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
                .preferredColorScheme(.light)
        }
    }
    struct TabTwo_Previews_dark: PreviewProvider {
        static var previews: some View {
            SettingsView()
                .preferredColorScheme(.dark)
        }
    }
