//
//  CardData.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/18.
//

import SwiftUI
// 一个是数组 还有一个是结构体 还有一个是我们的class类型
//struct + 结构体的名字 : 结构体符合的协议 {
//
//}
//class + 类的名字 : 类符合的协议 {
//
//}
var encoder = JSONEncoder()
var decoder = JSONDecoder()

func initAllTags() -> [Tags]{
    var output : [Tags] = []
    if let datastore = UserDefaults.standard.object(forKey: "Tags") as? Data {
        let data = try! decoder.decode([Tags].self, from: datastore)
        for i in data{
            output.append(i)
        }
    }
    return output
}

class Model : ObservableObject{
    @Published var select : Selcetion = .home
    @Published var selection : Int = 0
    @Published var selectionvuew : String = ""
    @Published var selectobject :Carddata =  Carddata(title: "", content: "", locate: "", publishtime: Date(), publishimageurl: [], pinlun: [], love: 0, star: 0, pyqobjectid: "", client:  Client(username: "", clientname: "", introduce: "", sex: "", locate: "", clientimage: "", clienbakground: "", school: "", brithday: Date(), profession: ""))
    @Published var AllTags : [Tags]
    @Published var myselectobjectid : String = ""
    
    init(FromOutAllTags : [Tags]){
        self.AllTags =  FromOutAllTags
    }
    
    func initdatastore(){
        self.AllTags = [
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
       self.datastore()
    }
    
    func datastore(){
        let datastore = try! encoder.encode(self.AllTags) // 编码
        // 存储
        UserDefaults.standard.set(datastore,forKey: "Tags")
    }
    // 希望它从我们的内存里面读取 如何去用内存里面的数据去初始化我们的数据
}

struct Tags : Identifiable,Equatable,Encodable,Decodable{
    var tagtext : String
    var isinlove : Bool
    var id : Int
}

