//
//  CommentView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/29.
//

import SwiftUI

struct CommentView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mynotdata : NoticeData
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment:.leading){
                ForEach(mynotdata.MyPinLun){ item in
                    Divider()
                    HStack(alignment:.top){
                        PublicURLImageView(imageurl: item.objectimageurl, contentmode: true)
                            .mask(Circle())
                            .frame(width: 50, height: 50)
                        
                        VStack(alignment:.leading){
                            Text(item.objectname)
                                .foregroundColor(.black)
                                .font(.title3)
                            HStack(alignment:.top){
                                Text("回复你:\(item.pinluncontent):\(item.pinlun)")
                                Text("\(GetTime(date:item.pinluntime))前")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                  
                }
                }
                .padding(.horizontal)
            }
            .navigationTitle("收到的评论和@")
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

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
