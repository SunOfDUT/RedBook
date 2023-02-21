//
//  FindFriend.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/12.
//

import SwiftUI

struct FindFriend: View {
    @Environment(\.presentationMode) var  presentationMode
    var body: some View {
        NavigationView{
            ScrollView{
                
                NavigationLink{
                    
                }label: {
                    HStack{
                        Image(systemName: "person.crop.rectangle.fill")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.blue,in: Circle())
                        Text("通讯录好友")
                        Spacer()
                        Text("寻找好友")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.right")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                   
                }
                .padding(.top)
                
                HStack{
                    Text("你可能认识的人")
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.top)
                
                ForEach(0..<10){ item in
                    HStack(spacing:0){
                        Image("image1")
                            .CircleImage(width: 50)
                        
                        VStack(alignment:.leading,spacing: 5){
                            Text("username")
                            HStack{
                                Text("开始关注你了")
                                Text(DateFormmatter(date: Date()))
                            }
                            .font(.footnote)
                            .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        Text("回粉")
                            .foregroundColor(Color("red"))
                            .padding(.vertical,5)
                            .padding(.horizontal,20)
                            .background(.white)
                            .padding(1)
                            .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.trailing,10)
                    
                    Divider()
                }
               
            }
            .padding(.horizontal)
            .foregroundColor(.black)
            .navigationTitle("发现好友")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content:{
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.black)
                })
            }
        }
    }
}

struct FindFriend_Previews: PreviewProvider {
    static var previews: some View {
        FindFriend()
    }
}
