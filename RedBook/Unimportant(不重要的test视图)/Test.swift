//
//  Test.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/12.
//

import SwiftUI
import StoreKit
struct Test : View{
    var images = ["image1","image2","image3","image4","image5","image6","image7","image8"]
    @State var showdetial = false
    @State var selectmodel : (String,AnyHashable) = ("",9)
    @State var size = Dictionary<AnyHashable,CGSize>()
    var body: some View{
        ZStack{
            ScrollView{
                SwiftUICollectionView(images) { img in
                    Button{
                        withAnimation {
                            showdetial = true
                            print(img.hashValue)
                        }
                    }label: {
                       Image(img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            
                    }
                }completeHandler:{ ImageCenterPoint in
                    size = ImageCenterPoint
                    print(ImageCenterPoint)
                }
                .girdStyle()
                .scollOptions(direction: .vertical)
                .padding(5)
            }
        }
    }
}


extension AnyTransition{
    static func newtransition(point:CGPoint,cgsize:CGSize) -> AnyTransition{
        return AnyTransition.modifier(active:activeView(center:point,opciation:0, size: cgsize), identity: activeView(center :CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2),opciation: 1, size: UIScreen.main.bounds.size))
    }
}

struct activeView : ViewModifier{
    var center : CGPoint
    var opciation : CGFloat
    var size : CGSize
    func body(content: Content) -> some View {
        content
            .position(CGPoint(x:center.x,y: center.y))
            .onAppear(perform: {
                print(center)
            })
            .frame(width: size.width, height:size.height)
            .animation(.default, value: self.center)
            .opacity(opciation)
    }
}

struct RectangleModel: Identifiable, Equatable {
    var id = UUID()
    var index: Int
    var size : CGFloat = Rectangles.randomSize()
    var color: Color = Rectangles.randomColor()
}

struct Rectangles {
    static func random() -> [RectangleModel] {
        var array : [RectangleModel] = []
        for i in 0..<60{
            let color = randomColor()
            array.append(RectangleModel(index:i,size: randomSize(), color: color))
        }
        return array
    }
    
    static func randomSize() -> CGFloat { CGFloat.random(in: 100...200) }

    static func fixedSize() -> CGFloat { 60 }
    
    static func randomColor() -> Color { [.red, .green, .blue, .orange, .yellow, .pink, .purple].randomElement()! }
    
    static func disabledColor() -> Color { .gray }
}

struct previre_myview : PreviewProvider{
    static var previews: some View{
        Test()
    }
}

public struct imagesizeData{
    var id : AnyHashable
    var centerPoint : CGPoint
    var imagesize : CGSize
}
