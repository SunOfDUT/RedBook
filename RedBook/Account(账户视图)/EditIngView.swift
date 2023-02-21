//
//  EditIngView1.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/4.
//

import SwiftUI
import Parse

struct EditIngView1: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var Myclientdata  : ClientData
    @State var username : String = ""
    @State var haseEdit = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    TextField("", text: $username)
                        .onChange(of: username) { newValue in
                            if(Myclientdata.MyClient.clientname != newValue){
                                withAnimation {
                                    haseEdit = true
                                }
                            }
                        }
                }
                .padding(15)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.bottom,5)
                HStack{
                    Text("请设置2-24个字符，不包括特殊符号")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Spacer()
                }
                
                Spacer()
               
            }
            .padding()
            .background(.gray.opacity(0.1))
            .navigationTitle("编辑名字")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Text("取消")
                    }
                    .foregroundColor(.black)
                }
              
                ToolbarItem(placement: .navigationBarTrailing) {
                    if haseEdit{
                        Button{
                            Myclientdata.MyClient.clientname = username
                            Myclientdata.datastore()
                             Myclientdata.ServerSave(ChangeName: "username", ChangeContent: username)
                        }label: {
                            Text("保存")
                        }
                        .foregroundColor(Color("red"))
                    }else{
                        Text("保存")
                            .foregroundColor(Color("red").opacity(0.5))
                    }
              
                }
            }
            .alert(isPresented: $Myclientdata.saveresult){
                Alert(title: Text("保存成功"), primaryButton: Alert.Button.cancel(Text("取消"), action: {
                    Myclientdata.saveresult = false
                    presentationMode.wrappedValue.dismiss()
                }), secondaryButton: Alert.Button.default(Text("确定"), action: {
                    presentationMode.wrappedValue.dismiss()
                    Myclientdata.saveresult = false
                }))
            }
        }
    }
}

struct EditIngView3: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var Myclientdata  : ClientData
    @State var introduce = ""
    @State var haseEdit = false
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                   TextEditor(text: $introduce)
                        .onChange(of: introduce) { newValue in
                            if(Myclientdata.MyClient.introduce != newValue){
                                haseEdit = true
                            }
                        }
                }
                .frame(height:100)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.bottom,5)
                HStack{
                    Text("请设置2-24个字符，不包括特殊符号")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Spacer()
                }
                
                Spacer()
               
            }
            .padding()
            .background(.gray.opacity(0.1))
            .navigationTitle("编辑简介")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Text("取消")
                    }
                    .foregroundColor(.black)
                }
              
                ToolbarItem(placement: .navigationBarTrailing) {
                    if haseEdit{
                        Button{
                            Myclientdata.MyClient.introduce = introduce
                            Myclientdata.datastore()
                            Myclientdata.ServerSave(ChangeName: "introduce", ChangeContent: introduce)
                        }label: {
                            Text("保存")
                        }
                        .foregroundColor(Color("red"))
                    }else{
                        Text("保存")
                            .foregroundColor(Color("red").opacity(0.5))
                    }
                }
            }
            .alert(isPresented: $Myclientdata.saveresult){
                Alert(title: Text("保存成功"), primaryButton: Alert.Button.cancel(Text("取消"), action: {
                    Myclientdata.saveresult = false
                    presentationMode.wrappedValue.dismiss()
                }), secondaryButton: Alert.Button.default(Text("确定"), action: {
                    presentationMode.wrappedValue.dismiss()
                    Myclientdata.saveresult = false
                }))
            }
        }
    }
}


struct EditIngView4: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var Myclientdata  : ClientData
    @State var sex = ""
    @State  var IsShowSex = false
    var body: some View {
        NavigationView{
            VStack{
                
                HStack{
                    Text("选择你的性别")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Spacer()
                }
                
                VStack{
                    Button{
                        sex = "男"
                        Myclientdata.MyClient.sex = sex
                        Myclientdata.datastore()
                        Myclientdata.ServerSave(ChangeName: "sex", ChangeContent: sex)
                    }label: {
                        HStack{
                            Text("男")
                            Spacer()
                            if sex == "男"{
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color("red"))
                            }
                            
                        }
                    }
                    
                    Divider()
                    
                    Button{
                        sex = "女"
                        Myclientdata.MyClient.sex = sex
                        Myclientdata.datastore()
                        Myclientdata.ServerSave(ChangeName: "sex", ChangeContent: sex)
                    }label: {
                        HStack{
                            Text("女")
                            Spacer()
                            if sex == "女"{
                            Image(systemName: "checkmark")
                                .foregroundColor(Color("red"))
                            }
                        }
                    }
                }
                .foregroundColor(.black)
                .padding(15)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.vertical,5)
                
                HStack{
                    Text("是否在个人主页展示")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Spacer()
                }
                
                HStack{
                    Toggle("展示性别标签", isOn: $IsShowSex)
                }
                .tint(Color("red"))
                .padding(15)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                
                Spacer()
               
            }
            .padding()
            .background(.gray.opacity(0.1))
            .navigationTitle("编辑性别")
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

