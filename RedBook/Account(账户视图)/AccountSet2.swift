//
//  AccountSet2.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/30.
//

import SwiftUI

struct AccountSet2: View {
    @Environment(\.presentationMode) var presentationMode
    @State var logoutMode = false
    @AppStorage("islogin") var islogin = false
    var body: some View {
        NavigationView{
            List{
                Section{
                    NavigationLink{
                        
                    }label: {
                        Text("账号与安全")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("隐私设置")
                    }
                }
                
                Section{
                    NavigationLink{
                        
                    }label: {
                        Text("通知设置")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("通用设置")
                    }
                }
                
                Section{
                    NavigationLink{
                        
                    }label: {
                        Text("青少年模式")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("深色模式")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("字体大小")
                    }
                }
                
                Section{
                    NavigationLink{
                        
                    }label: {
                        Text("帮助和客服")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("鼓励一下")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("个人信息收集清单")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("第三方信息共享清单")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("关于小红书")
                    }
                }
               
                Button{
                    withAnimation {
                       logoutMode = true
                    }
                }label: {
                    HStack{
                        Spacer()
                        Text("登出用户")
                        Spacer()
                    }
                    .foregroundColor(.red)
                }
               

            }
            .alert(isPresented: $logoutMode) {
                Alert(title: Text("确定要登出吗?"), message: Text(""), primaryButton: Alert.Button.cancel(Text("取消"),action: {
                    logoutMode = false
                }), secondaryButton: Alert.Button.default(Text("确定"),action: {
                    withAnimation {
                        logoutMode = false
                        UserDefaults.standard.removeObject(forKey: "Tags")
                        UserDefaults.standard.removeObject(forKey: "MyClient")
                        UserDefaults.standard.removeObject(forKey: "TmpSavedobjects")
                        islogin = false
                    }
                }))
            }
            .navigationTitle("设置")
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

struct AccountSet2_Previews: PreviewProvider {
    static var previews: some View {
        AccountSet2()
    }
}
