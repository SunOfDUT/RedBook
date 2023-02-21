//
//  MusicView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/12.
//

import SwiftUI

struct MusicView: View {
    var body: some View {
        NavigationView{
            VStack{
            Color.clear.frame(height: 30)
            Text("hh")
            Spacer()
            Tabbar()
            }
            .ignoresSafeArea()
        }
        .navigationBarHidden(true)
    }
}

struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView()
    }
}
