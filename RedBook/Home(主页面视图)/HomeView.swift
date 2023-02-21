//
//  HomeView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/7.
//

import SwiftUI
import Parse

struct HomeView: View {
    @Namespace var namespace
    @State var selcet = 1
    @State var isshowdetial = false
    @State var showConcernviewdetial = false
    @State var isshow = false
    @State var showShare : Bool = false
    @State var showContend  : Bool = false
    @State var showaccountdetial : Bool = false
    @State var showanimation : [Bool] = [false,false,false,false,false,false]
    @State var showsearch : Bool = false
    @State var DragValue : CGFloat = 0
    @State var isshow2 = false
    @EnvironmentObject var pyqdata : PYQData
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var mycarddatas : Model
    

    
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    Color.clear.frame(height: 40)
                        HStack{
                            Button{
                                withAnimation {
                                    showConcernviewdetial = true
                                }
                            }label: {
                                Image(systemName: "globe.americas")
                            }
                            
                            Spacer()
                            HStack(spacing:15){
                                    Button{
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5)){
                                            selcet = 0
                                        }
                                    }label: {
                                        Text("关注")
                                            .foregroundColor(selcet == 0 ? .black: .gray)
                                    }
                                    
                                    Button{
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5)){
                                            selcet = 1
                                        }
                                       
                                    }label:{
                                        Text("发现")
                                            .foregroundColor(selcet == 1 ? .black: .gray)
                                    }
                                    
                                    Button{
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5)){
                                            selcet = 2
                                        }
                                    }label: {
                                        Text("附近")
                                            .foregroundColor(selcet == 2 ? .black: .gray)
                                    }
                                }
                                .padding(.bottom,5)
                                .overlay(
                                    HStack{
                                        
                                        if selcet == 2{
                                            Spacer()
                                        }
                                        
                                        VStack{
                                            Spacer()
                                            RoundedRectangle(cornerRadius: 20)
                                                .frame(width: 30, height: 3)
                                                .foregroundColor(Color("red"))
                                        }
                                        
                                        if selcet == 0{
                                            Spacer()
                                        }
                                    }
                                    .padding(.horizontal,3)
                                )
                            Spacer()
                            
                            Button{
                                withAnimation {
                                    showsearch = true
                                }
                            }label: {
                                Image(systemName: "magnifyingglass")
                            }
                        }
                            .foregroundColor(.black)
                            .padding(.horizontal,10)
                            .padding(.vertical,5)
                        
                        Divider()
                        
                        TabView(selection:$selcet){
                            ConcernView(isshow: $showConcernviewdetial,showShare: $showShare,showContend: $showContend,showaccountdetial: $showaccountdetial,showanimation: $showanimation)
                                .tag(0)

                            FaXianView(namespace: namespace, isshow: $isshow2, isshowdetial: $isshowdetial)
                                .tag(1)

                            NearView(namespace: namespace,isshowdetial: $isshowdetial)
                                .tag(2)
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                       
                        Tabbar()
                }
                  .edgesIgnoringSafeArea(.bottom)
                  .navigationBarHidden(true)
                  .FullScreenOfLeftCard(isPresented: $showConcernviewdetial,content: {
                      Concernviewdetial(showConcernviewdetial: $showConcernviewdetial)
                          .NavigationHidden()
                  })
                  .FullScreenCard(isPresented: $showsearch) {
                      SearchView(showsearch: $showsearch)
                          .NavigationHidden()
                  }
                  .onAppear{
                      pyqdata.downloading(currentpage: 1)
                  }
            }
    }
 }
}


struct HomeViewView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model(FromOutAllTags: initAllTags()))
            .environmentObject(PYQData(allPyqData: initPqyData()))
            .environmentObject(Model(FromOutAllTags: initAllTags()))
    }
}
