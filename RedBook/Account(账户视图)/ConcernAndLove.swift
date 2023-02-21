//
//  ConcernAndLove.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/12.
//

import SwiftUI
import Parse

struct ConcernAndLove: View {
    @EnvironmentObject var Myclientdata  : ClientData
    @State var select : Int = 0
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            VStack{
                HStack(spacing:30){
                    Button{
                        withAnimation {
                            select = 0
                        }
                    }label: {
                        Text("关注")
                            .foregroundColor(select == 0 ? .black:.gray)
                    }
                    
                    Button{
                        withAnimation {
                            select = 1
                        }
                    }label: {
                        Text("粉丝")
                            .foregroundColor(select == 1 ? .black:.gray)
                    }
                   
                   
                    Button{
                        withAnimation {
                            select = 2
                        }
                    }label: {
                        Text("推荐")
                            .foregroundColor(select == 2 ? .black:.gray)
                    }
                }
                .padding(.bottom,5)
                .overlay(
                    HStack{
                        if select == 2{
                            Spacer()
                        }
                        
                        VStack{
                            Spacer()
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 30, height: 3)
                                .foregroundColor(Color("red"))
                        }
                        
                        if select == 0{
                            Spacer()
                        }
                    }
                    .padding(.horizontal,3)
                )
                .padding(.bottom,6)
                
                
                TabView(selection: $select) {
                    myconcern()
                        .tag(0)
                    myfans()
                        .tag(1)
                    recommend()
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle(Myclientdata.MyClient.clientname)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .foregroundColor(.black)
        }
        
    }
}

struct myconcern : View{
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var mynotdata : NoticeData
    @State var searchtext = ""
    var body: some View{
        VStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("搜索已经关注的人", text: $searchtext)
            }
            .padding(6)
            .foregroundColor(.gray)
            .background(.gray.opacity(0.2),in: RoundedRectangle(cornerRadius: 20))
            
            ScrollView{
                VStack(alignment:.leading){
                    HStack{
                        Text("正在关注")
                            .padding(.vertical,10)
                        Spacer()
                    }
//
                    ForEach(mynotdata.Myconcern){ item in
                        concerncard(ismutable:item.ismutual,concerobject:item.client)
                    }
                }
            }
            .background(.white)
        }
    }
}

struct concerncard : View{
    @State var showalert : Bool = false
    @State var ismutable : Bool
    @State var concerobject : Client
    @EnvironmentObject var Myclientdata  : ClientData
    @State var isconcern = true
    
    func AddConcern(){
        let object = PFObject(className: "ConcernAndFans")
        object["Myobjectid"] = Myclientdata.MyClient.username
        object["objectid"] = concerobject.username
        object["Isshow"] = true
        object.saveInBackground()
    }
    
    func DeleteConcern(){
        let query = PFQuery(className: "ConcernAndFans")
        query.whereKey("Myobjectid", equalTo: Myclientdata.MyClient.username)
        query.whereKey("objectid", equalTo: concerobject.username)
        query.getFirstObjectInBackground { obj, error in
            if obj != nil{
                obj!["Isshow"] = false
                obj!.saveInBackground()
            }
        }
    }
    
