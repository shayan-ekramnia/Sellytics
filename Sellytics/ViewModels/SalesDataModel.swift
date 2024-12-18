//
//  SalesDataModel.swift
//  Sellytics
//
//  Created by Shayan Ekramnia on 18/12/24.
//

// SalesDataModel.swift
import Foundation
import SwiftUI

class SalesDataModel: ObservableObject {
    @Published var originalData: [SalesData] = []
    @Published var forecastedData: [SalesData] = []
    
    func loadData(from url: URL) -> Bool {
        do {
            let parsedData = try CSVParser.parse(url: url)
            originalData = parsedData.sorted { $0.date < $1.date }
            return !originalData.isEmpty
        } catch {
            print("Failed to parse CSV: \(error)")
            return false
        }
    }
    
    func forecastSales(periods: Int = 30) {
        let salesValues = originalData.map { $0.sales }
        let forecastValues = TimeSeriesForecaster.forecast(data: salesValues, periods: periods)
        
        // Generate forecast dates
        let lastDate = originalData.last?.date ?? Date()
        let forecastDates = (1...periods).map { index in
            Calendar.current.date(byAdding: .day, value: index, to: lastDate)!
        }
        
        forecastedData = zip(forecastDates, forecastValues).map {
            SalesData(date: $0, sales: $1)
        }
    }
    
    // Optional: Add method to export forecast results
    func exportForecastToCSV() -> URL? {
        guard !forecastedData.isEmpty else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let csvString = forecastedData.map { data in
            "\(dateFormatter.string(from: data.date)),\(data.sales)"
        }.joined(separator: "\n")
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("sales_forecast_\(Date().timeIntervalSince1970).csv")
        
        do {
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            print("Error writing forecast to CSV: \(error)")
            return nil
        }
    }
}

