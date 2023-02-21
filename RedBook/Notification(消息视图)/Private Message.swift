//
//  Private Message.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/29.
//

import SwiftUI

struct Private_Message: View {
    @Environment(\.presentationMode) var presentationMode
    @State var searchtext = ""
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Text("取消")
                            .font(.subheadline)
                    }
                    .frame(width:70)
                    Spacer()
                    Text("发私信")
                        .font(.title3)
                    Spacer()
                    Button{
                        
                    }label: {
                        Text("多人聊天")
                            .font(.subheadline)
                    }
                    .frame(width:70)
                }
                .padding(.horizontal,5)
                
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("搜索好友", text: $searchtext)
                    Spacer()
                }
                .foregroundColor(.gray)
                .padding(.vertical,5)
                .padding(.horizontal,3)
                .background(.gray.opacity(0.2),in: RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal,20)
                
            }
            .padding(.bottom,5)
            .background(.white)
            
            ScrollView{
                VStack(spacing:20){
                    HStack{
                        Text("全部关注")
                        Spacer()
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.horizontal,10)
                    
                    HStack(spacing:0){
                        Image("image1")
                            .CircleImage(width: 60)
                        Text("username")
                        Spacer()
                    }
                    .padding(.vertical,10)
                    .padding(.trailing,10)
                    .background(.white)
                    
                    HStack{
                        Text("A")
                        Spacer()
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.horizontal,10)
                    
                    HStack(spacing:0){
                        Image("image1")
                            .CircleImage(width: 60)
                        Text("username")
                        Spacer()
                    }
                    .padding(.vertical,10)
                    .padding(.trailing,10)
                    .background(.white)
                }
                
            }
            
        }
        .background(.gray.opacity(0.15))
        .foregroundColor(.black)
    }
}

struct Private_Message_Previews: PreviewProvider {
    static var previews: some View {
        Private_Message()
    }
}
