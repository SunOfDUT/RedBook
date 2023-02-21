//
//  NewConcern.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/29.
//

import SwiftUI

struct NewConcern: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mynotdata : NoticeData
    @State var dates : Date = Date()
    func MyDateFormatter(dates: Date) -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-mm-dd"
        return dateformatter.string(from: dates)
    }
    var body: some View {
        NavigationView{
            ScrollView{
                
                ForEach(mynotdata.MyFans){ item in
                    if !item.ismutual{
                        HStack(spacing:5){
                            PublicURLImageView(imageurl: item.client.clientimage, contentmode: true)
                                .mask(Circle())
                                .frame(width: 50, height: 50)
                            
                            
                            VStack(alignment:.leading,spacing: 5){
                                Text(item.client.clientname)
                                HStack{
                                    Text("开始关注你了")
                                    Text(DateFormmatter(date:item.time))
                                }
                                .font(.footnote)
                                .foregroundColor(.gray)
                            }
                            Spacer()
                            
                            Button{
                                
                            }label: {
                                Text("回粉")
                                    .foregroundColor(Color("red"))
                                    .padding(.vertical,5)
                                    .padding(.horizontal,20)
                                    .background(.white)
                                    .padding(1)
                                    .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
                            }
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal,10)
                        
                        Divider()
                    }
                }
            }
            .navigationTitle("新增关注")
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

struct NewConcern_Previews: PreviewProvider {
    static var previews: some View {
        NewConcern()
    }
}
