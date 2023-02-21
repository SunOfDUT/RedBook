//
//  test8.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/8.
//

import SwiftUI

struct test8: View {
    var locate2 : [String] = ["北京","天津","河北省","山西省","内蒙古省","辽宁省","吉林省","黑龙江省","上海","江苏省","浙江省","安徽省","广东省","山东省","河南省","湖南省","重庆省","福建省","云南省","四川省","广西省","海南省","江西省","湖北省","台湾省","澳门","贵州","甘肃省","青海","新疆","西藏","宁夏"]
    var locate1 : [String] = ["中国","美国","英国","日本","韩国","加拿大","澳大利亚","法国","德国","俄罗斯"]
    @State var picker1 : String = "中国"
    @State var picker2 = ""
    @State var allpick = ""
    var body: some View {
        VStack {
            Text("Today's Weather")
                .font(.title)
                .border(.gray)

            HStack {
                Text("🌧")
                    .alignmentGuide(VerticalAlignment.center) { _ in -20 }
                    .border(.gray)
                Text("Rain & Thunderstorms")
                    .border(.gray)
                Text("⛈")
                    .alignmentGuide(VerticalAlignment.center) { _ in 20 }
                    .border(.gray)
            }
        }
}
}

struct test8_Previews: PreviewProvider {
    static var previews: some View {
        test8()
    }
}
