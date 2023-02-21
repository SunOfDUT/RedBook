//
//  Card2.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/13.
//

import SwiftUI
import Parse
func GetTime(date:Date)->String{
    let distance = date.distance(to: Date()) // 秒
    // 一分钟 60s  一小时 60分钟  一天 24小时  一年 365天 一年31536000秒
    let date = Int(distance) / (86400)
    if date != 0{
        return "\(date)天"
    }else{
        let hour = Int(distance) / (3600)
        if hour != 0{
            return "\(hour)小时"
        }else{
            let min = Int(distance) / (60)
            if min != 0{
                return "\(min)分钟"
            }else{
                return "\(Int(distance))秒"
            }
        }
    }
}


struct ConcernCard: View {
    @State var index : Int = 0
    @State var card : Carddata
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var pyqdata : PYQData
    @EnvironmentObject var mycarddatas : Model
    @State var text = ""
    @Binding var showShare : Bool
    @Binding var showContend  : Bool
    @Binding var showaccountdetial : Bool
    @Binding var showanimation : [Bool]
    @State var isLoved : Bool = false
    @State var isStared : Bool   = false
    @State var  IsConcern : Bool = false
    @State var LoveInt : Int = 0
    @State var StarInt : Int = 0
    
    
    func GetIndex(){
        for i in 0..<pyqdata.allPyqData.count{
            if pyqdata.allPyqData[i] == card{
                self.index = i
                print("\(index)index")
                return
            }
        }
    }
//    func UploadLove(mode:String){
//        let query = PFUser.query()
//        query?.whereKey("objectId", equalTo: Myclientdata.MyClient.username)
//        query?.getFirstObjectInBackground(block: { obj, error in
//            if obj != nil{
//                var love = obj!.object(forKey: "love") as! [String]
//                if mode == "add"{
//                    self.Myclientdata.MyClient.love.append(card.pyqobjectid)
//                    Myclientdata.datastore()
//                    love.append(card.pyqobjectid)
//                    obj!["love"] = love
//                    obj!.saveInBackground()
//                }else{
//                    self.Myclientdata.MyClient.love.removeAll{$0 == card.pyqobjectid}
//                    Myclientdata.datastore()
//                    love.removeAll {$0 == card.pyqobjectid}
//                    obj!["love"] = love
//                    obj!.saveInBackground()
//                }
//            }
//        })
//    }
//
//
//    func UploadStar(mode:String){
//        let query = PFUser.query()
//        query?.whereKey("objectId", equalTo: Myclientdata.MyClient.username)
//        query?.getFirstObjectInBackground(block: { obj, error in
//            if obj != nil{
//                var star = obj!.object(forKey: "star") as! [String]
//                if mode == "add"{
//                    self.Myclientdata.MyClient.star.append(card.pyqobjectid)
//                    Myclientdata.datastore()
//                    star.append(card.pyqobjectid)
//                    obj!["star"] = star
//                    obj!.saveInBackground()
//                }else{
//                    self.Myclientdata.MyClient.star.removeAll{$0 == card.pyqobjectid}
//                    Myclientdata.datastore()
//                    star.removeAll {$0 == card.pyqobjectid}
//                    obj!["star"] = star
//                    obj!.saveInBackground()
//                }
//            }
//        })
//    }
//
//    func ChangeConcern(mode:String){
//        if mode == "add"{
//            Myclientdata.MyClient.concern.append(card.objectid)
//            Myclientdata.datastore()
//            Myclientdata.ServerSave(ChangeName: "concern", ChangeContent: Myclientdata.MyClient.concern)
//        }else{
//            Myclientdata.MyClient.concern.removeAll{$0 == card.objectid}
//            Myclientdata.datastore()
//            Myclientdata.ServerSave(ChangeName: "concern", ChangeContent: Myclientdata.MyClient.concern)
//        }
//    }
//
//
//    func IsConcered(){
//        for i in Myclientdata.MyClient.concern{
//            if i  == card.pyqobjectid{
//                self.IsConcern = true
//            }
//        }
//    }
//
//    func IsLove(){
//        for i in Myclientdata.MyClient.love{
//            if i  == card.pyqobjectid{
//                self.isLoved = true
//            }
//        }
//    }
//
//    func IsStar(){
//        for i in Myclientdata.MyClient.star{
//            if i  == card.pyqobjectid{
//                self.isStared = true
//            }
//        }
//    }
    
    func GetLoveInt(){
        let query = PFUser.query()
        query?.whereKey("love", contains:card.pyqobjectid)
        query?.findObjectsInBackground(block: { obj, error in
            if obj != nil{
                self.LoveInt = obj!.count
            }
        })
    }
    
    func GetStarInt(){
        let query = PFUser.query()
        query?.whereKey("star", contains:card.pyqobjectid)
        query?.findObjectsInBackground(block: { obj, error in
            if obj != nil{
                self.StarInt = obj!.count
            }
        })
    }
    
