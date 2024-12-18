//
//  TimeSeriesForecaster.swift
//  Sellytics
//
//  Created by Shayan Ekramnia on 18/12/24.
//


// TimeSeriesForecaster.swift
import Foundation

struct TimeSeriesForecaster {
    // Simple exponential smoothing for forecasting
    static func forecast(data: [Double], periods: Int, alpha: Double = 0.3) -> [Double] {
        guard !data.isEmpty else { return [] }
        
        var smoothedValues = [data[0]]
        
        // Smooth existing data
        for i in 1..<data.count {
            let smoothedValue = alpha * data[i] + (1 - alpha) * smoothedValues[i-1]
            smoothedValues.append(smoothedValue)
        }
        
        // Forecast future periods
        var forecastValues = smoothedValues
        let lastSmoothedValue = smoothedValues.last!
        
        for _ in 0..<periods {
            let nextForecast = alpha * lastSmoothedValue + (1 - alpha) * lastSmoothedValue
            forecastValues.append(nextForecast)
        }
        
        return Array(forecastValues.suffix(periods))
    }
    
    // Additional method for more advanced forecasting strategies can be added here
    static func advancedForecast(data: [Double], periods: Int) -> [Double] {
        // Placeholder for more sophisticated forecasting methods
        return forecast(data: data, periods: periods)
    }
}
