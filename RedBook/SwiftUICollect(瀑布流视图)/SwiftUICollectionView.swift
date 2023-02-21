//
//  SwiftUICollectionView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/24.
//

import SwiftUI

extension View{
    public func girdStyle(colums:Int = 2,spacing:CGFloat = 8,animation:Animation? = .default)->some View{
        let style = GridStyle(columsInportait: colums, columsInlandscpae: colums, spacing: spacing, animation: animation)
        return self.environment(\.gridStyle,style)
    }
    public func girdStyle(columnsInPortrait:Int = 2,columnsInLandscape : Int = 4,spacing:CGFloat = 8,animation:Animation? = .default)->some View{
        let style = GridStyle(columsInportait: columnsInPortrait,columsInlandscpae: columnsInLandscape, spacing: spacing, animation: animation)
        return self.environment(\.gridStyle,style)
    }
    public func scollOptions(direction:Axis.Set) -> some View{
        let options = ScollOptions(direction:direction)
        return self.environment(\.scolloptions,options)
    }
}
//瀑布流视图 核心:使用alignmentGuide去布局视图
public struct SwiftUICollectionView<Data:RandomAccessCollection,ID:Hashable,Content:View>:View{
    @Environment(\.gridStyle) private var gridStyle
    @Environment(\.scolloptions) private var scolloptions
    private let data : Data
    private let dataId :  KeyPath<Data.Element,ID>
    private let content : (Data.Element) -> Content
    
    var completeHandler:((_ ImageCenterPoint:Dictionary<AnyHashable,CGSize>)->())?
    var gridsize : ((_ gridheight:CGFloat)->())?
    
    @State var ImageCenterPoint = Dictionary<AnyHashable,CGSize>()
    @State private var loaded = false
    @State private var gridHeight : CGFloat = 0
    @State private var alignmentGuides = [AnyHashable:CGPoint](){
        didSet{ loaded = !oldValue.isEmpty}
    }
    public var body: some View{
        VStack{
            GeometryReader{ proxy in
                self.grid(in: proxy)
                    .onPreferenceChange(ElementPreferenceKey.self) { value in
                        DispatchQueue.global(qos: .userInteractive).async {
                            let (alignment,GridHeight) = self.alignmentAndGridHeight(columns: self.gridStyle.colums, spacing: self.gridStyle.spacing, scollDirection:self.scolloptions.direction, preferences: value)
                            DispatchQueue.main.async {
                                self.alignmentGuides = alignment
                                self.gridHeight = GridHeight
                                self.gridsize?(self.gridHeight)
                                print("GridHeight\(GridHeight)")
                            }
                        }
                    }
            }
        }
        .frame(width: self.scolloptions.direction == .horizontal ? gridHeight : nil,
               height: self.scolloptions.direction == .vertical ? gridHeight : nil)
    }
    
    private func grid(in geometry:GeometryProxy) ->some View{
        let columnWidth = self.columnWidth(columns: gridStyle.colums, spacing:gridStyle.spacing, scollDirection: scolloptions.direction, geometry: geometry.size)
        return ZStack(alignment: .topLeading){
                ForEach(data,id:self.dataId){ item in
                    self.content(item)
                        .frame(width: self.scolloptions.direction == .vertical ? columnWidth : nil,
                               height: self.scolloptions.direction == .horizontal ? columnWidth : nil)
                        .background(PreferenceSetter(id: item[keyPath:self.dataId]))
                        .alignmentGuide(.top, computeValue: { _ in self.alignmentGuides[item[keyPath: self.dataId]]?.y ?? 0 })
                        .alignmentGuide(.leading, computeValue: { _ in self.alignmentGuides[item[keyPath: self.dataId]]?.x ?? 0 })
                        .opacity(self.alignmentGuides[item[keyPath: self.dataId]] != nil ? 1 : 0)
                        .onAppear {
                            print("keyPath:self.dataId\(self.dataId)")
                            print("item[keyPath:self.dataId]\(item[keyPath:self.dataId])")
                        }
                }
            }
            .animation(self.gridStyle.animation,value:self.loaded)
    }
    