    func UploadMyPinLun(pinluns:MyPinlun,Publisherobjectid:String,PublishContent:String){
        self.card.pinlun.append(pinluns)
        pyqdata.allPyqData[index].pinlun.append(pinluns)
        pyqdata.datastore()
        let pinlun = PFObject(className: "PingLun")
        pinlun["content"] = pinluns.content
        pinlun["Publisherobjectid"] = Publisherobjectid
        pinlun["objectname"] = pinluns.objectname
        pinlun["pinlunname"] = pinluns.pinlunname
        pinlun["objectimageurl"] = pinluns.objectimageurl
        pinlun["love"]  = pinluns.love
        pinlun["pinlun"] = pinluns.pinlun
        pinlun["PublishContent"] = PublishContent
        pinlun["PinLunContent"] = pinluns.pinluncontent
        pinlun.saveInBackground()
    }
    
    
//    func Getall()async{
//        IsConcered()
//        IsLove()
//        IsStar()
//        GetLoveInt()
//        GetStarInt()
//    }
    
    var body: some View {
        VStack{
            HStack{
                // 导航 头像
                Button{
                    withAnimation {
                        mycarddatas.myselectobjectid = card.client.username
                        showaccountdetial = true
                    }
                }label: {
                    PublicURLImageView(imageurl: card.client.clientimage, contentmode: true)
                        .mask(Circle())
                        .frame(width: 40, height: 40)
                }
                
                Text(card.client.clientname)
                
                HStack(spacing:0){
                    Text(GetTime(date: card.publishtime))
                    Text("前")
                }
                .font(.footnote)
                .foregroundColor(.gray)
                
                Spacer()
                
                Button{
                    // action
                    withAnimation {
                        mycarddatas.myselectobjectid = card.client.username
                        showaccountdetial = true
                    }
                }label: {
                    Image(systemName: "ellipsis")
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal,8)
            
            
            TabView{
                ForEach(card.publishimageurl){ item in
                    PublicURLImageView(imageurl: item, contentmode: false)
                        .tag(item)
                }
            }
            .tabViewStyle(.page)
            .frame(height:500)
            
            HStack(spacing:14){
                // 社交功能 喜欢 转发
                Button{
                    withAnimation {
                        showShare = true
                    }
                    
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.6)){
                        showanimation[0] = true
                    }
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)){
                        showanimation[1] = true
                    }
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.6)){
                        showanimation[2] = true
                    }
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.6)){
                        showanimation[3] = true
                    }
                    withAnimation(.spring(response: 1.0, dampingFraction: 0.6)){
                        showanimation[4] = true
                    }
                    withAnimation(.spring(response: 1.2, dampingFraction: 0.6)){
                        showanimation[5] = true
                    }
                }label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 22))
                }
                
                
                Spacer()
                
                if isLoved{
                    Button{
                        isLoved.toggle()
                        LoveInt -= 1
//                        UploadLove(mode: "delete")
                    }label: {
                        HStack(spacing:0){
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 22))
                            Text("\(LoveInt)")
                        }
                    }
                }else{
                    Button{
                        isLoved.toggle()
                        LoveInt += 1
//                        UploadLove(mode: "add")
                    }label: {
                        HStack(spacing:0){
                            Image(systemName: "heart")
                                .font(.system(size: 22))
                            Text("\(LoveInt)")
                        }
                    }
                }
               
                
                if isStared{
                    Button{
                        isStared.toggle()
                        StarInt -= 1
//                        UploadStar(mode: "delete")
                    }label: {
                        HStack(spacing:0){
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 22))
                            Text("\(StarInt)")
                        }
                    }
                }else{
                    Button{
                        isStared.toggle()
                        StarInt -= 1
//                        UploadStar(mode: "add")
                    }label: {
                        HStack(spacing:0){
                        Image(systemName: "star")
                            .font(.system(size: 22))
                            Text("\(StarInt)")
                        }
                    }
                }
                
                
                Button{
                    withAnimation {
                        GetIndex()
                        mycarddatas.selection = self.index
                        showContend = true
                    }
                }label: {
                    HStack(spacing:0){
                    Image(systemName: "ellipsis.bubble")
                        .font(.system(size: 22))
                        Text("\(card.pinlun.count)")
                    }
                }
               
            }
                .foregroundColor(.black)
                .padding(10)
            HStack{
                // 内容
                Text(card.content)
                Spacer()
            }
            .padding(.horizontal,8)
            HStack{
                //评论
                PublicURLImageView(imageurl:Myclientdata.MyClient.clientimage , contentmode: true)
                    .mask(Circle())
                    .frame(width: 40, height: 40)
                
                TextField("喜欢就给一个评论", text: $text)
                
                Button{
                    if text != ""{
                        UploadMyPinLun(pinluns: MyPinlun(objectname:Myclientdata.MyClient.clientname, pinlunname: "", objectimageurl: Myclientdata.MyClient.clientimage, content:card.content, pinlun: text, love: 0,pinluncontent: "", pinluntime: Date()), Publisherobjectid: card.client.username, PublishContent: card.content)
                    }
                    text = ""
                }label: {
                    Image(systemName: "location.north")
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .padding(5)
            .background(.gray.opacity(0.1),in: RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal,8)
        }
        .padding(.vertical)
//        .task(priority: .background) {
//           await Getall()
//        }
    }
}
//
//struct Card2_Previews: PreviewProvider {
//    static var previews: some View {
//        Card2(showShare: .constant(false), showContend: .constant(false), showaccountdetial: .constant(false))
//    }
//}
