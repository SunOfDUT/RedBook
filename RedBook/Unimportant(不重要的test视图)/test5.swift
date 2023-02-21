//
//  test5.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/4.
//

import SwiftUI

struct test5: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var Myclientdata  : ClientData
    @State var school = ""
    @State var schooltime = ""
    @State var IsShow = false
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("学校")
                    Spacer()
                    Text(school)
                }
                .padding(15)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.bottom)
                
                HStack{
                    Text("入学时间")
                    Spacer()
                    Text(schooltime)
                }
                .padding(15)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.bottom)
                
                HStack{
                    Text("是否在个人主页展示")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Spacer()
                }
                .padding(.leading)
                
                HStack{
                    Toggle("展示学校标签", isOn: $IsShow)
                }
                .tint(Color("red"))
                .padding(10)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.bottom)
                
                Spacer()
               
            }
            .padding()
            .background(.gray.opacity(0.1))
            .navigationTitle("编辑学校")
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

struct test5_Previews: PreviewProvider {
    static var previews: some View {
        test5()
    }
}
