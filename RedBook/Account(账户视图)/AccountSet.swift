//
//  AccountSet.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/30.
//

import SwiftUI

struct AccountSet: View {
    @State var array1 = ["过暑假","创作中心","我的草稿","浏览记录","钱包","免流量","好物体验"]
    @State var array2 = ["订单","购物车","卡劵","心愿单","小红卡会员"]
    var body: some View {
        VStack(spacing:0){
                ScrollView{
                    Color.clear.frame(height: 20)
                    VStack(alignment:.leading,spacing: 20){
                    NavigationLink{
                        FindFriend()
                            .NavigationHidden()
                    }label: {
                        Label("发现好友", systemImage: "person.badge.plus")
                    }
                    
                        
                    Divider()
                        VStack(alignment:.leading,spacing: 20){
                            NavigationLink{
                                
                            }label: {
                                Label("创作中心", systemImage: "person.badge.plus")
                            }
                            
                            NavigationLink{
                                
                            }label: {
                                Label("我的草稿", systemImage: "tray")
                            }
                            
                            NavigationLink{
                                
                            }label: {
                                Label("浏览记录", systemImage: "clock.arrow.circlepath")
                            }
                            
                            NavigationLink{
                                
                            }label: {
                                Label("钱包", systemImage: "creditcard")
                            }
                            
                        }
                   
                       
                        
                    Divider()
                        
                    NavigationLink{
                        
                    }label: {
                        Label("订单", systemImage: "doc.plaintext")
                    }
                    
                    NavigationLink{
                        
                    }label: {
                        Label("购物车", systemImage: "cart")
                    }
                    
                    NavigationLink{
                        
                    }label: {
                        Label("会员", systemImage: "yensign.circle")
                    }
                        
                    Divider()
                        
                        NavigationLink{
                            
                        }label: {
                            Label("社区公约", systemImage: "leaf")
                        }
                }
                .font(.system(size: 18))
                .padding(.leading,30)
            }
                .padding(.top)
                .frame(height:UIScreen.main.bounds.height * 4 / 5)
                .foregroundColor(.black)
                
               
            
            
            HStack{
                Spacer()
                NavigationLink{
                    AccountSet2()
                        .NavigationHidden()
                }label: {
                    VStack{
                        Image(systemName: "gearshape")
                            .padding(10)
                            .background(.gray.opacity(0.2),in: Circle())
                        Text("设置")
                        
                    }
                    .foregroundColor(.gray)
                }
                Spacer()
                
                NavigationLink{
                    
                }label: {
                    VStack{
                        Image(systemName: "airpodsmax")
                            .padding(10)
                            .background(.gray.opacity(0.2),in: Circle())
                        Text("帮组和客服")
                        
                    }
                    .foregroundColor(.gray)
                }
                
                Spacer()
                
                NavigationLink{
                    
                }label: {
                    VStack{
                        Image(systemName: "viewfinder")
                            .padding(10)
                            .background(.gray.opacity(0.2),in: Circle())
                        Text("扫一扫")
                        
                    }
                    .foregroundColor(.gray)
                }
                Spacer()
            }
            .frame(height:UIScreen.main.bounds.height / 8)
        }
        
        .frame(width:UIScreen.main.bounds.width * 2 / 3 ,height: UIScreen.main.bounds.height)
        .background(.white)
    }
}

struct AccountSet_Previews: PreviewProvider {
    static var previews: some View {
        AccountSet()
    }
}
