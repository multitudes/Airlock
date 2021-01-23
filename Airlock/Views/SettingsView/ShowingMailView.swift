//
//  ShowingMailView.swift
//  Airlock
//
//  Created by Laurent B on 23/01/2021.
//

import MessageUI
import SwiftUI

struct ShowingMailView: View {
	@State var isShowingMailView = false
	@State var result: Result<MFMailComposeResult, Error>? = nil
	@State var alertNoMail = false

    var body: some View {
					Button(action: {
						isShowingMailView = true
					}) {
						Label("Send Feedback", systemImage: "bubble.left")
							.onTapGesture {
								MFMailComposeViewController.canSendMail() ? self.isShowingMailView.toggle() : self.alertNoMail.toggle()
							}
							.sheet(isPresented: $isShowingMailView) {
								MailView(result: self.$result)
							}
							.alert(isPresented: self.$alertNoMail) {
								Alert(title: Text("Please set up your email account on your Apple device to send a feedback"))
							}
					}
    }
}

struct ShowingMailView_Previews: PreviewProvider {
    static var previews: some View {
        ShowingMailView()
    }
}
