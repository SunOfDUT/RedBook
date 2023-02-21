//
//  SearchView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/20.
//

import SwiftUI

struct SearchView: View {
    @State var searchtext : String = ""
    @Binding var showsearch : Bool
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    // search
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("周杰伦新歌", text: $searchtext)
                    }
                    .padding(5)
                    .background(.gray.opacity(0.2),in: RoundedRectangle(cornerRadius: 20))
                    
                    
                    Button{
                        withAnimation {
                           showsearch = false
                        }
                    }label: {
                        Text("取消")
                    }
                }
                .foregroundColor(.gray)
                .transition(.move(edge: .trailing))
                .animation(.linear, value: showsearch)
                
                ScrollView{
                    // 关键词
                    if searchtext == ""{
                        VStack{
                            VStack{
                                HStack{
                                    Text("历史记录")
                                        .font(.system(size: 18))
                                    Spacer()
                                    
                                    Image(systemName:"trash")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                
                                HStack{
                                    Text("周杰伦新歌")
                                        .ButtonStyleWhite()
                                    Text("SwiftUI")
                                        .ButtonStyleWhite()
                                    Spacer()
                                }
                                    
                            }
                            
                            
                            VStack(spacing:20){
                                HStack{
                                    Text("猜你想搜")
                                        .font(.system(size: 18))
                                    Spacer()
                                    
                                    HStack{
                                        Image(systemName: "arrow.clockwise")
                                            .font(.footnote)
                                        Text("换一换")
                                    }
                                    .foregroundColor(.gray)
                                }
                               
                               
                                HStack(spacing:50){
                                    VStack(alignment:.leading,spacing:15){
                                        Text("2022流行音乐")
                                        Text("游戏")
                                    }
                                    
                                    VStack(alignment:.leading,spacing:15){
                                        Text("个人陈述")
                                        Text("手机推荐")
                                    }
                                    Spacer()
                                }
                            }
                            .padding(.vertical)
                            
                            VStack{
                                HStack{
                                    Text("搜索发现")
                                        .foregroundColor(.orange)
                                        .font(.system(size: 18))
                                    Spacer()
                                }
                                
                                VStack(spacing:15){
                                    HStack{
                                        Circle()
                                            .frame(width: 5, height:5)
                                            .foregroundColor(.red)
                                        Text("周杰伦的新专辑预售称为历史第一")
                                        Spacer()
                                        Text("1020w")
                                        Text("—")
                                       
                                    }
                                    
                                    Divider()
                                    
                                    HStack{
                                        Circle()
                                            .frame(width: 5, height:5)
                                            .foregroundColor(.yellow)
                                        Text("周杰伦的新专辑预售称为历史第一")
                                        Spacer()
                                        Text("102.8w")
                                        Image(systemName: "arrow.up")
                                            .font(.footnote)
                                            .foregroundColor(.red)
                                    }
                                    
                                    Divider()
                                    HStack{
                                        Circle()
                                            .frame(width: 5, height:5)
                                            .foregroundColor(.yellow.opacity(0.5))
                                        Text("周杰伦的新专辑预售称为历史第一")
                                        Spacer()
                                        Text("102.8w")
                                        Image(systemName: "arrow.up")
                                            .font(.footnote)
                                            .foregroundColor(.red)
                                    }
                                    Divider()
                                     HStack{
                                         Circle()
                                             .frame(width: 5, height:5)
                                             .foregroundColor(.gray.opacity(0.5))
                                         Text("周杰伦的新专辑预售称为历史第一")
                                         Spacer()
                                         Text("102.8w")
                                         Image(systemName: "arrow.up")
                                             .font(.footnote)
                                             .foregroundColor(.red)
                                     }
                        
                                }
                            }
                        }
                    }else{
                        VStack{
                            ForEach(0..<19){ item in
                                NavigationLink{
                                    SearchDetial()
                                        .NavigationHidden()
                                }label: {
                                    HStack{
                                        Text("周杰伦")
                                        Spacer()
                                    }
                                    .foregroundColor(.black)
                                }
                                Divider()
                            }
                        }
                    }
                }
        }
            .padding(.horizontal,20)
            .background(.white)
            .navigationBarHidden(true)
        }
    }
}
