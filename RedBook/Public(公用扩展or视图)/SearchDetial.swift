//
//  SearchDetial.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/20.
//

import SwiftUI



struct SearchDetial: View {
    @State var scrollsize : CGFloat = 0
    @State var searchtext = ""
    var hasSearchtext = "搜索的关键词"
    @State var select = 0
    @Environment(\.presentationMode) var  presentationMode
    
    
    var body: some View {
        VStack{
                HStack{
                    // search
                    Button{
                        presentationMode.wrappedValue.dismiss()
                   }label: {
                       Image(systemName: "chevron.backward")
                   }
                   .foregroundColor(.black)
                    
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("周杰伦新歌", text: $searchtext)
                    }
                    .padding(5)
                    .background(.gray.opacity(0.2),in: RoundedRectangle(cornerRadius: 20))
                }
                .foregroundColor(.gray)
                .padding(.horizontal)
                .padding(.top)
                HStack(spacing:40){
                    
                    Button{
                        withAnimation {
                            select = 0
                        }
                    }label: {
                        Text("全部")
                    }
                    .foregroundColor( select == 0 ? .black:.gray)
                    
                    Button{
                        withAnimation {
                            select = 1
                        }
                    }label: {
                        Text("用户")
                    }
                    .foregroundColor( select == 1 ? .black:.gray)
                   
                    Button{
                        withAnimation {
                            select = 2
                        }
                    }label: {
                        Text("商品")
                    }
                    .foregroundColor( select == 2 ? .black:.gray)
                }
                .padding(.vertical,5)
                .padding(.horizontal)
                .overlay(
                    VStack{
                        Spacer()
                        HStack(spacing:40){
                            if select == 2{
                                Spacer()
                            }
                            
                            VStack{
                                Spacer()
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 30, height: 3)
                                    .foregroundColor(Color("red"))
                            }
                            
                            if select == 0{
                                Spacer()
                            }
                        }
                        .padding(.horizontal,20)
                    }
                )
            
                if scrollsize > -100{
                    Divider()
                }
            
                TabView(selection: $select){
                    SearchDetial1(scrollsize: $scrollsize)
                        .tag(0)
                    SearchDetial2()
                        .tag(1)
                    SearchDetial3()
                        .tag(2)
                }
                .frame(minHeight:800,maxHeight: .infinity)
                .tabViewStyle(.page(indexDisplayMode: .never))
               
        }
        .offset(y:scrollsize < 0 ? scrollsize:0)
        .offset(y:scrollsize < -115 ? -(scrollsize+115):0)
        .frame(width: UIScreen.main.bounds.width)
        .background(.white)
    }
}

