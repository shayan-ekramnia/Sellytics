//
//  ContentView.swift
//  Sellytics
//
//  Created by Shayan Ekramnia on 18/12/24.
//



// ContentView.swift
import SwiftUI
import Charts

struct ContentView: View {
    @StateObject private var viewModel = SalesForecastViewModel()
    @State private var isShowingDocumentPicker = false
    @State private var forecastPeriods = 30
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // File Selection
                Button("Select Sales Data File") {
                    isShowingDocumentPicker = true
                }
                .sheet(isPresented: $isShowingDocumentPicker) {
                    DocumentPicker(
                        selectedURL: $viewModel.selectedFile,
                        onPick: { url in
                            print("Selected file: \(url)")
                            viewModel.loadSalesData(from: url)
                            isShowingDocumentPicker = false
                        }
                    )
                }
                
                // Forecast Configuration
                HStack {
                    Text("Forecast Periods:")
                    Picker("", selection: $forecastPeriods) {
                        ForEach([30, 60, 90, 180], id: \.self) { period in
                            Text("\(period) days").tag(period)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                // Forecast Button
                Button("Generate Sales Forecast") {
                    viewModel.forecastSales(periods: forecastPeriods)
                }
                .disabled(viewModel.selectedFile == nil)
                
                // Export Forecast Button
                Button("Export Forecast") {
                    viewModel.exportForecast()
                }
                .disabled(viewModel.salesDataModel.forecastedData.isEmpty)
                
                // Loading Indicator
                if viewModel.isLoading {
                    ProgressView()
                }
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                // Sales Chart
                Chart {
                    // Original Sales Data
                    ForEach(viewModel.salesDataModel.originalData) { data in
                        LineMark(
                            x: .value("Date", data.date),
                            y: .value("Sales", data.sales)
                        )
                        .interpolationMethod(.cardinal)
                        .foregroundStyle(.blue)
                    }
                    
                    // Forecasted Sales Data
                    ForEach(viewModel.salesDataModel.forecastedData) { data in
                        LineMark(
                            x: .value("Date", data.date),
                            y: .value("Sales", data.sales)
                        )
                        .interpolationMethod(.cardinal)
                        .foregroundStyle(.green)
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month)) { _ in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(format: .dateTime.month())
                    }
                }
                .frame(height: 300)
            }
            .navigationTitle("Sellytics")
            .padding()
        }
    }
}
