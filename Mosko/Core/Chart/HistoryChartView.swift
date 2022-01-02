//
//  HistoryChartView.swift
//  mosko
//
//  Created by Deven Nathanael on 07/12/21.
//

import Charts
import SwiftUI

struct HistoryChartView: UIViewRepresentable {
    let entries: [ChartDataEntry]
    
    let markerView = MarkerView(color: .white, font: UIFont.boldSystemFont(ofSize: 14), textColor: .black)
    
    class MarkerView: MarkerImage {
        private (set) var color: UIColor
            private (set) var font: UIFont
            private (set) var textColor: UIColor
            private var labelText: String = ""
            private var attrs: [NSAttributedString.Key: AnyObject]!

            static let formatter: DateComponentsFormatter = {
                let f = DateComponentsFormatter()
                f.allowedUnits = [.minute, .second]
                f.unitsStyle = .short
                return f
            }()

            init(color: UIColor, font: UIFont, textColor: UIColor) {
                self.color = color
                self.font = font
                self.textColor = textColor

                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                attrs = [.font: font, .paragraphStyle: paragraphStyle, .foregroundColor: textColor, .baselineOffset: NSNumber(value: -4)]
                super.init()
            }

            override func draw(context: CGContext, point: CGPoint) {
                // Padding
                let labelWidth = labelText.size(withAttributes: attrs).width + 10
                let labelHeight = labelText.size(withAttributes: attrs).height + 4

                // Placing
                var rectangle = CGRect(x: point.x, y: point.y, width: labelWidth, height: labelHeight)
                rectangle.origin.x -= rectangle.width / 2.0
                let spacing: CGFloat = 20
                rectangle.origin.y -= rectangle.height + spacing

                // Rounded Rect
                let clipPath = UIBezierPath(roundedRect: rectangle, cornerRadius: 6.0).cgPath
                context.addPath(clipPath)
                context.setFillColor(UIColor.white.cgColor)
                context.setStrokeColor(UIColor.black.cgColor)
                context.closePath()
                context.drawPath(using: .fillStroke)

                // Add the text
                labelText.draw(with: rectangle, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            }

            override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
                labelText = "\(customString(entry.x)), \(String(format: "%.1f", entry.y))ºC"
            }

            private func customString(_ value: Double) -> String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d-MMM-YY hh:mm"
                let date = dateFormatter.string(from: Date(timeIntervalSince1970: value))
                return date
            }
    }
    
    func makeUIView(context: Context) -> LineChartView {
        return LineChartView()
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        let dataSet = LineChartDataSet(entries: entries)
        dataSet.mode = .horizontalBezier
        dataSet.label = "Temperature"
        uiView.data = LineChartData(dataSet: dataSet)
        uiView.noDataText = "No Data"
        uiView.rightAxis.enabled = false
//        if uiView.scaleX == 1.0 {
//            uiView.zoom(scaleX: 1.5, scaleY: 1, x:0, y:0)
//        }
        uiView.pinchZoomEnabled = true
        uiView.doubleTapToZoomEnabled = false
//        uiView.setScaleEnabled(false)
//        dataSet.fill = Fill.fillWithColor(UIColor(.green))
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatXAxis(xAxis: uiView.xAxis)
        uiView.xAxis.drawLabelsEnabled = true
        uiView.legend.enabled = false
        formatDataSet(dataSet: dataSet)
        dataSet.drawFilledEnabled = true
        dataSet.circleRadius = 3
        dataSet.cubicIntensity =  1
        dataSet.lineWidth = 2
        uiView.notifyDataSetChanged()
        uiView.drawGridBackgroundEnabled = false
        uiView.xAxis.drawGridLinesEnabled = false
        uiView.leftAxis.drawGridLinesEnabled = false
        uiView.marker = markerView
    }
    
    func formatLeftAxis(leftAxis: YAxis) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 40
    }
    
    func formatXAxis(xAxis: XAxis) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        xAxis.labelPosition = .bottom
        
    }
    
    func formatDataSet(dataSet: LineChartDataSet) {
        dataSet.colors = [.green]
//        dataSet.valueColors = [.black]
        dataSet.drawValuesEnabled = false
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
        
    }
}
