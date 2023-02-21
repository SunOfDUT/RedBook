//
//  NavBar2.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/13.
//

import SwiftUI

struct NavBar2: View {
    @Binding var isshow : Bool
    var FinshEdit : ((_ newmodel:Model)->())?
    @EnvironmentObject var mycarddatas : Model
    @State var isEditingMode = false
    @State var Columns = Array(repeating:GridItem(.flexible(minimum: 20, maximum: 50), spacing: 55, alignment: .center), count: 4)
    @State var Rows = Array(repeating:GridItem(.flexible(minimum: 20, maximum: 50), spacing: 5, alignment: .center), count: 3)
    
    var body: some View {
        VStack{
            VStack(spacing:15){
                // 我的频道
                HStack{
                    Text("我的频道")
                        .bold()
                    Text("点击进入频道")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                    
                    Button{
                        withAnimation {
                            isEditingMode.toggle()
                        }
                    }label: {
                        Text(isEditingMode ?  "完成编辑":"进入编辑")
                            .font(.footnote)
                            .padding(.vertical,4)
                            .padding(.horizontal,10)
                            .background(.gray.opacity(0.2),in: RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.accentColor)
                    }
                    
                    Button{
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)){
                            isshow = false
                        }
                    }label: {
                        Image(systemName: "chevron.up")
                          
                    }
                    .foregroundColor(.black)
                }
                
                
                HStack{
                    VStack(alignment:.leading){
                       // 我的频道
                        LazyVGrid(columns:Columns){
                            ForEach(mycarddatas.AllTags){ item in
                                if item.isinlove {
                                    ZStack{
                                        Button{
                                            withAnimation{
                                                
                                            }
                                        }label: {
                                            if item.id > 2{
                                                Text(item.tagtext)
                                                    .ButtonStyleWhite()
                                                    .foregroundColor(.black)
                                            }else{
                                                Text(item.tagtext)
                                                    .ButtonStyleGray()
                                                    .foregroundColor(.black)
                                            }
                                            
                                        }
                                        if isEditingMode && item.id > 2{
                                            Button{
                                                withAnimation {
                                                    mycarddatas.AllTags[item.id].isinlove = false
                                                    mycarddatas.datastore()
                                                }
                                            }label: {
                                                Image(systemName: "xmark")
                                                    .font(.system(size: 10))
                                                    .padding(4)
                                                    .foregroundColor(.white)
                                                    .background(.gray.opacity(0.3),in: Circle())
                                            }
                                            .offset(x: 45, y: -15)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .foregroundColor(.black)
            .padding(.bottom)
            
            VStack{
                // 推荐频道
                // 我的频道
                HStack{
                    Text("推荐频道")
                        .bold()
                    Text("点击添加频道")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                }
                
                HStack{
                    VStack(alignment:.leading){
                        // 推荐频道
                        LazyVGrid(columns:Columns){
                            ForEach(mycarddatas.AllTags){ item in
                                if !item.isinlove{
                                    Button{
                                        withAnimation{
                                            mycarddatas.AllTags[item.id].isinlove = true
                                            mycarddatas.datastore()
                                        }
                                    }label: {
                                        HStack{
                                            Text("+")
                                            Text(item.tagtext)
                                        }
                                        .ButtonStyleGray()
                                        .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                }
            }
                .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3 + 30)
    }
      
}
