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
    let lineChart = LineChartView()
    
    @Binding var selectedItem: String
    
    func makeUIView(context: Context) -> LineChartView {
        lineChart.delegate = context.coordinator
        return lineChart
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        let dataSet = LineChartDataSet(entries: entries)
        formatDataSet(dataSet: dataSet)
        formatUIView(uiView: uiView)
        uiView.data = LineChartData(dataSet: dataSet)

//        if uiView.scaleX == 1.0 {
//            uiView.zoom(scaleX: 1.5, scaleY: 1, x:0, y:0)
//        }
        
//        uiView.setScaleEnabled(false)
//        dataSet.fill = Fill.fillWithColor(UIColor(.green))
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatXAxis(xAxis: uiView.xAxis)
        
    }
    
    func formatDataSet(dataSet: LineChartDataSet) {
        dataSet.mode = .horizontalBezier
        dataSet.label = "Temperature"
        
        dataSet.drawFilledEnabled = true
        dataSet.circleRadius = 3
        dataSet.cubicIntensity =  1
        dataSet.lineWidth = 2
        
        dataSet.colors = [.green]
//        dataSet.valueColors = [.black]
        dataSet.drawValuesEnabled = false
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
        
    }
    
    func formatUIView(uiView: LineChartView) {
        uiView.pinchZoomEnabled = true
        uiView.doubleTapToZoomEnabled = false
        uiView.noDataText = "No Data"
        uiView.rightAxis.enabled = false
        uiView.xAxis.drawLabelsEnabled = false
        uiView.legend.enabled = false
        
        uiView.notifyDataSetChanged()
        uiView.drawGridBackgroundEnabled = false
        uiView.xAxis.drawGridLinesEnabled = false
        uiView.leftAxis.drawGridLinesEnabled = false
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
}

extension HistoryChartView {
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: HistoryChartView
        init(parent: HistoryChartView) {
            self.parent = parent
        }
        
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d-MMM-YY hh:mm"
            let date = dateFormatter.string(from: Date(timeIntervalSince1970: entry.x))
            parent.selectedItem = "\(date): \(String(format: "%.1f", entry.y))ºC"
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}
