//
//  Test4.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/1.
//

import SwiftUI


struct Test4: View {
    @State var username = ""
    @State var password = ""
    @State var success = false
    @State var signupMode = false
    @AppStorage("islogin") var islogin = false
    
    var body: some View {
        ZStack{
            VStack(spacing:20){
                
                HStack{
                    Text("用户")
                    TextField("填写用户名...",text: $username)
                }
                .padding(.top)
                
                Divider()
                HStack{
                    Text("密码")
                    SecureField("填写密码...",text: $password)
                }
                Divider()
                
                Button{
                    
                }label: {
                HStack{
                    Spacer()
                    Text("注册")
                        .padding(10)
                        .font(.title3)
                    Spacer()
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 300)
                .background(.blue,in:RoundedRectangle(cornerRadius: 20))
                }
                
                Button{
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5)){
                        signupMode = false
                    }
                }label: {
                    HStack{
                        Text("注册完毕，点击登陆")
                            .foregroundColor(.gray)
                            .font(.footnote)
                        Spacer()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 120)
            .padding(.vertical)
            .padding(.horizontal,20)
            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
            .padding()
            .shadow(color: .gray.opacity(0.3), radius:30, x: 0, y: 20)
            .rotation3DEffect(.degrees(signupMode ? 0:180), axis: (x:10, y:0, z: 0))
            .opacity(signupMode ? 1:0)
            
            
            VStack(spacing:20){
                
                HStack{
                    Text("用户")
                    TextField("填写用户名...",text: $username)
                }
                .padding(.top)
                
                Divider()
                HStack{
                    Text("密码")
                    SecureField("填写密码...",text: $password)
                }
                Divider()
                
                Button{
                    
                }label: {
                HStack{
                    Spacer()
                    Text("登陆")
                        .padding(10)
                        .font(.title3)
                    Spacer()
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 300)
                .background(Color("red"),in:RoundedRectangle(cornerRadius: 20))
                }
                
                Button{
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5)){
                        signupMode = true
                    }
                }label: {
                    HStack{
                        Text("还没有账户？点击注册")
                            .foregroundColor(.gray)
                            .font(.footnote)
                        Spacer()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 120)
            .padding(.vertical)
            .padding(.horizontal,20)
            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
            .padding()
            .shadow(color: .gray.opacity(0.3), radius:30, x: 0, y: 20)
            .rotation3DEffect(.degrees(signupMode ? 180:0), axis: (x:10, y:0, z: 0))
            .opacity(signupMode ? 0:1)
        }
    }
}

struct Test4_Previews: PreviewProvider {
    static var previews: some View {
        Test4()
    }
}
