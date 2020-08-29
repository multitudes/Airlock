//
//  SwiftUIView.swift
//  Airlock
//
//  Created by Laurent B on 29/08/2020.
//

import SwiftUI

struct VolumeSettingView: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        Text("Volume: \(settings.volume)")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeSettingView()
    }
}
