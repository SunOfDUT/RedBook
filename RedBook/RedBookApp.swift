//
//  RedBookApp.swift
//  RedBook
//
//  Created by 孙志雄 on 2022/10/16.
//

import SwiftUI
import Parse
import BearComponent

@main
struct RedBook: App{
    @ObservedObject var mycarddatas : Model = Model(FromOutAllTags: initAllTags())
    init(){
        if mycarddatas.AllTags == []{
            self.mycarddatas.initdatastore()
        }
        let parseconfig = ParseClientConfiguration {
            $0.applicationId = "8888"
            $0.clientKey = "8888"
            // 替换自己的ip地址 或者改成 "http://localhost:1337/parse"
            $0.server = "http://10.201.43.126:1337/parse"
        }
        Parse.initialize(with: parseconfig)
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(Model(FromOutAllTags: initAllTags()))
                .environmentObject(ClientData(FromOutMyClient: initMyClientData()))
                .environmentObject(PYQData(allPyqData: initPqyData()))
                .environmentObject(SaveobjectData(SaveObject: initSaveObject()))
//            WaterFullView(data: [])
        }
        
    }
}

