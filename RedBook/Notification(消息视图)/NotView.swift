//
//  NotView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/14.
//

import SwiftUI

struct NotView: View {
    @State var showMeun = false
    @State var IsActive = false
    @State var showMeunDetial1 = false
    @State var showMeunDetial2 = false
    @EnvironmentObject var mynotdata : NoticeData
    
    var body: some View {
        NavigationView{
            ZStack{
            VStack{
                Color.clear.frame(height: 30)
                HStack{
                    // 顶部
                    Button{

                    }label: {
                        Text("开启聊天")
                    }
                    .opacity(0)
                    
                    Spacer()
                    
                    Text("消息")
                        .font(.title3)
                    
                    Spacer()
                    
                    
                    Button{
                        withAnimation {
                            showMeun = true
                        }
                    }label: {
                        Text("开启聊天")
                    }
                }
                    .foregroundColor(.black)
                    .padding()
                ScrollView{
                  // 主题内容
                    HStack{// 喜欢 关注 评论
                    Spacer()
                    
                    NavigationLink{
                        LoveAndStar()
                            .NavigationHidden()
                    }label: {
                        VStack{
                            Image(systemName: "heart.fill")
                                .foregroundColor(.pink)
                                .font(.system(size: 23))
                                .padding(10)
                                .background(.pink.opacity(0.2),in: RoundedRectangle(cornerRadius: 10))
                            Text("赞和收藏")
                                .font(.system(size: 15))
                        }
                        .foregroundColor(.black)
                    }
                    
                    
                    Spacer()
                    
                    NavigationLink{
                        NewConcern()
                            .NavigationHidden()
                    }label: {
                        VStack{
                            Image(systemName: "person.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 23))
                                .padding(10)
                                .background(.blue.opacity(0.2),in: RoundedRectangle(cornerRadius: 10))
                            Text("新增关注")
                                .font(.system(size: 15))
                        }
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    NavigationLink{
                        CommentView()
                            .NavigationHidden()
                    }label: {
                        VStack{
                            Image(systemName: "ellipsis.bubble.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 23))
                                .padding(10)
                                .background(.green.opacity(0.2),in: RoundedRectangle(cornerRadius: 10))
                            Text("评论和@")
                                .font(.system(size: 15))
                        }
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                .padding()
                    
                    ForEach(0..<5){ item in
                        // 消息列表
                        NavigationLink{
                            ChatCardDetial()
                                .NavigationHidden()
                        }label: {
                            VStack{
                                HStack(alignment:.top){
                                    HStack{
                                        Image("image4")
                                            .CircleImage(width:62)
                                        
                                        VStack(alignment:.leading,spacing: 5){
                                            Text("周杰伦")
                                            Text("你好!交个朋友")
                                                .font(.footnote)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                   
                                    Spacer()
                                    
                                    Text("08-06")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                        .padding()
                                }
                            }
                            .foregroundColor(.black)
                        }
                        
                    }
          
                }
                
                Spacer()
               
                Tabbar()
            }
            .ignoresSafeArea(.all)
            .navigationBarHidden(true)
            
                if showMeun{
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                VStack{
                    Button{
                        withAnimation {
                            showMeun = false
                            showMeunDetial1 = true
                        }

                    }label: {
                        Label("发私信", systemImage: "plus.message")
                    }

                    Divider()
                        .padding(.horizontal,20)

                    NavigationLink(isActive:$IsActive){

                    }label:{
                        Label("创建群聊", systemImage: "person.2")
                    }
                }
                .foregroundColor(.black)
                .frame(width: showMeun ? UIScreen.main.bounds.width / 3:0, height: showMeun ? UIScreen.main.bounds.height / 9:0)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .scaleEffect(showMeun ? 1:0)
                .offset(x: showMeun ?  UIScreen.main.bounds.width / 2 - 90 :UIScreen.main.bounds.width / 2 - 80, y: showMeun ? -UIScreen.main.bounds.height / 3 - 10:-UIScreen.main.bounds.height / 3 - 70)
                .offset(x:10,y: -10)
                }
        }
        .onTapGesture {
            withAnimation {
                showMeun = false
            }
        }
        .onChange(of: IsActive, perform: { newvalue in
            showMeun = newvalue
        })
        .fullScreenCover(isPresented: $showMeunDetial1,content: {
            Private_Message()
        })
        }
    }
}

