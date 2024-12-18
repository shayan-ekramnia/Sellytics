//
//  SalesData.swift
//  Sellytics
//
//  Created by Shayan Ekramnia on 18/12/24.
//

// SalesData.swift
import Foundation

struct SalesData: Identifiable {
    let id = UUID()
    let date: Date
    let sales: Double
    
    // Add a method to format date for display
    func formattedDate(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
