//
//  SalesForecastViewModel.swift
//  Sellytics
//
//  Created by Shayan Ekramnia on 18/12/24.
//


// SalesForecastViewModel.swift
import SwiftUI

class SalesForecastViewModel: ObservableObject {
    @Published var salesDataModel = SalesDataModel()
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedFile: URL?
    
    func loadSalesData(from url: URL) {
        isLoading = true
        errorMessage = nil
        
        let success = salesDataModel.loadData(from: url)
        
        if !success {
            errorMessage = "Unable to load data from file. Please check the CSV format."
        }
        
        isLoading = false
    }
    
    func forecastSales(periods: Int = 30) {
        guard !salesDataModel.originalData.isEmpty else {
            errorMessage = "Please load sales data first."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        salesDataModel.forecastSales(periods: periods)
        
        isLoading = false
    }
    
    func exportForecast() {
        guard let fileURL = salesDataModel.exportForecastToCSV() else {
            errorMessage = "Failed to export forecast."
            return
        }
        
        print("Forecast exported to: \(fileURL)")
    }
}
