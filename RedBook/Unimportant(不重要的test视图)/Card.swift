//
//  Card.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/14.
//

import SwiftUI
import Parse
struct Card: View {
//    var viewname : String
    var index : Int
    var card : Carddata
    @EnvironmentObject var mycarddatas : Model
    @EnvironmentObject var Myclientdata  : ClientData
    @State var LoveInt = 0
    @State var isLoved = false
//    @Binding var showgood : Bool
//    var namespaceid : Namespace.ID
//    func GetLoveInt(){
//        let query = PFUser.query()
//        query?.whereKey("love", contains:card.pyqobjectid)
//        query?.findObjectsInBackground(block: { obj, error in
//            if obj != nil{
//                self.LoveInt = obj!.count
//            }
//        })
//    }
    
    func isloved(){
        let query = PFQuery(className: "Love")
        query.whereKey("myobjectid", equalTo: Myclientdata.MyClient.username)
        query.whereKey("pyqobjectid", equalTo: card.pyqobjectid)
        query.whereKey("Isshow", equalTo: true)
        query.getFirstObjectInBackground { obj, error in
            if obj != nil{
                isLoved = true
            }
        }
    }

//    func IsLove(){
//        for i in Myclientdata.MyClient.love{
//            if i  == card.pyqobjectid{
//                self.isLoved = true
//            }
//        }
//    }
    
//    func GetAll()async{
//        GetLoveInt()
//        IsLove()
//    }
    
    var body: some View {
        VStack(alignment:.leading,spacing: 5){
            PublicURLImageView(imageurl:card.publishimageurl.count != 0 ? card.publishimageurl[0]:"http://localhost:1337/parse/files/8888/1de2c74912fdf6ff6e651b06a744a24d_image.png", contentmode: false)
//                .matchedGeometryEffect(id: "background\(card.pyqobjectid)\(viewname)", in: namespaceid)
                
            HStack{
                Text(card.title)
                Spacer()
            }
            .transition(.opacity)
            
            
            HStack{
                PublicURLImageView(imageurl:card.client.clientimage,contentmode: true)
                        .mask(Circle())
                        .frame(width: 30, height: 30)
                
                Text(card.client.clientname)
                    
                Spacer()
                
                Image(systemName: isLoved ?  "heart.fill":"heart")
                    .foregroundColor(isLoved ? .red:.black)
                Text("\(card.love)")
            }
            .font(.footnote)
            .padding(.horizontal,5)
            .transition(.opacity)
           
            
        }
        .background(
            Color.white
        )
        .mask(
            RoundedRectangle(cornerRadius: 10)
        )
        .onAppear {
//            isloved()
        }
    }
}
//
//struct Card_Previews: PreviewProvider {
//
//    static var previews: some View {
//        Card()
//    }
//}
