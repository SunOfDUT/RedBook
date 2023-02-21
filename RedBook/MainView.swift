//
//  MainView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/28.
//

import SwiftUI


struct MainView: View {
    @EnvironmentObject var model : Model
    @AppStorage("islogin") var islogin = false
    var body: some View {
        if !islogin{
            SignIn()
        }else{
            switch model.select{
                case .home:
                    HomeView()
                        .environmentObject(NoticeData())
                case .shopping:
                    MusicView()
                        .environmentObject(NoticeData())
                case .not:
                    NotView()
                        .environmentObject(NoticeData())
                case .account:
                    AccountView()
                        .environmentObject(NoticeData())
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Model(FromOutAllTags: initAllTags()))
            .environmentObject(ClientData(FromOutMyClient: initMyClientData()))
            .environmentObject(PYQData(allPyqData: initPqyData()))
            .environmentObject(SaveobjectData(SaveObject: initSaveObject()))
            .environmentObject(PYQData(allPyqData: initPqyData()))
    }
}