    func alignmentAndGridHeight(columns:Int,spacing:CGFloat,scollDirection:Axis.Set,preferences:[ElementPreferenceData]) -> ([AnyHashable:CGPoint],CGFloat){
        var heights = Array(repeating: CGFloat(0), count: columns)
        var alignmentGuides = [AnyHashable:CGPoint]()
        
        preferences.forEach { preference in
            if let minValue = heights.min(),let indexmin = heights.firstIndex(of: minValue){
//                print("indexmain\(indexmin)")
                let preferenceSizeWidth = scollDirection == .vertical ? preference.size.width : preference.size.height
                let preferenceSizeHeight = scollDirection == .vertical ? preference.size.height : preference.size.width
            
                let width = preferenceSizeWidth * CGFloat(indexmin) + CGFloat(indexmin) * spacing
                let height = heights[indexmin]
                let offset = CGPoint(x: 0 - (scollDirection == .vertical ? width:height),
                                     y: 0 - (scollDirection == .vertical ? height:width))
                heights[indexmin] += preferenceSizeHeight + spacing
                alignmentGuides[preference.id] = offset
                self.ImageCenterPoint[preference.id] = CGSize(width: preferenceSizeWidth, height: preferenceSizeHeight)
//                print(preference.id)
//                print("offset\(offset)")
//                print("heights[indexmin]\(heights[indexmin])")
            }
        }
        self.completeHandler?(self.ImageCenterPoint)
        let gridHeight = max(0, (heights.max() ?? spacing) - spacing)
        print(gridHeight)
        return (alignmentGuides,gridHeight)
    }
    
    func columnWidth(columns:Int,spacing:CGFloat,scollDirection:Axis.Set,geometry:CGSize) -> CGFloat{
        let geometrySizeWidth = scollDirection == .vertical ? geometry.width : geometry.height
        let width = max(0, geometrySizeWidth - (spacing * CGFloat(columns) - 1))
//        print("columnswidth\(width / CGFloat(columns))")
        return width / CGFloat(columns)
    }
}

extension SwiftUICollectionView{
    public init(_ data:Data,id:KeyPath<Data.Element,ID>,content:@escaping (Data.Element) -> Content){
        self.data = data
        self.dataId = id
        self.content = content
    }
    public init(_ data:Data,id:KeyPath<Data.Element,ID>,content:@escaping (Data.Element) -> Content,completeHandler:((_ ImageCenterPoint:Dictionary<AnyHashable,CGSize>)->())?){
        self.data = data
        self.dataId = id
        self.content = content
        self.completeHandler = completeHandler
    }
    public init(_ data:Data,id:KeyPath<Data.Element,ID>,content:@escaping (Data.Element) -> Content,gridsize:((_ gridheight:CGFloat)->())?){
        self.data = data
        self.dataId = id
        self.content = content
        self.gridsize = gridsize
    }
}
extension SwiftUICollectionView where ID == Data.Element.ID,Data.Element : Identifiable{
    public init(_ data:Data,content:@escaping (Data.Element) -> Content){
        self.data = data
        self.dataId = \Data.Element.id
        self.content = content
    }
    
    public init(_ data:Data,content:@escaping (Data.Element) -> Content,completeHandler:((_ ImageCenterPoint:Dictionary<AnyHashable,CGSize>)->())?){
        self.data = data
        self.dataId = \Data.Element.id
        self.content = content
        self.completeHandler = completeHandler
    }
    public init(_ data:Data,content:@escaping (Data.Element) -> Content,gridsize:((_ gridheight:CGFloat)->())?){
        self.data = data
        self.dataId = \Data.Element.id
        self.content = content
        self.gridsize = gridsize
    }
}

