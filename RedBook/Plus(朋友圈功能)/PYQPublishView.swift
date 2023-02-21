//
//  PYQPublishView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/10.
//

import SwiftUI
import Parse
import Photos
struct PYQPublishView: View {
    @State var mytitle = ""
    @State var mycontent = ""
    @State var Columns = Array(repeating:GridItem(.flexible(minimum: 20, maximum: 50), spacing: 55, alignment: .center), count: 4)
    @State var images : [myimage]
    @Environment(\.presentationMode) var presentationMode
    @State var isSave = false
    @State var showImageEdit = false
    @State var showimagepicke = false
    @State var locate : String = ""
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var pyqdata : PYQData
    @EnvironmentObject var mySaveobject : SaveobjectData
    @State var alertText = ""
    @State var showalert = false
    var imageManager:PHCachingImageManager = PHCachingImageManager()
    @State var pickeimage : [myimage] = []
    
    func GetRealImage(){
        let options = PHImageRequestOptions()
        options.resizeMode = .exact
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        for i in images{
            if i.ischeck{
                if i.assset != nil{
                    self.imageManager.requestImageDataAndOrientation(for: i.assset!, options: options){data, asdi, asdb, asdc in
                        self.pickeimage.append(myimage(image:i.image,ischeck:i.ischeck,assset:i.assset, imagedata:data))
                        print(pickeimage)
                    }
                }else{
                    self.pickeimage.append(myimage(image:i.image,ischeck:i.ischeck,assset:i.assset,imagedata:i.imagedata))
                }
               
            }
        }
    }