struct EditIngView5: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var Myclientdata  : ClientData
    @State var select = 1
    @State  var IsShowSex = false
    @State var showpicker = false
    @State var newbirthday : Date = Date()
    var body: some View {
        NavigationView{
            VStack{
                
                Button{
                    withAnimation {
                        showpicker = true
                    }
                }label: {
                    HStack{
                        Text("生日信息")
                        Spacer()
                        Text(DateFormmatter2(date:Myclientdata.MyClient.brithday))
                    }
                    .padding(15)
                    .background(.white,in: RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom)
                }
                
                HStack{
                    Text("是否在个人主页展示")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Spacer()
                }
                .padding(.leading)
                
                HStack{
                    Toggle("展示生日标签", isOn: $IsShowSex)
                }
                .tint(Color("red"))
                .padding(10)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.bottom)
                
                VStack{
                    Button{
                       select = 1
                    }label: {
                        HStack{
                            Text("展示年龄")
                            Spacer()
                            if select == 1{
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color("red"))
                            }
                            
                        }
                    }
                    
                    Divider()
                    
                    Button{
                       select = 2
                    }label: {
                        HStack{
                            Text("展示星座")
                            Spacer()
                            if select == 2{
                            Image(systemName: "checkmark")
                                .foregroundColor(Color("red"))
                            }
                        }
                    }
                }
                .foregroundColor(.black)
                .padding(15)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.vertical,5)
                
                Spacer()
            }
            .padding()
            .background(.gray.opacity(0.1))
            .navigationTitle("编辑生日")
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
        .SheetBottomView(isPresented: $showpicker) {
            
        }content:{
            VStack{
                HStack{
                    DatePicker("挑选生日", selection: $newbirthday,displayedComponents: .date)
                        .datePickerStyle(.automatic)
                }
                
                HStack{
                    Button{
                        withAnimation {
                            showpicker = false
                            Myclientdata.MyClient.brithday = newbirthday
                            Myclientdata.datastore()
                            Myclientdata.ServerSave(ChangeName:"brithday", ChangeContent: newbirthday)
                        }
                    }label: {
                        Text("确定")
                            .foregroundColor(.white)
                            .frame(width: 80, height: 30)
                            .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
                           
                    }
                    
                    Button{
                        withAnimation {
                            showpicker = false
                            
                        }
                    }label: {
                        Text("取消")
                            .foregroundColor(.white)
                            .frame(width: 80, height: 30)
                            .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
                           
                    }
                }
            }
            .padding()
            .background(.white)
            .padding(.bottom)
        }
    }
}


struct EditIngView6: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var locate = ""
    @State var showpicker = false
    @State var IsShow = true
    var body: some View {
        NavigationView{
            VStack{
                Button{
                    withAnimation {
                        showpicker = true
                    }
                }label: {
                    HStack{
                        Text("地区")
                        Spacer()
                        Text(locate)
                    }
                    .padding(15)
                    .background(.white,in: RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom)
                }
               
                
                HStack{
                    Text("是否在个人主页展示")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Spacer()
                }
                .padding(.leading)
                
                HStack{
                    Toggle("展示地区标签", isOn: $IsShow)
                }
                .tint(Color("red"))
                .padding(10)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.bottom)
                
                Spacer()
               
            }
            .padding()
            .background(.gray.opacity(0.1))
            .navigationTitle("编辑地区")
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
            .SheetBottomView(isPresented: $showpicker) {
                
            } content: {
                
            }

        }
    }
}


struct EditIngView7: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var Myclientdata  : ClientData
    @State var profession = ""
    @State var IsShow = false
    @State var haseEdit = false
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("职业")
                    Spacer()
                    TextField("", text: $profession)
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
                    Toggle("展示职业标签", isOn: $IsShow)
                }
                .tint(Color("red"))
                .padding(10)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.bottom)
                
                Spacer()
               
            }
            .padding()
            .background(.gray.opacity(0.1))
            .navigationTitle("编辑职业")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: profession, perform: { newValue in
                if newValue != Myclientdata.MyClient.profession{
                    haseEdit = true
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if haseEdit{
                        Button{
                            Myclientdata.MyClient.profession = profession
                            Myclientdata.datastore()
                            Myclientdata.ServerSave(ChangeName: "profession", ChangeContent: Myclientdata.MyClient.profession)
                        }label: {
                            Text("保存")
                        }
                        .foregroundColor(Color("red"))
                    }else{
                        Text("保存")
                            .foregroundColor(Color("red").opacity(0.5))
                    }
              
                }
            }
        }
    }
}


struct EditIngView8 : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var Myclientdata  : ClientData
    @State var school = ""
    @State var schooltime = ""
    @State var IsShow = false
    @State var haseEdit = false
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("学校")
                    Spacer()
                    TextField("", text: $school)
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
            .onChange(of: school, perform: { newValue in
                if newValue != Myclientdata.MyClient.school{
                    haseEdit = true
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if haseEdit{
                        Button{
                            Myclientdata.MyClient.school = school
                            Myclientdata.datastore()
                            Myclientdata.ServerSave(ChangeName: "school", ChangeContent: Myclientdata.MyClient.school)
                        }label: {
                            Text("保存")
                        }
                        .foregroundColor(Color("red"))
                    }else{
                        Text("保存")
                            .foregroundColor(Color("red").opacity(0.5))
                    }
              
                }
            }
        }
    }
}


struct EditIngView9: View {
    @Environment(\.presentationMode) var presentationMode
    @State var IsShow = false
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("是否在个人主页展示头像挂件")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Spacer()
                }
                .padding(.leading)
                
                HStack{
                    Toggle("展示头像挂件", isOn: $IsShow)
                }
                .tint(Color("red"))
                .padding(10)
                .background(.white,in: RoundedRectangle(cornerRadius: 10))
                .padding(.bottom)
                
                Spacer()
               
            }
            .padding()
            .background(.gray.opacity(0.1))
            .navigationTitle("头像挂件")
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
