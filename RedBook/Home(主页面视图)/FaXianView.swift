//
//  FaXianView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/13.
//

import SwiftUI
import BearComponent

struct FaXianView: View {
    var namespace : Namespace.ID
    @State var select  = 0
    @Binding var isshow  : Bool
    @Binding var isshowdetial : Bool
    @EnvironmentObject var mycarddatas : Model
    //[总的tag] = 【用户自己挑选喜欢的 + 剩下没有一被挑选的】
    //选择数据不一定要删掉 有时候可以利用布尔值
    @State var isscroll : Bool = false
    @EnvironmentObject var pyqdata : PYQData
    
    func GetLoveTag(AllTags:[Tags]) -> [String]{
        var lovetags : [String] = []
        for item in AllTags{
            if item.isinlove{
                lovetags.append(item.tagtext)
            }
        }
        return lovetags
    }
    
    func convert(data:[Carddata])->[WaterFullData]{
        var mydata : [WaterFullData] = []
        for i in data{
            mydata.append(WaterFullData(clientname:i.client.username, clientImageurl:i.client.clientimage, customword:"赞\(i.love)", title: i.title, mainImageurl: i.publishimageurl.first ?? ""))
        }
        print("mydata\(mydata)")
        return mydata
    }
    
     
    var body: some View {
            VStack{
                ZStack{
                    VStack{
                        // 视图之间如何去传递数值 变量的生命周期
                        NavBar1(select: $select,isshow: $isshow,Lovetag:GetLoveTag(AllTags: mycarddatas.AllTags))
                        
                        Spacer()
                        TabView(selection:$select){
                            ForEach(0..<GetLoveTag(AllTags: mycarddatas.AllTags).count){ item in
                                WaterFullView(data:convert(data: self.pyqdata.allPyqData))
                                    .tag(item)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                    }
                    VStack{
                    // 视图之间如何去传递数值 变量的生命周期
                        NavBar2(isshow: $isshow, FinshEdit: { newmodel in
                        })
                        .background(.white)
                        .offset(x: 0, y: isshow ? 0:-400)
                        Spacer()
                    }
                }
            }
    }
}