    var body: some View {
        VStack{
        ScrollView{
            VStack(spacing:18){
                HStack{
                    Button{
                        showImageEdit = true
                    }label: {
                        Image(systemName: "chevron.left")
                    }
                   
                    Spacer()
                    
                    Button{
                        showimagepicke = true
                    }label: {
                        Image(systemName: "plus")
                    }
                    Button{
                        
                    }label: {
                        Image(systemName: "exclamationmark.circle")
                    }
                }
                .padding()
                .foregroundColor(.gray)
                
                
                LazyVGrid(columns:Columns){
                    ForEach(Array(images.enumerated()), id:\.offset){ count,item in
                        if item.ischeck{
                            Image(uiImage: item.image!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width / 4 - 5,height: UIScreen.main.bounds.width / 4 - 5)
                                    .mask(RoundedRectangle(cornerRadius: 10))
                                    .clipped()
                                    .overlay(
                                        Button{
                                            withAnimation {
                                                images[count].ischeck.toggle()
                                            }
                                        }label: {
                                            Image(systemName: "xmark")
                                                .font(.footnote)
                                                .foregroundColor(.white)
                                                .padding(5)
                                                .background(.black.opacity(0.5),in: Circle())
                                                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topTrailing)
                                                .padding(8)
                                        }
                                    )
                            }
                    }
                    }
                }
                
                TextField("填写标题会获得更多赞哦~", text: $mytitle)
                    .padding()
                    .foregroundColor(.black)
                
                Divider()
                
                TextEditor(text: $mycontent)
                    .frame(height: 140)
                    .padding()
                    .foregroundColor(.black)
                
                Divider()
                
                HStack{
                    Image(systemName: "location")
                    TextField("添加地点", text: $locate)
                        .foregroundColor(.black)
                    Spacer()
                }
                .foregroundColor(.black)
                .padding()
                Divider()
                HStack{
                    Spacer()
                    Label("保存到相册", systemImage: isSave ?  "checkmark.circle.fill":"circle")
                        .foregroundColor(isSave ? .black:.gray)
                        .onTapGesture {
                            self.isSave.toggle()
                        }
                }
                .padding()
                
            }
            
            HStack{
                Button{
                    
                    GetRealImage()
                    if self.mytitle != "" && self.mycontent != "" && pickeimage != []{
                        mySaveobject.Saveobjects = saveobject(mysavedimage:mySaveobject.convert(image:pickeimage), mypyqmessage: Carddata(title: mytitle, content: mycontent, locate:locate, publishtime:Date(),publishimageurl: [], pinlun: [],love:0,star:0,pyqobjectid : "",client : Client(username: "", clientname: "", introduce: "", sex: "", locate: "", clientimage: "", clienbakground: "", school: "", brithday: Date(), profession: "")))
                        mySaveobject.saveMyPyq()
                        showalert = true
                        alertText = "保存成功!"
                    }else{
                        showalert = true
                        alertText =  "内容不可以为空!"
                    }
//                    })
                }label:{
                    Text("存草稿")
                        .font(.footnote)
                }
                .foregroundColor(.black)
                
                Spacer()
               
                
                
                Button{
                    GetRealImage()
                    if self.mytitle != "" && self.mycontent != "" &&  pickeimage != []{
                        print(pickeimage)
                        showalert = true
                        pyqdata.UpLoadMyPyq(data:
                                            Carddata(title: mytitle, content: mycontent, locate:locate, publishtime:Date(),publishimageurl: [], pinlun: [],love:0,star:0,pyqobjectid : "",client: Client(username: "", clientname: "", introduce: "", sex: "", locate: "", clientimage: "", clienbakground: "", school: "", brithday: Date(), profession: ""))
                                            , image:pickeimage,objectid: Myclientdata.MyClient.username)
                        print(pyqdata.alerttext)
                        if pyqdata.alerttext != ""{
                            alertText = pyqdata.alerttext
                        }else{
                            alertText = "发表成功!"
                        }
                       
                    }else{
                        showalert = true
                        alertText = "内容不可以为空!"
                    }
                }label: {
                    Text("发布")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 2 / 3 + 50, height: 40)
                        .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding(.horizontal)
        }
        .background(.gray.opacity(0.1))
        .fullScreenCover(isPresented: $showimagepicke) {
            PublicImagePicker(select: self.images.count){ image in
                images.append(contentsOf: image)
            }
        }
        .confirmationDialog("", isPresented: $showImageEdit) {
            Button(role:.cancel){
                withAnimation {
                    if self.mytitle != "" && self.mycontent != "" && pickeimage != []{
                        mySaveobject.Saveobjects =  saveobject(mysavedimage:mySaveobject.convert(image:pickeimage), mypyqmessage: Carddata(title: mytitle, content: mycontent, locate:locate, publishtime:Date(),publishimageurl: [], pinlun: [],love:0,star:0,pyqobjectid : "",client : Client(username: "", clientname: "", introduce: "", sex: "", locate: "", clientimage: "", clienbakground: "", school: "", brithday: Date(), profession: "")))
                        mySaveobject.saveMyPyq()
                        presentationMode.wrappedValue.dismiss()
                    }else{
                        showalert = true
                        alertText = "内容不可以为空"
                    }
                }
            }label: {
                Text("保存并离开")
            }
            Button(role:.destructive){
                withAnimation {
                    mySaveobject.Saveobjects = saveobject(mysavedimage: [], mypyqmessage: Carddata(title: "", content: "", locate: "", publishtime: Date(), publishimageurl: [], pinlun: [], love: 0, star: 0, pyqobjectid: "", client:  Client(username: "", clientname: "", introduce: "", sex: "", locate: "", clientimage: "", clienbakground: "", school: "", brithday: Date(), profession: "")))
                    mySaveobject.saveMyPyq()
                    presentationMode.wrappedValue.dismiss()
                }
            }label: {
                Text("不保存离开")
            }
        }
        .alert(isPresented: $showalert, content: {
            Alert(title: Text(alertText), message:Text(""), dismissButton: Alert.Button.cancel(Text("确定"),action: {
                switch alertText{
                    case "发表成功!":
                        presentationMode.wrappedValue.dismiss()
                        mySaveobject.Saveobjects = saveobject(mysavedimage: [], mypyqmessage: Carddata(title: "", content: "", locate: "", publishtime: Date(), publishimageurl: [], pinlun: [], love: 0, star: 0, pyqobjectid: "", client:  Client(username: "", clientname: "", introduce: "", sex: "", locate: "", clientimage: "", clienbakground: "", school: "", brithday: Date(), profession: "")))
                        return
                    case "内容不可以为空!":
                        return
                    case "内容不可以为空":
                        presentationMode.wrappedValue.dismiss()
                        return
                    case "保存成功!":
                        presentationMode.wrappedValue.dismiss()
                        return
                    default:
                        return
                }
            }))
        })
    }

}