    var body: some View{
        if isconcern{
        HStack(spacing:0){
            
            NavigationLink{
                
            }label: {
                PublicURLImageView(imageurl:concerobject.clientimage, contentmode: true)
                    .mask(Circle())
                    .frame(width: 50, height: 50)
                
                VStack(alignment:.leading,spacing: 5){
                    Text(concerobject.clientname)
                    
                    HStack{
                        Text("简介")
                        Text(concerobject.introduce)
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                }
                Spacer()
            }
            
           
            Button{
                withAnimation {
                    showalert = true
                }
            }label: {
                Text(ismutable ?  "互相关注":"已关注")
                    .foregroundColor(.gray)
                    .padding(.vertical,5)
                    .padding(.horizontal,20)
                    .background(.white)
                    .padding(1)
                    .background(.gray,in: RoundedRectangle(cornerRadius: 20))
            }
            }
        .alert(isPresented: $showalert){
            Alert(title: Text("确认不再关注?"), primaryButton: Alert.Button.cancel(Text("取消")), secondaryButton: Alert.Button.destructive(Text("确认"),action: {
                    DeleteConcern()
                    withAnimation {
                        isconcern = false
                    }
            }))
        }
        }
       
    }
}

struct myfans : View{
    @EnvironmentObject var mynotdata : NoticeData
    var body: some View{
        ScrollView{
            ForEach(mynotdata.MyFans){ item in
                myfanscard(ismuable: item.ismutual,myfansobject:item.client)
            }
        }
    }
}

struct myfanscard : View{
    @State var showalert : Bool = false
    @State var ismuable : Bool
    @State var myfansobject : Client
    @EnvironmentObject var Myclientdata  : ClientData
    
    func AddConcern(){
        let object = PFObject(className: "ConcernAndFans")
        object["Myobjectid"] = Myclientdata.MyClient.username
        object["objectid"] = myfansobject.username
        object["Isshow"] = true
        object.saveInBackground()
    }
    func DeleteConcern(){
        let query = PFQuery(className: "ConcernAndFans")
        query.whereKey("Myobjectid", equalTo: Myclientdata.MyClient.username)
        query.whereKey("objectid", equalTo: myfansobject.username)
        query.getFirstObjectInBackground { obj, error in
            if obj != nil{
                obj!["Isshow"] = false
                obj!.saveInBackground()
            }
        }
    }
    
    var body: some View{
        HStack(spacing:0){
            NavigationLink{
                
            }label: {
                PublicURLImageView(imageurl: myfansobject.clientimage, contentmode: true)
                    .mask(Circle())
                    .frame(width: 50, height: 50)
                
                VStack(alignment:.leading,spacing: 5){
                    Text(myfansobject.clientname)
                    HStack{
                        Text("粉丝")
                        
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                }
                Spacer()
            }
            
         
                if !ismuable{
                    Button{
                        // 添加粉丝
                        AddConcern()
                    }label: {
                        Text("回粉")
                            .foregroundColor(Color("red"))
                            .padding(.vertical,5)
                            .padding(.horizontal,20)
                            .background(.white)
                            .padding(1)
                            .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
                    }
                }else{
                    Button{
                        withAnimation {
                            showalert = true
                        }
                    }label: {
                        Text("互相关注")
                            .foregroundColor(.gray)
                            .padding(.vertical,5)
                            .padding(.horizontal,20)
                            .background(.white)
                            .padding(1)
                            .background(.gray,in: RoundedRectangle(cornerRadius: 20))
                    }
                }
        }
        .alert(isPresented: $showalert){
            Alert(title: Text("确认不再关注?"), primaryButton: Alert.Button.cancel(Text("取消")), secondaryButton: Alert.Button.destructive(Text("确认"),action: {
                // 脱粉
                DeleteConcern()
            }))
        }
    }
}

struct recommend : View{
    var body: some View{
        ScrollView{
            ForEach(0..<6){ item in
                HStack(spacing:0){
                    NavigationLink{
                        
                    }label: {
                        Image("image1")
                            .CircleImage(width: 50)
                        
                        VStack(alignment:.leading,spacing: 5){
                            Text("username")
                            
                            HStack{
                                Text("粉丝")
                                Text("\(1)")
                            }
                            .font(.footnote)
                            .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                 
                    
                    Button{
                        
                    }label: {
                        Text("关注")
                            .foregroundColor(Color("red"))
                            .padding(.vertical,5)
                            .padding(.horizontal,20)
                            .background(.white)
                            .padding(1)
                            .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
                            .padding(.trailing)
                    }
                   
                    Button{
                        
                    }label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}


