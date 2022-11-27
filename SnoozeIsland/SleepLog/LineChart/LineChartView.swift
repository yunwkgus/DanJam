//
//  LineChart.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2021/12/29.
//
import SwiftUI

public struct LineChartView: View {
    
    
    @ObservedObject var data:ChartData
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    
    public var formSize:CGSize
    public var dropShadow: Bool
    public var valueSpecifier:String
    public var legendSpecifier: String
    
    @State private var touchLocation:CGPoint = .zero
    @State private var showIndicatorDot: Bool = false
    @State private var hideHorizontalLines: Bool = false
    @State private var currentValue: Double = 2 {
        didSet{
            if (oldValue != self.currentValue && showIndicatorDot) {
                HapticFeedback.playSelection()
            }
        }
    }
    
    var frame = CGSize(width: 180, height: 120)
    
    private var rateValue: Int?
    
    public init(data: [Double],
                title: String,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                form: CGSize? = ChartForm.medium,
                rateValue: Int? = 14,
                dropShadow: Bool? = true,
                valueSpecifier: String? = "%.1f",
                legendSpecifier: String? = "%.2f") {
        
        self.data = ChartData(points: data)
        self.title = title
        self.legend = legend
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
        self.formSize = form!
        frame = CGSize(width: self.formSize.width, height: self.formSize.height/2)
        self.dropShadow = dropShadow!
        self.valueSpecifier = valueSpecifier!
        self.legendSpecifier = legendSpecifier!
        self.rateValue = rateValue
    }
    
    public var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor( Color.white.opacity(0.1) ).frame(width: 280, height: 260, alignment: .center)                .cornerRadius(20)
                .shadow(color: self.style.dropShadowColor, radius: self.dropShadow ? 8 : 0)
            VStack(alignment: .center){
                
                HStack{
                    Text(self.title)
                        .font(Font.custom("Amatic-Bold", size:30))
                        .bold()
                        .foregroundColor( self.style.textColor )
                    Spacer()
                }.padding()
                GeometryReader{ geometry in
                Rectangle()
                    .foregroundColor(self.style.backgroundColor )

                Legend(data: self.data,
                       frame: .constant(geometry.frame(in: .local)), hideHorizontalLines: self.$hideHorizontalLines, specifier: legendSpecifier)
                    .frame(width: self.formSize.width + 40).offset(x: 10, y: 0)
                    .transition(.opacity)
                    .animation(Animation.easeOut(duration: 1))
            
                    Line(data: self.data,
                         frame: .constant(geometry.frame(in: .local)),
                         touchLocation: self.$touchLocation,
                         showIndicator: self.$showIndicatorDot,
                         minDataValue: .constant(nil),
                         maxDataValue: .constant(nil),
                         showBackground: false,
                         gradient: self.style.gradientColor
                    ).offset(x: 50, y: 0)
                    
                }
                .frame(width: frame.width, height: frame.height)
                .offset(x: -30, y: 0)
            }
        }.frame(width: self.formSize.width, height: self.formSize.height)
        .gesture(DragGesture()
        .onChanged({ value in
            self.touchLocation = value.location
            self.showIndicatorDot = true
            self.getClosestDataPoint(toPoint: value.location, width:self.frame.width, height: self.frame.height)
        })
            .onEnded({ value in
                self.showIndicatorDot = false
            })
        )
    }
    
    @discardableResult func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(round((toPoint.x)/stepWidth))
        if (index >= 0 && index < points.count){
            self.currentValue = points[index]
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index])*stepHeight)
        }
        return .zero
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", legend: "Basic")
                .environment(\.colorScheme, .light)
            
            LineChartView(data: [282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188], title: "Line chart", legend: "Basic")
            .environment(\.colorScheme, .light)
        }
    }
}
