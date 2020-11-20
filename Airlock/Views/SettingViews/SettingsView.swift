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

struct ActivityViewController: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    var activityItems: [Any] = [URL(string: "https://www.apple.com")!]
    var applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
    
}

struct SettingsView: View {
	@AppStorage("vibrateIsOn") var vibrateIsOn: Bool = false
    @Environment(\.presentationMode) var presentationMode

	@State var toggleIsOn: Bool = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State private var isRecommendAppPresented: Bool = false
    @State var alertNoMail = false

	let myAppStoreURL = "https://apps.apple.com/us/app/two-minutes-meditation/id1530067435"

	var isPhone: Bool {
		UIDevice.current.userInterfaceIdiom == .phone
    }

	init(){
        UITableView.appearance().backgroundColor = .clear
        //    print(Device.name)
        //  print(Device.osVersion)
    }
    
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
                            }.sheet(isPresented: $isRecommendAppPresented) {
                                ActivityViewController(activityItems: [URL(string: myAppStoreURL)!])
                            }
                        })
                        
                        
                        Link(destination: URL(string: "https://testflight.apple.com/join/rfPbYjXH")!) {
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
                            .sheet(isPresented: $isShowingMailView) {
                                MailView(result: self.$result)
                            }
                            .alert(isPresented: self.$alertNoMail) {
                                Alert(title: Text("Please set up your email account on your Apple device to send a feedback"))
                            }
                            
                        }
                        
                        
                        NavigationLink(destination: PrivacyView()) {
                            HStack {
                                Image(systemName: "doc.text.magnifyingglass").padding(5)
                                Text("Privacy")
                            }
                        }
                    }.listRowBackground(BackgroundGradient().opacity(0.2))
                    
                    if isPhone {
                        Section(header: Text("Settings"), footer: Text("© Laurent Brusa v1.0 2020").bold())
                        {
                            
                            Toggle(isOn: $vibrateIsOn, label: {
                                HStack {
                                    Image(systemName: "speaker.slash").padding(5)
                                    Text("Vibrate Only")
                                }
                            })
                        }
                        .listRowBackground(BackgroundGradient().opacity(0.2))
                    }
                }.font(.body)
                
            }
            .navigationBarTitle("Settings").accentColor(.primary)
            .foregroundColor(.primary)
            .navigationBarItems(trailing:
                                    Button("Done") {
                                        presentationMode.wrappedValue.dismiss()
                                    }.accentColor(.primary)
                                    .foregroundColor(.primary)
            )
            
        }.accentColor(.primary)
        .foregroundColor(.primary)
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