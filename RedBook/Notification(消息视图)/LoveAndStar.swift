//
//  LoveAndStar.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/29.
//

import SwiftUI
import Parse
struct LoveAndStar: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mynotdata : NoticeData
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment:.leading){
                ForEach(mynotdata.MyLoveAndStar){ item in
                    Divider()
                    HStack(alignment:.top){
                        PublicURLImageView(imageurl: item.object.clientimage, contentmode: true)
                            .mask(Circle())
                            .frame(width: 40, height: 40)
                        VStack(alignment:.leading){
                            Text(item.object.clientname)
                                .foregroundColor(.black)
                                .font(.title3)
                            
                            HStack(alignment:.bottom){
                                if item.islove {
                                    VStack(alignment:.leading){
                                        Text("赞了你的笔记")
                                        Text("\(item.pyqcontent)")
                                    }
                                }else{
                                    VStack(alignment:.leading){
                                        Text("收藏了你的笔记")
                                        Text("\(item.pyqcontent)")
                                    }
                                }
                                Text((GetTime(date:item.time)))
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                            }
                        }
                        Spacer()
                        
                        PublicURLImageView(imageurl: item.pyqimageurl, contentmode: true)
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .frame(width: 100, height: 100)
                        }
                    }
                }
                .padding(.horizontal)
                }
            .navigationTitle("收到的赞和收藏")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.black)
                }
            }
            }
         
        }
    }


