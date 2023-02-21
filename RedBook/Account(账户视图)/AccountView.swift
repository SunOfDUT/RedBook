//
//  AccountView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/14.
//

import SwiftUI
import Parse

func Getold(date:Date)->Int{
    let distance = date.distance(to: Date()) // 秒
    // 一分钟 60s  一小时 60分钟  一天 24小时  一年 365天 一年31536000秒
    let year = Int(distance) / (31536000)
    return year
}

struct AccountView: View {
    @State var selcet = 0
    @State var scrollsize : CGFloat = 0
    @State var dragsize : CGFloat = 0
    @State var scrollsizeall : CGFloat = 0
    @State var showSet = false
    @State var showShare = false
    @State var showLoveandStar = false
    @State var showanimation : [Bool] = [false,false,false,false,false,false]
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var pyqdata : PYQData
    @State var mypyq : [Carddata] = []
    @State var loveint : Int = 0
    @State var starInt : Int = 0
    @EnvironmentObject var mynotdata : NoticeData
    
    func GetMyPyq(){
        if mypyq.isEmpty{
            for i in pyqdata.allPyqData{
                if i.client.username == Myclientdata.MyClient.username{
                    self.mypyq.append(i)
                }
            }
        }
    }
    
    
    func GetLoveAndStarInt(){
        self.loveint = 0
        self.starInt = 0
        for i in mynotdata.MyLoveAndStar{
            if i.islove{
                self.loveint += 1
            }else{
                self.starInt += 1
            }
        }
    }
    
