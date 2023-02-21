//
//  ShareView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/20.
//

import SwiftUI

struct ShareView: View {
    @Binding var showShare : Bool
    @Binding var showanimation : [Bool]
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "xmark")
                    .opacity(0)
                Spacer()
                Text("分享至")
                Spacer()
                Button{
                    withAnimation {
                        showShare = false
                    }
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
                }label: {
                    Image(systemName: "xmark")
                       
                }
            }
            .foregroundColor(.gray)
            
            HStack{
                
                Button{
                    
                }label: {
                    VStack(spacing:0){
                        Image("image1")
                            .CircleImage(width: 60)
                        Text("username1")
                    }
                }
                
                Button{
                    
                }label: {
                VStack(spacing:0){
                    Image("image2")
                        .CircleImage(width: 60)
                    Text("username2")
                }}
              
                Spacer()
            }
            
            Divider()
            
            HStack{
                ForEach(0..<6){ item in
                    Button{
                        
                    }label: {
                    VStack(spacing:0){
                        Image("image4")
                            .CircleImage(width: 60)
                        Text("\(item)")
                    }
                    .offset(y:showanimation[item] ? 0:50)
                    }
                }
                Spacer()
            }
            
            Divider()
            
            HStack{
                
                Button{
                    
                }label: {
                VStack{
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40)
                        .background(.white,in: Circle())
                    Text("生成图")
                }
                .offset(y:showanimation[0] ? 0:40)
                }
                Button{
                    
                }label: {
                VStack{
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40)
                        .background(.white,in: Circle())
                    Text("生成图")
                }
                .offset(y:showanimation[1] ? 0:20)
                }
                Button{
                    
                }label: {
                VStack{
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40)
                        .background(.white,in: Circle())
                    Text("生成图")
                }
                .offset(y:showanimation[2] ? 0:20)
                }
                Button{
                    
                }label: {
                VStack{
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40)
                        .background(.white,in: Circle())
                    Text("生成")
                }
                .offset(y:showanimation[3] ? 0:20)
                }
                Button{
                    
                }label: {
                VStack{
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40)
                        .background(.white,in: Circle())
                    Text("生成分")
                }
                .offset(y:showanimation[4] ?  0:20)
                }
                Spacer()
            }
        }
        .padding()
        .padding(.bottom,30)
        .frame(width: UIScreen.main.bounds.width)
        .foregroundColor(.black)
        .background(Color("gray"))
    }
}
