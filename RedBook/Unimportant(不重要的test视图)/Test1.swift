//
//  Test1.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/18.
//

import SwiftUI

struct Test1: View {
    @State var tag : [String] = ["财经","游戏","吃鸡","洗衣粉","饮食","电子设备"]
    
    func RowCount(tag:[String]) -> Int{
        // 返回的是我们一共有几行
        let rowcount = tag.count
        if rowcount % 4 == 0 {
            return (rowcount / 4)
        }else if rowcount % 4 != 0{
            return (rowcount / 4 + 1)
        }
        // 这一步不可能执行到
        return rowcount
    }
    
    // 已经知道有多少行 也知道每一行有多少个
//    请问每一行的第一个值 在 原来的数组里面对应的下表应该是多少 ??
//
//    1--> 0  0+1 0+ 2 0 +3
//    2--> 0 + 4
//    3--> 0 + 4 + 4
//    n --> 0 + (n-1)*4
    func RowTag(rowindex:Int,tag:[String]) -> [String]{
        var rowtag : [String] = []
        for item in 0..<4 {
            let index = (rowindex-1) * 4 + item
            if index < tag.count{
                rowtag.append(tag[index])
            }
        }
        return rowtag
    }
    
    var body: some View {
        VStack{
            Text("\(RowCount(tag: tag))")
            Text("娱乐")
                .ButtonStyleGray()
                .overlay(
                    Image(systemName: "xmark")
                        .font(.system(size: 10))
                        .padding(4)
                        .foregroundColor(.white)
                        .background(.gray.opacity(0.3),in: Circle())
                        .offset(x: 45, y: -15)
                    
                )
        }
        
    }
}

struct Test1_Previews: PreviewProvider {
    static var previews: some View {
        Test1()
    }
}
