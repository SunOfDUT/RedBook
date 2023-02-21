//
//  Test2.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/19.
//

import SwiftUI

struct Test2: View {
    @State var AllTags : [Tags] = [
        Tags(tagtext: "推荐", isinlove: true,id: 0),
        Tags(tagtext: "视频", isinlove: true,id: 1),
        Tags(tagtext: "直播", isinlove: true,id: 2),
        Tags(tagtext: "头像", isinlove: false,id: 3),
        Tags(tagtext: "财经", isinlove: false,id: 4),
        Tags(tagtext: "计算机",isinlove: false,id: 5),
        Tags(tagtext: "钢琴", isinlove: false,id: 6),
        Tags(tagtext: "音乐", isinlove: false,id: 7),
        Tags(tagtext: "购物", isinlove: false,id: 8),
        Tags(tagtext: "电影", isinlove: false,id: 9),
        Tags(tagtext: "旅游", isinlove: false,id: 10),
        Tags(tagtext: "护肤", isinlove: false,id: 11),
        Tags(tagtext: "穿搭", isinlove: false,id: 12),
        Tags(tagtext: "出国", isinlove: false,id: 13),
        Tags(tagtext: "新闻", isinlove: false,id: 14),
    ]
    @State var Columns = Array(repeating:GridItem(.flexible(minimum: 20, maximum: 50), spacing: 55, alignment: .center), count: 4)
    @State var Rows = Array(repeating:GridItem(.flexible(minimum: 20, maximum: 50), spacing: 5, alignment: .center), count: 3)
    
    var body: some View {
        VStack{
            LazyVGrid(columns:Columns){
                ForEach(AllTags){ item in
                    if item.isinlove{
                        Button{
                            withAnimation{
                                self.AllTags[item.id].isinlove = false
                            }
                        }label: {
                            Text(item.tagtext)
                                .ButtonStyleGray()
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            
            LazyVGrid(columns:Columns){
                ForEach(AllTags){ item in
                    if !item.isinlove{
                        Button{
                            withAnimation{
                                self.AllTags[item.id].isinlove = true
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

struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
    }
}
