//
//  CSVParser.swift
//  Sellytics
//
//  Created by Shayan Ekramnia on 18/12/24.
//

// CSVParser.swift
import Foundation

class CSVParser {
    enum ParserError: Error {
        case invalidFile
        case parseError
    }
    
    static func parse(url: URL) throws -> [SalesData] {
        do {
            let content = try String(contentsOf: url, encoding: .utf8)
            let rows = content.components(separatedBy: .newlines)
            
            // Remove header and empty rows
            let dataRows = rows.dropFirst().filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let salesData = try dataRows.map { row -> SalesData in
                let columns = row.components(separatedBy: ",")
                guard columns.count == 2,
                      let dateString = columns.first?.trimmingCharacters(in: .whitespaces),
                      let salesString = columns.last?.trimmingCharacters(in: .whitespaces),
                      let date = dateFormatter.date(from: dateString),
                      let sales = Double(salesString) else {
                    throw ParserError.parseError
                }
                
                return SalesData(date: date, sales: sales)
            }
            
            print("Parsed \(salesData.count) rows from CSV")
            return salesData
        } catch {
            print("Error reading CSV: \(error)")
            throw ParserError.invalidFile
        }
    }
}
