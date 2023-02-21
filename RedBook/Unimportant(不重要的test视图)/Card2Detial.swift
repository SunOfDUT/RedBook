//
//  Card2Detial.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/20.
//

import SwiftUI
import Parse

struct Card2Detial: View {
    @Binding var index : Int
    @Binding var card : Carddata
    @EnvironmentObject var pyqdata : PYQData
    @EnvironmentObject var Myclientdata  : ClientData
    @State var Mypinlun : String = ""
    @Binding var showContend  : Bool
    @State var pinlunname : String = ""
    @State var pinluncontent : String = ""
    @State var content : String = ""
    
    func UploadMyPinLun(pinluns:MyPinlun,Publisherobjectid:String,PublishContent:String){
        self.card.pinlun.append(pinluns)
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
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "xmark")
                    .opacity(0)
                Spacer()
                Text("正文和评论")
                Spacer()
                
                Button{
                    withAnimation {
                        showContend = false
                    }
                }label: {
                    Image(systemName: "xmark")
                }
            }
            .padding(.bottom,10)
            
            Divider()
            
            ScrollView(showsIndicators:false){
                
                VStack(alignment:.leading){
                HStack{
                    Text(card.title)
                        .foregroundColor(.black)
                        .font(.title2)
                    
                    Spacer()
                }
                Divider()
                
                HStack{
                    Text(card.content)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
               
                
                HStack{
                    Text(card.publishtime.formatted())
                    Text(card.locate)
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.gray)
               
                
                Divider()
                
                VStack{
                    if card.pinlun.count != 0{
                        HStack{
                            Text("一共有\(card.pinlun.count)条评论")
                            Spacer()
                        }
                        .foregroundColor(.gray)
                    }else{
                        Text("----还没有评论哦----")
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                 
                }
                
                PinLunDetial(card:card,pinlunname: $pinlunname,pinluncontent: $pinluncontent,content :$content)
                }
            }
            .frame(height: 500)
            
            HStack{
                TextField("回复\(pinlunname)的\(content):", text: $Mypinlun)
                Button{
                    if Mypinlun != ""{
                    if content == ""{
                        content = card.content
                    }
                        if pinlunname == ""{
                            pinlunname =  card.client.clientname
                        }
                        UploadMyPinLun(pinluns: MyPinlun(objectname:Myclientdata.MyClient.clientname, pinlunname: pinlunname, objectimageurl: Myclientdata.MyClient.clientimage, content:content, pinlun: Mypinlun, love: 0,pinluncontent: pinluncontent, pinluntime: Date()), Publisherobjectid: card.client.username, PublishContent: card.content)
                    pinlunname = ""
                    content = ""
                    Mypinlun = ""
                    pinluncontent = ""
                    }
                }label: {
                    Image(systemName: "location.north")
                        .foregroundColor(.black)
                }
                
                Button{
                    
                }label: {
                    Image(systemName: "at")
                }
                .foregroundColor(.gray)
                
                Button{
                    
                }label: {
                    Image(systemName: "face.smiling")
                }
                .foregroundColor(.gray)
            }
            .padding(10)
            .background(.gray.opacity(0.2),in: RoundedRectangle(cornerRadius: 30))
            .padding(.bottom)
        }
        .padding(10)
        .foregroundColor(.black)
        .background(.white)
        .onAppear {
            print(index)
        }
        .onChange(of: card) { newValue in
            print("\(newValue.pinlun)card.pinlun")
        }
    }
}
