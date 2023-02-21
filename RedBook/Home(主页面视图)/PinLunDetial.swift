//
//  PinLunDetial.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/12.
//

import SwiftUI


func GetPinlun(pinlun:[MyPinlun],content:String,pinlunname:String) -> [MyPinlun]{
    var pinlun2 : [MyPinlun] = []
    for i in pinlun{
        if content == i.pinlun && pinlunname == i.objectname{
            pinlun2.append(i)
        }
    }
    return pinlun2
}

struct PinLunDetial: View {
    var card:Carddata
    @Binding var pinlunname : String
    @Binding var pinluncontent : String
    @Binding var content : String
   
    var body: some View {
        VStack{
            ForEach(card.pinlun){ item in
                if item.content == card.content{
                    VStack{
                        HStack(alignment:.top,spacing:20){
                            PublicURLImageView(imageurl:item.objectimageurl, contentmode: true)
                                    .mask(Circle())
                                    .frame(width: 40, height: 40)
                            
                            VStack(alignment:.leading){
                                Text(item.objectname)
                                    .font(.system(size:16))
                                    .foregroundColor(.gray)
                                
                                Button{
                                    pinluncontent = item.pinlun
                                    pinlunname = item.objectname
                                    content = item.pinlun
                                }label:{
                                    Text(item.pinlun)
                                        .font(.system(size:16))
                                        .foregroundColor(.black)
                                }
                                
                                VStack{
                                    lowPinLun(cardcontent:card.content,AllPinLun: card.pinlun, item: item,pinlunname:$pinlunname, pinluncontent:$pinluncontent,content:$content)
                                }
                            }
                            
                            Spacer()
                            
                            VStack{
                                Image(systemName: "heart")
                                Text("\(item.love)")
                            }
                            .foregroundColor(.gray)
                            
                        }
                        .padding(.horizontal,5)
                        
                        
                        Divider()
                            .padding(.leading,70)
                    }
                }
            }
        }
    }
}


struct lowPinLun : View{
    var cardcontent : String
    var AllPinLun:[MyPinlun]
    var item:MyPinlun
    @Binding var pinlunname : String
    @Binding var pinluncontent : String
    @Binding var content : String
    var body: some View{
        VStack(alignment:.leading){
            ForEach(AllPinLun){ item2 in
                if item2.pinluncontent == item.pinlun && item2.content != cardcontent{
                    HStack(alignment:.top){
                        PublicURLImageView(imageurl:item2.objectimageurl, contentmode: true)
                                .mask(Circle())
                                .frame(width: 25, height: 25)
                        
                        VStack(alignment:.leading){
                            Text(item2.objectname)
                                .foregroundColor(.gray)
                                .font(.system(size:13))
                            HStack(alignment:.top,spacing:0){
                                Text("回复")
                                    .font(.system(size:13))
                                Text("\(item.objectname):")
                                    .foregroundColor(.gray)
                                    .font(.system(size:13))
                                Button{
                                    pinlunname = item2.objectname
                                    pinluncontent = item.pinlun
                                    content = item2.pinlun
                                }label:{
                                    Text(item2.pinlun)
                                        .font(.system(size:13))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
            }
        }
        }
    }

