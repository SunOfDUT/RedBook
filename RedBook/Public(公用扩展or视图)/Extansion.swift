//
//  Extansion.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/7/13.
//

import SwiftUI

    

extension Image{
    func CircleImage(width:CGFloat) -> some View{
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
        // 变成圆形
            .mask(Circle())
        // 设置大小
            .frame(width: width,height: width)
           
    }
}

extension View{
    func ButtonStyleGray() -> some View{
        self
            .frame(width: UIScreen.main.bounds.width / 4 - 10, height: 40)
            .background(.gray.opacity(0.1),in: RoundedRectangle(cornerRadius: 10))
           
    }
}


extension View{
    func ButtonStyleWhite() -> some View{
        self
            .frame(width: UIScreen.main.bounds.width / 4 - 10, height: 40)
            .background(.white)
            .padding(1)
            .background(.gray.opacity(0.1),in: RoundedRectangle(cornerRadius: 10))
    }
}

extension String : Identifiable{
    public var id : Int{
        return self.hashValue
    }
}
extension UIImage : Identifiable{
    public var id : Int{
        return self.hashValue
    }
}



extension UINavigationController : UIGestureRecognizerDelegate{
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension View{
    func NavigationHidden() -> some View{
        self
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

extension View{
    func ButtonOfRed()->some View{
        self
            .foregroundColor(Color("red"))
            .padding(.vertical,5)
            .padding(.horizontal,18)
            .background(.white)
            .padding(1)
            .background(Color("red"),in: RoundedRectangle(cornerRadius: 20))
    }
}

func DateFormmatter2(date:Date)->String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let datetime = formatter.string(from: date)
    return datetime
}

func DateFormmatter(date:Date)->String{
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd"
    let datetime = formatter.string(from: date)
    return datetime
}
