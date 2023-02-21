//
//  SignIn.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/3.
//

import SwiftUI
import Parse



struct SignIn: View {
    @State var username = ""
    @State var password = ""
    @State var signupMode = false
    @AppStorage("islogin") var islogin = false
    @State var ishover = false
    @State var isprogress = false
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var pyqdata : PYQData
    @State var showalert = false
    @State var alerttext = ""
    
    func SignUp(username:String,password:String){
        let user = PFUser()
        user.username = username
        user.password = password
        user["introduce"] = ""
        user["sex"] = "未知"
        user["locate"] = ""
        let image = UIImage(named: "image4")!
        let imagedata = image.pngData()!
        user["clientimage"] = PFFileObject(name: "image.png", data: imagedata)!
        user["clientbackground"] = PFFileObject(name: "image.png", data: imagedata)!
        user["school"] = "未知"
        user["brithday"] = Date()
        user["profession"] = "未知"
        user["concern"] = []
        user["fans"] = []
        user["love"] = []
        user["star"] = []
        user.signUpInBackground{ success,error in
            if(error == nil){
                print("注册成功")
                self.showalert = true
                self.alerttext = "注册成功"
            }
        }
    }
    
    func setNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (isallow,error) in
            if isallow{
                print("用户不同意通知")
            }else{
                print("用户同意通知")
            }
        }
    }
    
    func SignUpspect(username:String,password:String){
        guard username != "" && password != "" else{
            isprogress = false
            showalert = true
            alerttext = "用户名或密码不可以为空"
            return
        }
        // 要求用户名的长度至少为5 要求密码长度至少为8 且包含字母、数字
        guard username.count > 6 else{
            isprogress = false
            showalert = true
            alerttext = "用户名长度至少为5个字符"
            return
        }
        guard password.count > 8 else{
            isprogress = false
            showalert = true
            alerttext = "密码长度至少为8个字符"
            return
        }
        
        let chars = password.shuffled()
        let hasnumber = chars.contains{$0.isNumber == true}
        let hasText = chars.contains{$0.isLetter == true || $0.isCased == true}
        if hasnumber && hasText{
            SignUp(username: username, password: password)
        }else{
            isprogress = false
            showalert = true
            alerttext = "密码至少需要由8个字符组成,其中包括字母和数字。"
        }
    }
    
    
    func SignIn(username:String,password:String){
        guard username != "" && password != "" else{
            isprogress = false
            showalert = true
            alerttext = "密码和用户名不可以为空"
            return
        }
 
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            guard error == nil else{
                if error?.localizedDescription == "Invalid username/password."{
                    showalert = true
                    alerttext = "用户名不存在或密码不正确"
                }else if error?.localizedDescription == "Could not connect to the server."{
                    showalert = true
                    alerttext = "连接服务器错误,请稍后重试"
                }
                isprogress = false
                print("error\(error?.localizedDescription)")
                return
            }
            if(user != nil){
                withAnimation{
                    print("登陆成功")
                    let username = user!.objectId!
                    let clientname = user!.object(forKey: "username") as! String
                    let introduce = user!.object(forKey: "introduce") as! String
                    let sex = user!.object(forKey: "sex") as! String
                    let locate = user!.object(forKey: "locate") as! String
                    let clientimage = user!["clientimage"] as! PFFileObject
                    let backgrounimage = user!["clientbackground"] as! PFFileObject
                    let school = user!.object(forKey: "school") as! String
                    let brithday = user!.object(forKey: "brithday") as! Date
                    let profession = user!.object(forKey: "profession") as! String
                    Myclientdata.MyClient = Client(username: username, clientname: clientname, introduce: introduce, sex:sex, locate: locate, clientimage: clientimage.url!, clienbakground: backgrounimage.url!,school: school,brithday: brithday,profession: profession)
                    Myclientdata.datastore()
//                    pyqdata.downloading(currentpage: 0)
                    self.islogin = true
                    self.isprogress = false
                    setNotification()
                }
            }
        }
    }
    
    
    
    var body: some View {
        ZStack{
        VStack{
            HStack{
                Spacer()
                
                Button{
                    
                }label: {
                    Text("帮助")
                }
            }
            .foregroundColor(.gray)
            .padding()
            
            Color.clear.frame(height: 80)
            
            Image("sigin")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .padding()
            
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
                        withAnimation {
                            isprogress = true
                        }
                        SignUpspect(username: username, password: password)
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
                            username = ""
                            password = ""
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
                        withAnimation {
                            isprogress = true
                        }
                        SignIn(username: username, password: password)
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
                            username = ""
                            password = ""
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
                .rotation3DEffect(.degrees(signupMode ? 180:0), axis: (x:10, y:0, z: 0))
                .opacity(signupMode ? 0:1)
            }
            .shadow(color: .gray.opacity(0.3), radius:30, x: 0, y: 20)
            .onTapGesture {
                withAnimation {
                    self.ishover = true
                }
            }
          
           
            Spacer()
            
            Button{
                withAnimation {
                    
                }
            }label: {
                HStack{
                    Text("其他登陆方式")
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.gray)
                .font(.footnote)
            }
        }
            
            if isprogress{
                ZStack{
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView()
                        .foregroundColor(.white)
                        .scaleEffect(2)
                }
            }
        }
        .onChange(of: islogin, perform: { newValue in
            if newValue == true{
                withAnimation {
                    isprogress = false
                }
            }
        })
        .alert(isPresented: $showalert) {
            Alert(title: Text(alerttext), message: Text(""), dismissButton: Alert.Button.cancel(Text("确定")))}
        .alert(isPresented: $showalert) {
            Alert(title: Text(alerttext), message: Text(""), dismissButton: Alert.Button.cancel(Text("确定")))
        }
    }
}


struct SignIn_preview : PreviewProvider{
    static var previews: some View{
        SignIn()
            .environmentObject(ClientData(FromOutMyClient: initMyClientData()))
            .environmentObject(PYQData(allPyqData: initPqyData()))
    }
}
