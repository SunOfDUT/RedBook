//
//  SearchDetial1.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/20.
//

import SwiftUI

struct SearchDetial1: View {
    @Binding var scrollsize : CGFloat
    @State var selectSort = 0
    @State var selectContend = 0
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
            HStack{
                HStack(spacing:20){
                    Button{
                        withAnimation {
                            selectSort = 0
                        }
                    }label: {
                        Text("综合")
                    }
                    .foregroundColor(selectSort ==  0 ? .black:.gray)
                    Button{
                        withAnimation {
                            selectSort = 1
                        }
                    }label: {
                        Text("最热")
                    }
                    .foregroundColor(selectSort ==  1 ? .black:.gray)
                    
                    Button{
                        withAnimation {
                            selectSort = 2
                        }
                    }label: {
                        Text("最新")
                    }
                    .foregroundColor(selectSort ==  2 ? .black:.gray)
                   
                }
         
                
                Spacer()
                
                if scrollsize > -100{
                    Divider()
                }
                
                Button{
                    withAnimation {
                        selectSort = 3
                    }
                }label: {
                    Text("视频")
                    Image(systemName: "play.circle")
                }
                .foregroundColor(selectSort ==  3 ? .black:.gray)
               
                Divider()
                
                Button{
                    withAnimation {
                        selectSort = 4
                    }
                }label: {
                    Text("图文")
                    Image(systemName: "photo")
                }
                .foregroundColor(selectSort ==  4 ? .black:.gray)
            }
            .frame(width:UIScreen.main.bounds.width - 40,height:30)
            
            Divider()
           
            HStack(spacing:4){
                
            HStack(spacing:4){
                    Spacer()
                    Button{
                        withAnimation(.spring()){
                            selectContend = 0
                        }
                    }label: {
                        Text("全部")
                    }
                    .foregroundColor(selectContend ==  0 ? .black:.gray)
                    .frame(width: 55, height: 25)
                    .background(selectContend == 0 ?  .gray.opacity(0.2):.white,in: RoundedRectangle(cornerRadius: 10))
                    Spacer()
                    Button{
                        withAnimation(.spring()){
                            selectContend = 1
                        }
                    }label: {
                        Text("照片")
                    }
                    .foregroundColor(selectContend ==  1 ? .black:.gray)
                    .frame(width: 55, height: 25)
                    .background(selectContend == 1 ?  .gray.opacity(0.2):.white,in: RoundedRectangle(cornerRadius: 10))
                
                    Spacer()
                    Button{
                        withAnimation(.spring()){
                            selectContend = 2
                        }
                    }label: {
                        Text("歌曲")
                    }
                    .foregroundColor(selectContend ==  2 ? .black:.gray)
                    .frame(width: 55, height: 25)
                    .background(selectContend == 2 ?  .gray.opacity(0.2):.white,in: RoundedRectangle(cornerRadius: 10))
                }
            
                
                Spacer()
                Button{
                    withAnimation(.spring()){
                        selectContend = 3
                    }
                }label: {
                    Text("头像")
                }
                .foregroundColor(selectContend ==  3 ? .black:.gray)
                .frame(width: 55, height: 25)
                .background(selectContend == 3 ?  .gray.opacity(0.2):.white,in: RoundedRectangle(cornerRadius: 10))
                Spacer()
                Button{
                    withAnimation(.spring()){
                        selectContend = 4
                    }
                }label: {
                    Text("壁纸")
                }
                .foregroundColor(selectContend ==  4 ? .black:.gray)
                .frame(width: 55, height: 25)
                .background(selectContend == 4 ?  .gray.opacity(0.2):.white,in: RoundedRectangle(cornerRadius: 10))
                Spacer()
                Button{
                    withAnimation(.spring()){
                        selectContend = 5
                    }
                }label: {
                    Text("视频")
                }
                .foregroundColor(selectContend ==  5 ? .black:.gray)
                .frame(width: 55, height: 25)
                .background(selectContend == 5 ?  .gray.opacity(0.2):.white,in: RoundedRectangle(cornerRadius: 10))
                Spacer()
                
            }
            .padding(15)
            }
            .offset(y:scrollsize < 0  ? -62:0)
            .offset(y: scrollsize < -110 ? -5:0)
            
            TabView(selection: $selectContend){
                ScrollView{
                    scrollRead
                    Color.red.frame(height: 1000)
                        
                    Color.teal.frame(height: 1000)
                }
                .coordinateSpace(name: "scroll")
                .tag(0)
            }
            .offset(y:scrollsize < 0 ? -50:0)
            .frame(minHeight:1000,maxHeight: .infinity)
            .frame(width: UIScreen.main.bounds.width)
           
        }
//        .overlay(
//            Text("\(scrollsize)")
//        )
    }
    
    var scrollRead : some View{
        GeometryReader{ proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self, value:proxy.frame(in: .named("scroll")).midY)
            
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation {
                self.scrollsize = value
                print(self.scrollsize)
            }
        }
    }
}

