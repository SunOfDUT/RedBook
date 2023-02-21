//
//  ConcernAccountDetial.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/20.
//

import SwiftUI
import Parse

struct ConcernAccountDetial: View {
    var otherclient : Client
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var pyqdata : PYQData
    @State var mypyq : [Carddata] = []
    @State var myStarpyq : [Carddata] = []
    @State var selcet = 0
    @State var scrollsize : CGFloat = 0
    @State var dragsize : CGFloat = 0
    @State var scrollsizeall : CGFloat = 0
    @Binding var showaccountdetial : Bool
    @State var loveint = 0
    @State var starInt = 0
    @State var isConcern : Bool = false
    @State var showLoveandStar : Bool = false
    
    
//    func Jugement(){
//        for i in Myclientdata.MyClient.concern{
//            if otherclient.username == i{
//                isConcern = true
//            }
//        }
//    }
    
    func GetMyPyq(){
        if mypyq.isEmpty{
            for i in pyqdata.allPyqData{
                if i.client.username == Myclientdata.MyClient.username{
                    self.mypyq.append(i)
                }
            }
        }
    }
    
//    func GetMyStar(){
//        if myStarpyq.count != Myclientdata.MyClient.star.count{
//            for i in Myclientdata.MyClient.star{
//                for item in pyqdata.allPyqData{
//                    if item.pyqobjectid == i{
//                        self.myStarpyq.append(item)
//                    }
//                }
//            }
//        }
//    }
    
    
    var body: some View {
        NavigationView{
        VStack{
            VStack{
               
                    VStack{
                        Color.clear.frame(height: 30)
                        VStack(alignment:.leading){
                            HStack{
                                PublicURLImageView(imageurl:otherclient.clientimage, contentmode: true)
                                    .mask(Circle())
                                    .frame(width: 65, height: 65)
                                    .padding(.top,5)
                                    .padding(.leading)
                                
                                VStack(alignment:.leading,spacing: 8){
                                    Text(otherclient.clientname)
                                        .font(.title)
                                        .foregroundColor(.white)
                                    Text("小红书号:\(otherclient.username)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            
                           
                                
                        
                            HStack{
                                Text(otherclient.introduce != "" ? otherclient.introduce:"ta还没有留下简介哦")
                                Image(systemName: "pencil")
                                Spacer()
                            }
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .padding(.bottom)
                            
                            HStack{
                             
                                Text("\(Getold(date:otherclient.brithday))")
                                    .foregroundColor(.white)
                                    .font(.footnote)
                                    .padding(.vertical,2)
                                    .padding(.horizontal,20)
                                    .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                
                                
                                    
                            
                                Text(otherclient.locate)
                                    .foregroundColor(.white)
                                    .font(.footnote)
                                    .padding(.vertical,2)
                                    .padding(.horizontal,20)
                                    .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                            
                            HStack(spacing:15){
                                VStack{
//                                    Text("\(otherclient.concern.count)")
                                    Text("关注")
                                        .font(.caption2)
                                }
                                VStack{
//                                    Text("\(otherclient.fans.count)")
                                    Text("粉丝")
                                        .font(.caption2)
                                }
                                
                                Button{
                                    withAnimation {
                                        showLoveandStar = true
                                    }
                                }label: {
                                    VStack{
                                        Text("\(loveint+starInt)")
                                        Text("点赞和收藏")
                                            .font(.caption2)
                                    }
                                }
                               
                                
                                Spacer()
                                
                                
                                if isConcern{
                                    Button{
                                        
                                    }label: {
                                        Text("发消息")
                                            .foregroundColor(.white)
                                            .padding(.vertical,2)
                                            .padding(.horizontal,20)
                                            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                    }
                                    
                                    Button{
                                        
                                    }label: {
                                        // 不再关注
                                        Image(systemName: "person.fill.checkmark")
                                            .foregroundColor(.white)
                                            .padding(.vertical,2)
                                            .padding(.horizontal,10)
                                            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                    }
                                    
                                }else{
                                    Button{
                                        
                                    }label: {
                                        Text("关注")
                                            .ButtonOfRed()
                                    }
                                    
                                    Button{
                                        
                                    }label: {
                                        Image(systemName: "mic")
                                            .foregroundColor(.white)
                                            .padding(.vertical,2)
                                            .padding(.horizontal,20)
                                            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        }
                    }
                    .padding(.top)
                
                VStack{
                    HStack(spacing:40){
                        Button{
                            selcet = 0
                        }label: {
                            Text("笔记")
                                .foregroundColor(selcet == 0 ? .black:.gray)
                        }
                        Button{
                            selcet = 1
                        }label: {
                            Text("收藏")
                                .foregroundColor(selcet == 1 ? .black:.gray)
                        }
                    }
                    .padding(.top,10)
                  
                    TabView(selection:$selcet){
                        BiJiView(mypyq: mypyq,dragsize: $dragsize,scrollsize:$scrollsize,scrollsizeall: $scrollsizeall)
                            .tag(0)

                        BiJiView(mypyq: myStarpyq,dragsize: $dragsize,scrollsize:$scrollsize,scrollsizeall: $scrollsizeall)
                            .tag(1)
                    }
                    .padding(.top,0)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(minHeight:UIScreen.main.bounds.height * 0.55 ,maxHeight: UIScreen.main.bounds.height)
                }
                .foregroundColor(.black)
                .background(.white,in: RoundedRectangle(cornerRadius:30))
                .offset(y:showaccountdetial ? 0:-50)
            }
            .coordinateSpace(name: "scroll")
            .overlay(
                VStack{
                    HStack{
                        Button{
                            withAnimation {
                                showaccountdetial = false
                            }
                        }label: {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 20))
                        }
                        Button{
                            
                        }label: {
                            Text("发消息")
                                .foregroundColor(.black)
                                .frame(width:80, height: 30)
                                .background(.white)
                                .padding(1)
                                .background(.gray.opacity(0.1),in: RoundedRectangle(cornerRadius: 10))
                        }
                        .opacity(0)
                        
                        Spacer()
                        
                        PublicURLImageView(imageurl: otherclient.clientimage, contentmode: true)
                            .mask(Circle())
                            .frame(width: 30, height: 30)
                            .offset(y:55)
                           .offset(y:dragsize)
                           .opacity(-dragsize)
                        
                        Spacer()
                        
                        Button{
                            
                        }label: {
                            Text("发消息")
                                .foregroundColor(.black)
                                .frame(width:80, height: 30)
                                .background(.white)
                                .padding(1)
                                .background(.gray.opacity(0.1),in: RoundedRectangle(cornerRadius: 10))
                        }
                      
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 20))
                        }
                    }
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .padding(.bottom,10)
                    .background(dragsize < 0  ? Color("black").opacity(-dragsize / 50):.clear)
                    Spacer()
                }
            )
        }
        .background(
            PublicURLImageView(imageurl: otherclient.clienbakground, contentmode: true)
                .clipped()
                .scaleEffect(scrollsize != 0 ? (scrollsize / 600 + 1):1)
                .offset(y:-300)
        )
        .frame(width: UIScreen.main.bounds.width)
        .navigationBarHidden(true)
        .onAppear {
//            GetMyInt()
//            Jugement()
//            GetMyPyq()
//            GetMyStar()
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
