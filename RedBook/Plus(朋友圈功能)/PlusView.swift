//
//  PlusView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/9.
//

import SwiftUI
import Photos
struct PlusView: View {
    @State var select2 = 2
    @Binding var  showplusview : Bool
    var body: some View {
            VStack{
                TabView(selection:$select2){
                   Text("直播")
                        .tag(0)
                   ForMatView(showplusview: $showplusview)
                         .tag(1)
                
                    RealImagePicker(showplusview: $showplusview)
                        .tag(2)
                    
                   Text("拍视频")
                         .tag(3)
                    CameraView(showplusview: $showplusview)
                         .tag(4)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                HStack(spacing:UIScreen.main.bounds.width / 12){
                    Button{
                        select2 = 0
                    }label: {
                        Text("直播")
                    }
                    .foregroundColor(select2 == 0 ? .white:.gray)
                    Button{
                        select2 = 1
                    }label: {
                        Text("模版")
                    }
                    .foregroundColor(select2 == 1 ? .white:.gray)
                    Button{
                        select2 = 2
                    }label: {
                        Text("相册")
                    }
                    .foregroundColor(select2 == 2 ? .white:.gray)
                    
                    Button{
                        select2 = 3
                    }label: {
                        Text("拍视频")
                    }
                    .foregroundColor(select2 == 3 ? .white:.gray)
                    Button{
                        select2 = 4
                    }label: {
                        Text("拍照")
                    }
                    .foregroundColor(select2 == 4 ? .white:.gray)
                }
                .font(.system(size: 17))
        }
        .foregroundColor(.white)
        .background(.black)
    }
}
