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
    func makeUIView(context: Context) -> LineChartView {
        return LineChartView()
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        let dataSet = LineChartDataSet(entries: entries)
        dataSet.label = "Temperature"
        uiView.data = LineChartData(dataSet: dataSet)
        uiView.noDataText = "No Data"
//        dataSet.fill = Fill.fillWithColor(UIColor(Color("")))
        dataSet.drawFilledEnabled = true
    }
    
    func formatDataSet(dataSet: LineChartDataSet) {
        dataSet.colors = [.red]
        dataSet.valueColors = [.red]
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
    }
    
}

struct HistoryChartView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryChartView(entries: Temperature.dataEntriesForDay(0, temperature: Temperature.temperatureHistory))
    }
}
