//
//  NoticeData.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/15.
import SwiftUI
import Parse
import UserNotifications

class NoticeData : ObservableObject{
    @ObservedObject var  Myclientdata  : ClientData = ClientData(FromOutMyClient: initMyClientData())
    @ObservedObject var  pyqdata : PYQData = PYQData(allPyqData: initPqyData())
    
    @Published var Myconcern : [concernandfans]
    @Published var MyFans : [concernandfans]
    @Published var MyPinLun : [MyPinlun]
    // 别人喜欢我的
    @Published var MyLoveAndStar : [loveorstar]
    // 我喜欢的和收藏的
    @Published var LoveMyself : [Carddata]
    @Published var starMyself : [Carddata]
    
    init(){
        self.Myconcern = []
        self.MyFans = []
        self.MyPinLun = []
        self.MyLoveAndStar = []
        self.LoveMyself = []
        self.starMyself = []
        self.GetMyConcernAndFans()
        self.GetMyPinLun()
        self.GetLoveAndStar()
        self.GetStar()
        self.GetLove()
    }
    
    func refresh(){
        print("刷新中")
//       self.GetMyConcernAndFans()
//       self.GetMyPinLun()
//       self.GetLoveAndStar()
//        self.GetStar()
//        self.GetLove()
        print("Myconcern\(Myconcern)")
        print("MyFans\(MyFans)")
        print("MyPinLun\(MyPinLun)")
        print("MyLoveAndStar\(MyLoveAndStar)")
        print("LoveMyself\(LoveMyself)")
        print("starMyself\(starMyself)")
    }
    
    func GetMyconcernclient(objectId:String,time:Date){
        let query = PFUser.query()
        query?.whereKey("objectId", equalTo: objectId)
        query?.getFirstObjectInBackground(block: { user, error in
            if user != nil{
                withAnimation {
                    let username = user!.objectId!
                    let clientname = user!.object(forKey: "username") as! String
                    let introduce = user!.object(forKey: "introduce") as! String
                    let sex = user!.object(forKey: "sex") as! String
                    let locate = user!.object(forKey: "locate") as! String
                    let clientimage = user!["clientimage"] as! PFFileObject
                    let backgrounimage = user!["clientbackground"] as! PFFileObject
                    let school = user!.object(forKey: "school") as! String
                    let brithday = user!.object(forKey: "brithday") as! Date
                    let profession = user!.object(forKey: "profession") as! String
                    let client = Client(username: username, clientname: clientname, introduce: introduce, sex:sex, locate: locate, clientimage: clientimage.url!, clienbakground: backgrounimage.url!,school: school,brithday: brithday,profession: profession)
                    withAnimation {
                        self.Myconcern.append(concernandfans(client: client, time:time, ismutual: false))
                    }
                }
            }
        })
    }
    
