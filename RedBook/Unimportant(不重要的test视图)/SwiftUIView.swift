//
//  SwiftUIView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/15.
//

import SwiftUI

struct SwiftUIView: View {
    @Namespace var namespace
    @State var pinlun = ""
    @State var isshowdetial  :  Bool = false
    @State var isshowdetial2  :  Bool = false
    var body: some View {
        VStack{
            if isshowdetial{
                // carddetial
                VStack{
                    if isshowdetial2{
                        HStack{
                            HStack{
                                Button{
                                    withAnimation(.spring(response: 0.7, dampingFraction:0.8)){
                                        isshowdetial.toggle()
                                    }
                                    withAnimation(.spring(response: 1.4, dampingFraction:0.8)){
                                        isshowdetial2.toggle()
                                    }
                                }label: {
                                    Image(systemName: "chevron.backward")
                                        .font(.system(size: 25))
                                }
                                
                                Image("image4")
                                    .CircleImage(width: 60)
                                Text("username")
                                Spacer()
                                
                                HStack(spacing:15){
                                    Button{
                                        
                                    }label: {
                                        Text("关注")
                                            .foregroundColor(Color("red"))
                                            .padding(.vertical,5)
                                            .padding(.horizontal,18)
                                            .background(.white)
                                            .padding(1)
                                            .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
                                    }
                                    
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 25))
                                }
                            }
                            
                    }
                    }
                    
                    ScrollView{
                        TabView{
                            Image("image1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .tag(0)
                            Image("image2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .tag(1)
                            Image("image1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .tag(2)
                        }
                        .tabViewStyle(.page)
                        .frame(height:500)
                        .matchedGeometryEffect(id: "image", in: namespace)
                        
                        VStack(spacing:20){
                            HStack{
                                Text("今天天气很棒")
                                    .matchedGeometryEffect(id: "text", in: namespace)
                                Spacer()
                            }
                            
                            HStack{
                                Text("07-05 广东")
                                Spacer()
                                
                                
                                Button{
                                    
                                }label: {
                                    HStack{
                                        Image(systemName: "face.smiling")
                                        Text("不喜欢")
                                    }
                                    .padding(3)
                                    .background(.white)
                                    .padding(1)
                                    .background(.gray,in: RoundedRectangle(cornerRadius: 20))
                                }
                            }
                            .foregroundColor(.gray)
                        }
                            .padding(.horizontal)
                        
                        Divider()
                        
                        if isshowdetial2{
                        HStack{
                            Text("共123条评论")
                            Spacer()
                        }
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                        HStack{
                            Image("image4")
                                .CircleImage(width: 40)
                            
                            TextField("喜欢就给个评论支持一下", text: $pinlun)
                                .padding(.vertical,6)
                                .padding(.horizontal,10)
                                .background(.gray.opacity(0.1),in: RoundedRectangle(cornerRadius: 20))
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        
                        VStack{
                            ForEach(0..<10){ item in
                                VStack{
                                    HStack(spacing:20){
                                        Image("image4")
                                            .CircleImage(width: 40)
                                        
                                        VStack(alignment:.leading){
                                            Text("497vv")
                                                .foregroundColor(.gray)
                                            Text("喜欢就给个评论支持一下")
                                        }
                                        Spacer()
                                        
                                        VStack{
                                            Image(systemName: "heart")
                                            Text("12")
                                        }
                                        .foregroundColor(.gray)
                                        
                                    }
                                    .padding(.horizontal)
                                    Divider()
                                        .padding(.leading,70)
                                }
                            }
                        }
                       
                       
                        }
                    }
                    
                    if isshowdetial2{
                        HStack{
                            TextField("说点什么..", text: $pinlun)
                                .padding(.horizontal,10)
                                .padding(.vertical,6)
                                .frame(width:UIScreen.main.bounds.width * 0.4 - 10)
                                .background(.gray.opacity(0.2),in: RoundedRectangle(cornerRadius: 20))
                           
                            
                            HStack(spacing:10){
                                
                                
                                HStack(spacing:0){
                                    Button{
                                        
                                    }label: {
                                        Image(systemName: "heart")
                                            .font(.system(size: 18))
                                    }
                                   
                                    Text("123")
                                }
                                
                                HStack(spacing:0){
                                    Button{
                                        
                                    }label: {
                                        Image(systemName: "star")
                                            .font(.system(size: 18))
                                    }
                                   
                                    Text("888")
                                }
                              
                                
                                HStack(spacing:0){
                                    Button{
                                        
                                    }label: {
                                        Image(systemName: "ellipsis.bubble")
                                            .font(.system(size: 18))
                                    }
                                    
                                    Text("123")
                                }
                            }
                            .foregroundColor(.black)
                            .frame(width:UIScreen.main.bounds.width * 0.6 - 10)
                        }// tabbar
                            .padding(.horizontal)
                    }
                }
                .background(
                    Color.white.matchedGeometryEffect(id: "background", in: namespace)
                )
                .padding()
            }else{
               // card
                VStack(alignment:.leading,spacing: 5){
                    Image("image1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "image", in: namespace)
                       
                    HStack{
                        Text("今天天气很棒")
                            .matchedGeometryEffect(id: "text", in: namespace)
                        Spacer()
                    }
                    
                    
                    HStack{
                        Image("image4")
                            .CircleImage(width: 50)
                        Spacer()
                        
                        Image(systemName: "heart")
                        Text("123")
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 2)
                .background(
                    Color.white.matchedGeometryEffect(id: "background", in: namespace)
                )
                .mask(
                    RoundedRectangle(cornerRadius: 10)
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.7, dampingFraction:0.8)){
                        isshowdetial.toggle()
                    }
                    withAnimation(.spring(response: 1.4, dampingFraction:0.8)){
                        isshowdetial2.toggle()
                    }
                }
            }
        }
       
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
