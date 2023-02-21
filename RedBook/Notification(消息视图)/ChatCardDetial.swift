//
//  ChatCardDetial.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/28.
//

import SwiftUI

struct ChatCardDetial: View {
    @State var mymessage : String = ""
    @State var Messages : [Message] = [
        Message(message: "你好", ismy: false),
        Message(message: "你好", ismy: true),
        Message(message: "你听了周杰伦的新歌吗", ismy: false),
        Message(message: "听了，很喜欢红颜如霜这首歌", ismy: true),
        Message(message: "巧了，我也很喜欢，旋律很好听", ismy: false),
        Message(message: "巧了，我也很喜欢，旋律很好听，我还很喜欢他的最伟大的作品这首歌，这首歌旋律我也很喜欢，还有粉丝海洋，也非常版", ismy: false),
    ]
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
        VStack{
            HStack{
              
                Button{
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Image(systemName: "chevron.left")
                }
               
                Spacer()
                Text("周杰伦")
                Spacer()
                
                NavigationLink{
                    ChatDetialSet()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }label: {
                    Image(systemName: "ellipsis")
                }
                
            
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            
            ScrollView{
                ForEach(Messages){ item in
                    if item.ismy{
                        HStack(spacing:0){
                            Spacer()
                            
                            Text(item.message)
                                .padding(.vertical,5)
                                .padding(.horizontal,10)
                                .foregroundColor(.white)
                                .background(.blue,in: RoundedRectangle(cornerRadius: 10))
                            Image("image2")
                                .CircleImage(width: 60)
                        }
                    }else{
                        HStack(spacing:0){
                            Image("image1")
                                .CircleImage(width: 60)
                            
                            Text(item.message)
                                .padding(.vertical,5)
                                .padding(.horizontal,10)
                                .background(.white,in: RoundedRectangle(cornerRadius: 5))
                            Spacer()
                        }
                    }
                }
            }
            .background(.gray.opacity(0.1))
            
            HStack{
                Image(systemName: "wave.3.right.circle")
                
                TextField("发消息....", text: $mymessage)
                    .padding(.horizontal,2)
                    .padding(.vertical,5)
                    .background(.white,in: RoundedRectangle(cornerRadius: 5))
                
                Image(systemName: "face.smiling")
                
                Image(systemName: "plus.circle")
            }
            .padding(.top,10)
            .padding(.horizontal,10)
            .background(.gray.opacity(0.1))
            
        }
        .background(.gray.opacity(0.1))
        .navigationBarHidden(true)
    }
      
}
}

struct Message : Identifiable{
    var id = UUID()
    var message : String
    var ismy : Bool
}
struct ChatCardDetial_Previews: PreviewProvider {
    static var previews: some View {
        ChatCardDetial()
    }
}