    var body: some View {
    NavigationView{
            VStack{
                VStack{
                    Color.clear.frame(height: 30)
                    VStack{
                            VStack{
                                HStack{
                                    PublicURLImageView(imageurl: Myclientdata.MyClient.clientimage, contentmode: true)
                                    .mask(Circle())
                                    .frame(width: 65, height: 65)
                                    .padding(.top,5)
                                    .padding(.leading)
                                    
                                       
                                    VStack(alignment:.leading,spacing: 8){
                                        Text(Myclientdata.MyClient.clientname)
                                            .font(.title)
                                            .foregroundColor(.white)
                                        HStack{
                                            Text("小红书号:")
                                            Text(Myclientdata.MyClient.username)
                                        }
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                                .padding(.top,20)
                                
                                NavigationLink{
                                    ClientDetialView()
                                        .NavigationHidden()
                                }label: {
                                    if Myclientdata.MyClient.introduce == ""{
                                        HStack{
                                            Text("向大家介绍自己")
                                            Image(systemName: "pencil")
                                            Spacer()
                                        }
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                        .padding(.horizontal)
                                    }else{
                                        HStack{
                                            Text(Myclientdata.MyClient.introduce)
                                            Image(systemName: "pencil")
                                            Spacer()
                                        }
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                        .padding(.horizontal)
                                    }
                                   
                                }
                                .padding(.bottom)
                                HStack{
                                    NavigationLink{
                                        ClientDetialView()
                                            .NavigationHidden()
                                    }label: {
                                        Text("\(Getold(date:Myclientdata.MyClient.brithday))岁")
                                            .foregroundColor(.white)
                                            .font(.footnote)
                                            .padding(.vertical,2)
                                            .padding(.horizontal,20)
                                            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                    }
                                    
                                        
                                    NavigationLink{
                                        ClientDetialView()
                                            .NavigationHidden()
                                    }label: {
                                        if Myclientdata.MyClient.locate == ""{
                                            Text("+添加地区，职业标签")
                                                .foregroundColor(.white)
                                                .font(.footnote)
                                                .padding(.vertical,2)
                                                .padding(.horizontal,20)
                                                .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                        }else{
                                            Text(Myclientdata.MyClient.locate)
                                                .foregroundColor(.white)
                                                .font(.footnote)
                                                .padding(.vertical,2)
                                                .padding(.horizontal,20)
                                                .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                        }
                                        
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                                
                                HStack(spacing:15){
                                    NavigationLink{
                                        ConcernAndLove(select: 0)
                                            .NavigationHidden()
                                    }label: {
                                        VStack{
                                            Text("\(mynotdata.Myconcern.count)")
                                            Text("关注")
                                                .font(.caption2)
                                        }
                                    }
                                    
                                    NavigationLink{
                                        ConcernAndLove(select: 1)
                                            .NavigationHidden()
                                    }label: {
                                        VStack{
                                            Text("\(mynotdata.MyFans.count)")
                                            Text("粉丝")
                                                .font(.caption2)
                                        }
                                    }
                                    
                                    Button{
                                        withAnimation {
                                            showLoveandStar = true
                                        }
                                    }label: {
                                        VStack{
                                            Text("\(mynotdata.MyLoveAndStar.count)")
                                            Text("点赞和收藏")
                                                .font(.caption2)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    NavigationLink{
                                        ClientDetialView()
                                            .NavigationHidden()
                                    }label: {
                                        Text("编辑资料")
                                            .foregroundColor(.white)
                                            .padding(.vertical,2)
                                            .padding(.horizontal,20)
                                            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                    }
                                   
                                    
                                    NavigationLink{
                                        AccountSet2()
                                            .NavigationHidden()
                                    }label:{
                                        Image(systemName: "gearshape")
                                            .foregroundColor(.white)
                                            .padding(.vertical,2)
                                            .padding(.horizontal,20)
                                            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                    }
                                   
                                }
                                .padding(.horizontal)
                                .foregroundColor(.white)
                            }
                        }
                        .padding(.top)
                }
//                .offset(y:scrollsizeall)
                    
                
                VStack{
                    HStack(spacing:40){
                        Button{
                            withAnimation {
                                selcet = 0
                            }
                        }label: {
                            Text("笔记")
                                .foregroundColor(selcet == 0 ? .black:.gray)
                        }
                        Button{
                            withAnimation {
                                selcet = 1
                            }
                        }label: {
                            Text("收藏")
                                .foregroundColor(selcet == 1 ? .black:.gray)
                        }
                        Button{
                            withAnimation {
                                selcet = 2
                            }
                        }label: {
                            Text("赞过")
                                .foregroundColor(selcet == 2 ? .black:.gray)
                        }
                    }
                    .padding(.top,10)
                    .padding(.bottom,5)
                    .overlay(
                        HStack(spacing:40){
                            if selcet == 2{
                                Spacer()
                            }
                            
                            VStack{
                                Spacer()
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 30, height: 3)
                                    .foregroundColor(Color("red"))
                            }
                            
                            if selcet == 0{
                                Spacer()
                            }
                        }
                        .padding(.horizontal,3)
                    )
                   
                    
                    TabView(selection:$selcet){
                        BiJiView(mypyq: mypyq,dragsize: $dragsize,scrollsize:$scrollsize,scrollsizeall: $scrollsizeall)
                            .tag(0)

                        BiJiView(mypyq: mynotdata.starMyself,dragsize: $dragsize,scrollsize:$scrollsize,scrollsizeall: $scrollsizeall)
                            .tag(1)

                        BiJiView(mypyq: mynotdata.LoveMyself,dragsize: $dragsize,scrollsize:$scrollsize,scrollsizeall: $scrollsizeall)
                            .tag(2)
                    }
                    .padding(.top,0)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(minHeight:UIScreen.main.bounds.height * 0.55 ,maxHeight: UIScreen.main.bounds.height)
                }
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width)
                .background(.white,in: RoundedRectangle(cornerRadius:30))
//               .offset(y:scrollsizeall)
                .coordinateSpace(name: "scroll")
                
                Tabbar()
            }
            .overlay(
                VStack{
                    HStack{
                        Button{
                            withAnimation {
                                showSet = true
                            }
                        }label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 20))
                        }

                        Spacer()
                        
                        PublicURLImageView(imageurl: Myclientdata.MyClient.clientimage, contentmode: true)
                            .mask(Circle())
                            .frame(width: 30, height: 30)
                            .offset(y:55)
                           .offset(y:dragsize)
                           .opacity(-dragsize)
                        
                        Spacer()
                        Button{
                            withAnimation {
                                showShare = true
                            }
                            withAnimation(.spring(response: 0.2, dampingFraction: 0.8)){
                                showanimation[0] = true
                            }
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)){
                                showanimation[1] = true
                            }
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                                showanimation[2] = true
                            }
                            withAnimation(.spring(response: 0.8, dampingFraction: 0.8)){
                                showanimation[3] = true
                            }
                            withAnimation(.spring(response: 1.0, dampingFraction: 0.8)){
                                showanimation[4] = true
                            }
                            withAnimation(.spring(response: 1.2, dampingFraction: 0.8)){
                                showanimation[5] = true
                            }
                            print(showanimation)
                        }label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 20))
                        }
                    }
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .padding(.top,40)
                    .padding(.bottom,10)
                    .background(dragsize < 0  ? Color("black").opacity(-dragsize / 50):.clear)
                    Spacer()
                }
            )
            .onAppear(perform: {
                GetMyPyq()
                GetLoveAndStarInt()
            })
            .background(
                PublicURLImageView(imageurl: Myclientdata.MyClient.clienbakground, contentmode: true)
                    .clipped()
                    .offset(y:-300)
            )
            .navigationBarHidden(true)
            .DragOfLeftSheetView(isPresented: $showSet) {
                AccountSet()
            }
            .SheetBottomView(isPresented: $showShare,onDismiss: {
                withAnimation(.spring(response: 0.2, dampingFraction: 0.8)){
                    showanimation[0] = false
                }
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)){
                    showanimation[1] = false
                }
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                    showanimation[2] = false
                }
                withAnimation(.spring(response: 0.8, dampingFraction: 0.8)){
                    showanimation[3] = false
                }
                withAnimation(.spring(response: 1.0, dampingFraction: 0.8)){
                    showanimation[4] = false
                }
                withAnimation(.spring(response: 1.2, dampingFraction: 0.8)){
                    showanimation[5] = false
                }
            }){
                ShareView(showShare: $showShare, showanimation: $showanimation)
            }
            .SheetCenterView(isPresented: $showLoveandStar) {
                VStack{
                    Text("获赞与收藏")
                        .font(.title3)
                        .bold()
                        .padding(.bottom)
                    
                    Divider()
                    
                    VStack(spacing:18){
                        HStack(spacing:12){
                            Image(systemName: "square.text.square.fill")
                                .foregroundColor(.white)
                                .padding(3)
                                .background(.blue,in:Circle())
                            Text("当前发布笔记数")
                                .foregroundColor(.gray)
                            Text("\(mypyq.count)")
                        }
                        
                        HStack(spacing:12){
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                                .padding(3)
                                .background(Color("red"),in:Circle())
                            Text("当前获得点赞数")
                                .foregroundColor(.gray)
                            Text("\(loveint)")
                        }
                        
                        HStack(spacing:12){
                            Image(systemName: "star.fill")
                                .foregroundColor(.white)
                                .padding(3)
                                .background(.yellow,in:Circle())
                            Text("当前获得收藏数")
                                .foregroundColor(.gray)
                            Text("\(starInt)")
                        }
                    }
                    .padding(.horizontal,15)
                    .padding(.vertical)
                    Button{
                        withAnimation {
                            self.showLoveandStar = false
                        }
                    }label: {
                        Text("我知道了")
                            .foregroundColor(.white)
                            .frame(width: 140, height: 40)
                            .background(Color("red"),in:RoundedRectangle(cornerRadius: 20))
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 2 + 30,height: UIScreen.main.bounds.height / 3 - 20 )
                .background(.white,in:RoundedRectangle(cornerRadius: 10))
            }
    }
}
}


//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView()
//            .environmentObject(Model(FromOutAllTags: initAllTags()))
//            .environmentObject(ClientData(FromOutMyClient: initMyClientData()))
//    }
//}
