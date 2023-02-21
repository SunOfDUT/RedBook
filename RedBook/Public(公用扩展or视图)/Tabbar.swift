//
//  Tabbar.swift

import SwiftUI

enum Selcetion{
    case home
    case shopping
    case not
    case account
}

struct Tabbar: View {
    @EnvironmentObject var model : Model
    @EnvironmentObject var mySaveobject : SaveobjectData
    @State var showplusview = false
    @State var showplishview = false
    var body: some View {
        HStack{
            
            HStack{
                Spacer()
                Button{
                    model.select = .home
                }label: {
                    Text("首页")
                }
                .foregroundColor(model.select == .home ? .black : .gray)
                
                Spacer()
                
                Button{
                    model.select = .shopping
                    
                }label: {
                    Text("看看")
                }
                .foregroundColor(model.select ==  .shopping ? .black : .gray)
                
                Spacer()
            }
  
            
            Button{
                withAnimation {
                    if mySaveobject.Saveobjects.mysavedimage == [] && mySaveobject.Saveobjects.mypyqmessage.content == "" && mySaveobject.Saveobjects.mypyqmessage.title == ""{
                        showplusview = true
                    }else{
                        showplishview = true
                    }
                }
            }label: {
                Image(systemName: "plus")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal,18)
                    .background(.red,in: RoundedRectangle(cornerRadius: 8))
            }
            
            HStack{
                Spacer()
                
                Button{
                    model.select = .not
                }label: {
                    Text("消息")
                }
                .foregroundColor(model.select == .not ? .black : .gray)
            
                Spacer()
                
                Button{
                    model.select = .account
                }label: {
                    Text("我")
                }
                .foregroundColor(model.select == .account ? .black : .gray)
                Spacer()
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, height:80)
        .fullScreenCover(isPresented: $showplusview) {
                PlusView(showplusview: $showplusview)
                    
        }
        .fullScreenCover(isPresented: $showplishview) {
            PYQPublishView(mytitle: mySaveobject.Saveobjects.mypyqmessage.title, mycontent: mySaveobject.Saveobjects.mypyqmessage.content, images:mySaveobject.convert2(images: mySaveobject.Saveobjects.mysavedimage),locate: mySaveobject.Saveobjects.mypyqmessage.locate)
         
        }
        .padding(.bottom)
       
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
            .environmentObject(Model(FromOutAllTags: initAllTags()))
            .environmentObject(PYQData(allPyqData: initPqyData()))
            .environmentObject(SaveobjectData(SaveObject: initSaveObject()))
    }
}
