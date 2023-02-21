//
//  ClientDetialView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/30.
//

import SwiftUI
struct ClientDetialView2: View {
    @State var ShowImagePicker = false
    @State var backgrounddata = Data()
    @State var scrollsize : CGFloat = 0
    @State var dragsize : CGFloat = 0
    @EnvironmentObject var Myclientdata  : ClientData
    var body: some View {
        VStack{
            VStack{
                VStack{
                NavigationLink{
                    EditIngView1(username:Myclientdata.MyClient.clientname)
                        .NavigationHidden()
                }label: {
                    HStack{
                        Text("名字")
                        Spacer()
                        Text(Myclientdata.MyClient.clientname)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
                Divider()
              
                HStack{
                    Text("小红书号")
                    Spacer()
                    Text(Myclientdata.MyClient.username)
                }
                .foregroundColor(.gray)
                .padding(10)
                .background(.white)
                
                Divider()
                NavigationLink{
                    EditIngView3(introduce:Myclientdata.MyClient.introduce)
                         .NavigationHidden()
                }label: {
                    HStack{
                        Text("简介")
                        Spacer()
                        Text(Myclientdata.MyClient.introduce)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
                }
                
                VStack{
                Divider()
                NavigationLink{
                    EditIngView4(sex:Myclientdata.MyClient.sex)
                         .NavigationHidden()
                }label: {
                    HStack{
                        Text("性别")
                        Spacer()
                        Text(Myclientdata.MyClient.sex)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
                Divider()
                NavigationLink{
                    EditIngView5()
                         .NavigationHidden()
                }label: {
                    HStack{
                        Text("生日")
                        Spacer()
                        Text(DateFormmatter2(date:Myclientdata.MyClient.brithday))
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
                Divider()
                NavigationLink{
                    EditIngView6(locate:Myclientdata.MyClient.locate)
                         .NavigationHidden()
                }label: {
                    HStack{
                        Text("地区")
                        Spacer()
                        Text(Myclientdata.MyClient.locate)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
                Divider()
                NavigationLink{
                    EditIngView7(profession:Myclientdata.MyClient.profession)
                         .NavigationHidden()
                }label: {
                    HStack{
                        Text("职业")
                        Spacer()
                        
                        Text(Myclientdata.MyClient.profession)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
            }
            }
            Divider()
            VStack{
                NavigationLink{
                    EditIngView8(school:Myclientdata.MyClient.school)
                         .NavigationHidden()
                }label: {
                    HStack{
                        Text("学校")
                        Spacer()
                        Text(Myclientdata.MyClient.school)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
                
                Divider()
                
                Button{
                    self.ShowImagePicker =  true
                }label: {
                    HStack{
                        Text("背景图")
                        Spacer()
                      
                        PublicURLImageView(imageurl: Myclientdata.MyClient.clienbakground, contentmode: true)
                         .frame(width: 50, height:50)
                         .clipped()
                        
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                   
                }
                Divider()
                NavigationLink{
                    EditIngView9()
                         .NavigationHidden()
                }label: {
                    HStack{
                        Text("头像挂件")
                        Spacer()
                        Text("暑假挂件")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
            }
        }
        .fullScreenCover(isPresented: $ShowImagePicker) {
            // ondismiss
            if(!backgrounddata.isEmpty){
//                Myclientdata.MyClient.clienbakground = backgrounddata
//                Myclientdata.datastore()
                Myclientdata.ServerSaveImage(ChangeName: "clientbackground", ChangeContent: backgrounddata)
            }
        }content:{
            PublicImagePicker(completeHandler: { image in
                guard image.first?.imagedata != nil else {return}
                self.backgrounddata = image.first!.imagedata!
            },ChoiceMode: false)
        }

    }
}

struct ClientDetialView: View{
    @Environment(\.presentationMode) var presentationMode
    @State var scrollsize : CGFloat = 0
    @State var dragsize : CGFloat = 0
    @EnvironmentObject var Myclientdata  : ClientData
    @State var ShowImagePicker = false
    @State var Imagedata = Data()
    @State var array2 = ["我的肤质","我的穿搭信息","二维码","成长等级"]
    @State var clientmessage2 = ["拍照侧肤","点击填写","qrcode","解锁登记",]
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing:20){
                    HStack{
                        Spacer()
                        Button{
                            self.ShowImagePicker = true
                        }label: {
                            PublicURLImageView(imageurl: Myclientdata.MyClient.clientimage, contentmode: true)
                            .mask(Circle())
                            .frame(width: 100, height: 100)
                            .clipped()
                            .overlay(
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        Image(systemName: "camera.fill")
                                            .foregroundColor(.black)
                                            .padding(5)
                                            .background(.gray,in:Circle())
                                            .padding(.top)
                                    }
                                }
                            )
                            .padding(.top,15)
                        }
                        Spacer()
                    }
                    ClientDetialView2()
                }
                .foregroundColor(.gray)
                .padding(.horizontal,10)
                .background(.white)
            }
            .background(.gray.opacity(0.1))
            .navigationTitle("编辑资料")
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
        .fullScreenCover(isPresented: $ShowImagePicker){
            if(!Imagedata.isEmpty){
                Myclientdata.ServerSaveImage(ChangeName: "clientimage", ChangeContent:Imagedata)
            }
        }content:{
            PublicImagePicker(completeHandler: { image in
                guard image.first?.imagedata != nil else {return}
                self.Imagedata = image.first!.imagedata!
            },ChoiceMode: false)
        }
        .alert(isPresented: $Myclientdata.saveresult) {
            Alert(title: Text("修改成功!"), message: Text(""), primaryButton: Alert.Button.cancel(Text("取消"),action: {
                Myclientdata.saveresult = false
            }), secondaryButton: Alert.Button.default(Text("确定"),action: {
                Myclientdata.saveresult = false
            }))
        }
    }
    
}

struct ClientDetialView_Previews: PreviewProvider {
    static var previews: some View {
        ClientDetialView()
    }
}
