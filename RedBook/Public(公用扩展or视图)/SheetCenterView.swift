//
//  SheetCenterView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/6.
//

import SwiftUI

//view<-->view

extension View{
    func SheetCenterView<Content>(isPresented:Binding<Bool>,onDismiss:(()->Void)? = nil,@ViewBuilder content:@escaping()->Content) -> some View where Content:View{
        self
            .modifier(CenterViewModifer(isPresented: isPresented, view: {
                CenterView(action: onDismiss, content: content)
            }))
    }
}
struct CenterView<Content> : View where Content : View{
    var action: (()->Void)?
    var content : Content
    
    init(action:(()->Void)?,@ViewBuilder content:()->Content){
        self.action = action
        self.content = content()
    }
    
    var body: some View{
        VStack{
            // 定义了我们想要的那个视图--> bottonview -->产生联系？？？没有
            content
        }
    }
}

struct CenterViewModifer<contents:View> : ViewModifier{
    @Binding var isPresented : Bool
    var view : ()->contents
    
    init(isPresented:Binding<Bool>,view:@escaping ()->contents){
            self._isPresented = isPresented
            self.view = view
    }
    
    func body(content: Content) -> some View {
        // 使用了这样的修饰符后，我们的页面应该是怎么样的
        
            ZStack{
                content
                
                if isPresented{
                    Color.black
                        .opacity(0.3)
                        .animation(.default, value: isPresented)
                        .ignoresSafeArea()
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation{
                                isPresented = false
                            }
                        }
                 
                    view()
                        .animation(.default, value: isPresented)
                        .transition(.opacity)
                }
            }
            .edgesIgnoringSafeArea(.all)
    }
    
}
