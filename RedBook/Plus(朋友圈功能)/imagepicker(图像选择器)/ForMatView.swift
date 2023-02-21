//
//  ForMatView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/9.
//

import SwiftUI

struct ForMatView: View {
    @State var select = 0
    @Binding var  showplusview : Bool
    var body: some View {
        
        VStack{
            HStack{
                Button{
                    withAnimation {
                        self.showplusview = false
                    }
                }label: {
                    Image(systemName: "xmark")
                }
               
               Spacer()
            
                Text("模版")
            
                Spacer()
            }
            Divider()
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing:20){
                    // 视图控制器
                    Button{
                        select = 0
                    }label: {
                        Text("推荐")
                    }
                    .foregroundColor(select == 0 ? .white:.gray)
                    
                    Button{
                        select = 1
                    }label: {
                        Text("最新")
                    }
                    .foregroundColor(select == 1 ? .white:.gray)
                    Button{
                        select = 2
                    }label: {
                        Text("有态度")
                    }
                    .foregroundColor(select == 2 ? .white:.gray)
                    Button{
                        select = 3
                    }label: {
                        Text("夏日")
                    }
                    .foregroundColor(select == 3 ? .white:.gray)
                    Button{
                        select = 4
                    }label: {
                        Text("生活碎片")
                    }
                    .foregroundColor(select == 4 ? .white:.gray)
                    Button{
                        select = 5
                    }label: {
                        Text("推荐")
                    }
                    .foregroundColor(select == 5 ? .white:.gray)
                    Button{
                        select = 6
                    }label: {
                        Text("OOTW")
                    }
                    .foregroundColor(select == 6 ? .white:.gray)
                    Button{
                        select = 7
                    }label: {
                        Text("穿搭")
                    }
                    .foregroundColor(select == 7 ? .white:.gray)
                }
            }
            TabView(selection: $select){
                ForEach(0..<5){ item in
                    Text("\(item)")
                        .tag(item)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .foregroundColor(.white)
        .background(.black)
    }
}
