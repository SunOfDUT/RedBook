//
//  test7.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/5.
//

import SwiftUI


struct test7: View {
    @State var show = false
    @State var Texts = ""
    @State var showanimation : [Bool] = [false,false,false,false,false,false]
    @State var pickDate = Date()
    @State var pick = [
        "1","2","3"
    ]
    @State var select : String = ""
    var body: some View {
    
        VStack{
            AsyncImage(url: URL(string: "http://localhost:1337/parse/files/8888/504e2625297375f4583c5b4fa2a777f2_image.png")!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .mask(Circle())
                    .frame(width: 100, height: 100)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            
            Text("取消")
                .foregroundColor(.white)
                .frame(width: 80, height: 30)
                .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
            
            
            Picker("", selection: $select) {
                ForEach(pick){ item in
                    Text(item)
                }
            }
            .pickerStyle(.inline)
    
            
            VStack(spacing:18){
                Text("获赞与收藏")
                    .font(.title3)
                
                Divider()
                
                VStack{
                    HStack(spacing:12){
                        Image(systemName: "square.text.square")
                            .foregroundColor(.white)
                            .padding(3)
                            .background(.blue,in:Circle())
                        Text("当前发布笔记数")
                            .foregroundColor(.gray)
                        Text("\(0)")
                    }
                    
                    HStack(spacing:12){
                        Image(systemName: "heart")
                            .foregroundColor(.white)
                            .padding(3)
                            .background(Color("red"),in:Circle())
                        Text("当前获得点赞数")
                            .foregroundColor(.gray)
                        Text("\(0)")
                    }
                    
                    HStack(spacing:12){
                        Image(systemName: "star")
                            .foregroundColor(.white)
                            .padding(3)
                            .background(.yellow,in:Circle())
                        Text("当前获得收藏数")
                            .foregroundColor(.gray)
                        Text("\(0)")
                    }
                }
                .padding(.horizontal,15)
                .padding(.vertical)
                Button{
                    withAnimation {
                       
                    }
                }label: {
                    Text("我知道了")
                        .foregroundColor(.white)
                        .frame(width: 140, height: 30)
                        .background(Color("red"),in:RoundedRectangle(cornerRadius: 20))
                }
                
            }
            .frame(width: UIScreen.main.bounds.width / 2 + 30,height: UIScreen.main.bounds.height / 3 - 20 )
            .background(.gray.opacity(0.1),in:RoundedRectangle(cornerRadius: 10))
        }
        .SheetCenterView(isPresented: $show) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.red)
                .overlay(
                    Button{
                        withAnimation {
                            show.toggle()
                        }
                    }label: {
                        Text("点击")
                    }
                )
            
        }

    }
}

struct test7_Previews: PreviewProvider {
    static var previews: some View {
        test7()
    }
}