    func GetMyFansclient(objectId:String,time:Date){
        let query = PFUser.query()
        query?.whereKey("objectId", equalTo: objectId)
        query?.getFirstObjectInBackground(block: { user, error in
            if user != nil{
                withAnimation {
                    let username = user!.objectId!
                    let clientname = user!.object(forKey: "username") as! String
                    let introduce = user!.object(forKey: "introduce") as! String
                    let sex = user!.object(forKey: "sex") as! String
                    let locate = user!.object(forKey: "locate") as! String
                    let clientimage = user!["clientimage"] as! PFFileObject
                    let backgrounimage = user!["clientbackground"] as! PFFileObject
                    let school = user!.object(forKey: "school") as! String
                    let brithday = user!.object(forKey: "brithday") as! Date
                    let profession = user!.object(forKey: "profession") as! String
                    let client = Client(username: username, clientname: clientname, introduce: introduce, sex:sex, locate: locate, clientimage: clientimage.url!, clienbakground: backgrounimage.url!,school: school,brithday: brithday,profession: profession)
                    withAnimation {
                        self.MyFans.append(concernandfans(client: client, time: time, ismutual: false))
                        self.makeNotification(title: "小红书", content: "\(clientname)关注了你")
                    }
                }
            }
        })
    }
    

    
    func makeNotification(title:String,content:String){
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let not = UNMutableNotificationContent()
        not.title = title
        not.body = content
        not.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier:"通知名称", content: not, trigger:trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func GetMyConcernAndFans(){
        withAnimation {
            self.Myconcern = []
            self.MyFans = []
        }
        
        let pre = NSPredicate(format: "Myobjectid = '\(self.Myclientdata.MyClient.username)' OR objectid = '\(self.Myclientdata.MyClient.username)'")
        let query = PFQuery(className: "ConcernAndFans",predicate: pre)
        query.whereKey("Isshow", equalTo: true)
        query.findObjectsInBackground { obj, error in
            if obj != nil{
                print("GetMyConcernAndFans\(obj)")
                for i in obj!{
                    let Myobjectid = i.object(forKey: "Myobjectid") as! String
                    let objectid = i.object(forKey: "objectid") as! String
                    let time = i.createdAt!
                    
                    if Myobjectid == self.Myclientdata.MyClient.username{
                        // 说明是我关注了别人 是我的关注
                        self.GetMyconcernclient(objectId:objectid,time: time)
                    }else{
                        // 说明是别人关注了我 是我的粉丝
                        self.GetMyFansclient(objectId:Myobjectid,time: time)
                    }
                }
            }
        }
        
        for i in 0..<self.Myconcern.count{
            let isin = self.MyFans.contains(where: { fans in
                if fans.client.username == self.Myconcern[i].client.username{
                    return true
                }else{
                    return false
                }
            })
            if isin{
                self.Myconcern[i].ismutual = true
            }
        }
        
        for i in 0..<self.MyFans.count{
            let isin = self.Myconcern.contains(where: { fans in
                if fans.client.username == self.MyFans[i].client.username{
                    return true
                }else{
                    return false
                }
            })
            if isin{
                self.MyFans[i].ismutual = true
            }
        }
    }
    
    func GetMyPinLun(){
        withAnimation {
            self.MyPinLun = []
        }
        let pre = NSPredicate(format: "pinlunname = '\(self.Myclientdata.MyClient.clientname)'")
        let query = PFQuery(className: "PingLun",predicate: pre)
        query.findObjectsInBackground { object, error in
            if object != nil{
                print("Mypinlun\(object)")
                for i in object!{
                    let objectname = i.object(forKey: "objectname") as! String // 自己的名字
                    let pinlunname = i.object(forKey: "pinlunname") as! String // 对象的名字
                    let objectimageurl = i.object(forKey: "objectimageurl") as! String
                    let love = i.object(forKey: "love") as! Int
                    let content2 = i.object(forKey: "pinlun") as! String
                    let content = i.object(forKey: "content") as! String
                    let pinluncontent =  i.object(forKey: "PinLunContent") as! String
                    let time = i.createdAt!
                    self.MyPinLun.append(MyPinlun(objectname: objectname, pinlunname: pinlunname, objectimageurl: objectimageurl,content:content,pinlun:content2, love: love,pinluncontent:pinluncontent, pinluntime: time))
                }
            }
        }
    }
    
    func GetLoveAndStar(){
        withAnimation{
            self.MyLoveAndStar = []
        }
        self.GetLove()
        self.GetStar()
        self.MyLoveAndStar = self.MyLoveAndStar.sorted{$0.time < $1.time}
    }
    
    func GetLove(){
        let pre = NSPredicate(format: "myobjectid = '\(Myclientdata.MyClient.username)' OR objectid = '\(Myclientdata.MyClient.username)'")
        let query = PFQuery(className: "Love",predicate: pre)
        query.whereKey("Isshow", equalTo: true)
        query.findObjectsInBackground { obj, error in
            if obj != nil{
                print("Love\(obj)")
                withAnimation {
                    self.LoveMyself = []
                }
                for i in obj!{
                    let objectid = i.object(forKey: "objectid") as! String
                    let myobjectid = i.object(forKey: "myobjectid") as! String
                    let pyqobjectid = i.object(forKey: "pyqobjectid") as! String
                    if objectid == self.Myclientdata.MyClient.username{
                        // 是赞我们的
                        let pyqcontent = i.object(forKey: "pyqcontent") as! String
                        let pyqimage = i.object(forKey: "pyqimage") as! String
                        let pyqobjectid = i.object(forKey: "pyqobjectid") as! String
                        let myobjectid = i.object(forKey: "myobjectid") as! String
                        let time = i.createdAt!
                        let query = PFUser.query()
                        query?.whereKey("objectId", equalTo: myobjectid)
                        query?.getFirstObjectInBackground(block: { user, error in
                            if user != nil{
                                let clientname = user!.object(forKey: "username") as! String
                                let introduce = user!.object(forKey: "introduce") as! String
                                let sex = user!.object(forKey: "sex") as! String
                                let locate = user!.object(forKey: "locate") as! String
                                let clientimage = user!["clientimage"] as! PFFileObject
                                let backgrounimage = user!["clientbackground"] as! PFFileObject
                                let school = user!.object(forKey: "school") as! String
                                let brithday = user!.object(forKey: "brithday") as! Date
                                let profession = user!.object(forKey: "profession") as! String
                                let client =  Client(username:myobjectid, clientname: clientname, introduce: introduce, sex:sex, locate: locate, clientimage: clientimage.url!, clienbakground: backgrounimage.url!,school: school,brithday: brithday,profession: profession)
                                withAnimation {
                                    self.MyLoveAndStar.append(loveorstar(islove : true,time:time, object:client,pyqcontent: pyqcontent, pyqimageurl: pyqimage, pyqobjectid: pyqobjectid))
                                }
                            }
                        })
                    }
                    
                    if myobjectid == self.Myclientdata.MyClient.username{
                        for item in self.pyqdata.allPyqData{
                            if item.pyqobjectid == pyqobjectid{
                                withAnimation {
                                    print("add")
                                    self.LoveMyself.append(item)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func GetStar(){
        let pre = NSPredicate(format: "myobjectid = '\(Myclientdata.MyClient.username)' OR objectid = '\(Myclientdata.MyClient.username)'")
        let query = PFQuery(className: "Star",predicate: pre)
        query.whereKey("Isshow", equalTo: true)
        query.findObjectsInBackground { obj, error in
            if obj != nil{
                print("Star\(obj)")
                withAnimation {
                    self.starMyself = []
                }
                for i in obj!{
                    let objectid = i.object(forKey: "objectid") as! String
                    let pyqobjectid = i.object(forKey: "pyqobjectid") as! String
                    let myobjectid = i.object(forKey: "myobjectid") as! String
                    if objectid == self.Myclientdata.MyClient.username{
                        // 是赞我们的
                        let pyqcontent = i.object(forKey: "pyqcontent") as! String
                        let pyqimage = i.object(forKey: "pyqimage") as! String
                        let pyqobjectid = i.object(forKey: "pyqobjectid") as! String
                        let myobjectid = i.object(forKey: "myobjectid") as! String
                        let time = i.createdAt!
                        let query = PFUser.query()
                        query?.whereKey("objectId", equalTo: myobjectid)
                        query?.getFirstObjectInBackground(block: { user, error in
                            if user != nil{
                                let clientname = user!.object(forKey: "username") as! String
                                let introduce = user!.object(forKey: "introduce") as! String
                                let sex = user!.object(forKey: "sex") as! String
                                let locate = user!.object(forKey: "locate") as! String
                                let clientimage = user!["clientimage"] as! PFFileObject
                                let backgrounimage = user!["clientbackground"] as! PFFileObject
                                let school = user!.object(forKey: "school") as! String
                                let brithday = user!.object(forKey: "brithday") as! Date
                                let profession = user!.object(forKey: "profession") as! String
                                let client =  Client(username:myobjectid, clientname: clientname, introduce: introduce, sex:sex, locate: locate, clientimage: clientimage.url!, clienbakground: backgrounimage.url!,school: school,brithday: brithday,profession: profession)
                                withAnimation {
                                self.MyLoveAndStar.append(loveorstar(islove : false,time:time, object:client,pyqcontent: pyqcontent, pyqimageurl: pyqimage, pyqobjectid: pyqobjectid))
                            }
                            }
                        })
                    }
                    
                    if myobjectid  == self.Myclientdata.MyClient.username{
                        for item in self.pyqdata.allPyqData{
                            if item.pyqobjectid == pyqobjectid{
                                withAnimation {
                                    print("add")
                                    self.starMyself.append(item)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
   
}

struct loveorstar : Identifiable{
    var id = UUID()
    var islove : Bool
    var time : Date
    var object : Client
    var pyqcontent : String
    var pyqimageurl : String
    var pyqobjectid : String
}

struct concernandfans : Identifiable{
    var id = UUID()
    var client : Client
    var time : Date
    var ismutual : Bool
}
