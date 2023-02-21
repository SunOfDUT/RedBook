//
//  Concernviewdetial.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/19.
//

import SwiftUI

struct Concernviewdetial: View {
    @EnvironmentObject var Myclientdata  : ClientData
    @State var isScroll : Bool = false
    @State var imageSet = ["mic.fill","1","checkmark","T","camera"]
    @State var textset = ["语音","日签","打卡","文字","拍摄"]
    @State var colorset : [Color] = [.orange,.green,.teal,.pink,.purple]
    @Binding var showConcernviewdetial : Bool
    var body: some View {
        VStack{
            HStack{
                PublicURLImageView(imageurl: Myclientdata.MyClient.clientimage, contentmode: true)
                    .mask(Circle())
                    .frame(width: 50, height:50)

                
                VStack(alignment:.leading){
                    Text("记录我的日常")
                    Text("暂未开始记录")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button{
                    withAnimation {
                        showConcernviewdetial = false
                    }
                }label:{
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
//            if isScroll{
//                HStack{
//                    ForEach(0..<imageSet.count){ item in
//                        VStack{
//                            if item != 1 && item != 3{
//                                Image(systemName:imageSet[item])
//                                    .frame(width: UIScreen.main.bounds.width / 5 - 13, height: UIScreen.main.bounds.width / 5 - 13)
//                                    .background(.linearGradient(colors: [colorset[item],.white], startPoint: .topLeading, endPoint: .bottomTrailing),in: RoundedRectangle(cornerRadius: 10))
//                            }else{
//                                Text(imageSet[item])
//                                    .frame(width: UIScreen.main.bounds.width / 5 - 13, height: UIScreen.main.bounds.width / 5 - 13)
//                                    .background(.linearGradient(colors: [colorset[item],.white], startPoint: .topLeading, endPoint: .bottomTrailing),in: RoundedRectangle(cornerRadius: 10))
//                            }
//
//                            Text(textset[item])
//                        }
//                    }
//                }
//                .frame(width: UIScreen.main.bounds.width)
//            }
//            else{
//            VStack(alignment:.leading){
//            HStack{
//                ForEach(0..<2){ item in
//                    HStack{
//                        VStack{
//                            Text(textset[item])
//                                .font(.title2)
//                                .padding()
//                            Spacer()
//                        }
//
//                        Spacer()
//
//                        VStack{
//                            Spacer()
//                            if item == 0{
//                                Image(systemName:imageSet[item])
//                                    .font(.system(size: 30))
//                                    .foregroundColor(.orange)
//                                    .frame(width: 50, height: 50)
//                                    .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 15))
//                                    .padding()
//                                    .rotationEffect(Angle(degrees: -45))
//                            }else{
//                                Text(imageSet[item])
//                                    .font(.system(size: 30))
//                                    .foregroundColor(.green)
//                                    .frame(width: 50, height: 50)
//                                    .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 15))
//                                    .padding()
//                                    .rotationEffect(Angle(degrees: -45))
//                            }
//
//
//                        }
//
//                    }
//                    .frame(height: 100)
//                    .background(.linearGradient(colors: [colorset[item],.white], startPoint: .topLeading, endPoint: .bottomTrailing),in: RoundedRectangle(cornerRadius: 10))
//                }
//            }
//
//            HStack{
//                ForEach(2..<imageSet.count){ item in
//                    HStack{
//                        VStack{
//                            Text(textset[item])
//                                .font(.title3)
//                                .padding(5)
//                                .offset(x: 5, y: 5)
//                            Spacer()
//                        }
//
//                        Spacer()
//
//                        VStack{
//                            Spacer()
//                            if item != 3{
//                                Image(systemName:imageSet[item])
//                                    .font(.system(size: 20))
//                                    .foregroundColor(colorset[item])
//                                    .frame(width: 40, height: 40)
//                                    .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 15))
//                                    .padding()
//                                    .rotationEffect(Angle(degrees: -45))
//                            }else{
//                                Text(imageSet[item])
//                                    .font(.system(size: 20))
//                                    .foregroundColor(colorset[item])
//                                    .frame(width: 40, height: 40)
//                                    .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 15))
//                                    .padding()
//                                    .rotationEffect(Angle(degrees: -45))
//                            }
//                        }
//
//                    }
//                    .frame(height: 120)
//                    .background(.linearGradient(colors: [colorset[item],.white], startPoint: .topLeading, endPoint: .bottomTrailing),in: RoundedRectangle(cornerRadius: 10))
//                }
//            }
//            }
//                .padding(.horizontal,5)
//            }
            
//            ScrollView{
//                ScorllRead
//                VStack{
//                    VStack(spacing:0){
//                        HStack{
//                            Text("打卡日常")
//                            Spacer()
//                        }
//
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack{
//                                ForEach(0..<6){ item in
//                                    ZStack{
//                                        Image("image4")
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .mask(RoundedRectangle(cornerRadius: 10))
//                                            .frame(width: 150, height: 250)
//                                            .clipped()
//
//                                        VStack(spacing:0){
//                                            Spacer()
//                                            PublicURLImageView(imageurl: Myclientdata.MyClient.clientimage, contentmode: true)
//                                                .mask(Circle())
//                                                .frame(width: 40, height:40)
//                                            Text(Myclientdata.MyClient.clientname)
//                                        }
//                                        .padding(.bottom,40)
//                                    }
//                                }
//                            }
//                        }
//                    }
//
//
//
//                    VStack(spacing:0){
//                        HStack{
//                            Text("有趣瞬间")
//                            Spacer()
//
//                        }
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack{
//                                ForEach(0..<6){ item in
//                                    ZStack{
//                                        Image("image4")
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .mask(RoundedRectangle(cornerRadius: 10))
//                                            .frame(width: 150, height: 250)
//                                            .clipped()
//
//                                        VStack(spacing:0){
//                                            Spacer()
//                                            PublicURLImageView(imageurl: Myclientdata.MyClient.clientimage, contentmode: true)
//                                                .mask(Circle())
//                                                .frame(width: 40, height:40)
//                                            Text(Myclientdata.MyClient.clientname)
//                                        }
//                                        .padding(.bottom,40)
//                                    }
//                                }
//                            }
//                        }
//                    }
//
//                    VStack(spacing:0){
//                        HStack{
//                            Text("心情日签")
//                            Spacer()
//                        }
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack{
//                                ForEach(0..<6){ item in
//                                    ZStack{
//                                        Image("image4")
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .mask(RoundedRectangle(cornerRadius: 10))
//                                            .frame(width: 150, height: 250)
//                                            .clipped()
//
//                                        VStack(spacing:0){
//                                            Spacer()
//                                            PublicURLImageView(imageurl: Myclientdata.MyClient.clientimage, contentmode: true)
//                                                .mask(Circle())
//                                                .frame(width: 40, height:40)
//                                            Text(Myclientdata.MyClient.clientname)
//                                        }
//                                        .padding(.bottom,40)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    VStack(spacing:0){
//                        HStack{
//                            Text("文字记录")
//                            Spacer()
//                        }
//
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack{
//                                ForEach(0..<6){ item in
//                                    ZStack{
//                                        Image("image4")
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .mask(RoundedRectangle(cornerRadius: 10))
//                                            .frame(width: 150, height: 250)
//                                            .clipped()
//
//                                        VStack(spacing:0){
//                                            Spacer()
//                                            PublicURLImageView(imageurl: Myclientdata.MyClient.clientimage, contentmode: true)
//                                                .mask(Circle())
//                                                .frame(width: 40, height:40)
//                                            Text(Myclientdata.MyClient.clientname)
//                                        }
//                                        .padding(.bottom,40)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//                .padding()
//            }
//            .coordinateSpace(name: "scroll")
            
        }
        .padding(20)
        .foregroundColor(.white)
        .background(.black)
        .safeAreaInset(edge: .top) {
            Color.clear.frame(height:30)
        }
    }
    
    var ScorllRead : some View{
        GeometryReader{ proxy in
            Color.clear
                .preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
//
//            Text("\(proxy.frame(in: .named("scroll")).minY)")
//                .foregroundColor(.white)
        }
        .frame(width: 10, height:0)
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            if value < 0{
                withAnimation {
                    isScroll = true
                }
            }else if value > 0{
                withAnimation {
                    isScroll = false
                }
            }
        }
    }
}

struct ScrollPreferenceKey : PreferenceKey{
    static var defaultValue : CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct Concernviewdetial_Previews: PreviewProvider {
    static var previews: some View {
        Concernviewdetial(showConcernviewdetial:.constant(false))
    }
}
