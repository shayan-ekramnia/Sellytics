# Sellytics

Sellytics is a powerful iOS application designed for sales data analysis and forecasting. Built with SwiftUI, it provides intuitive visualization and predictive analytics for sales data.

## Features

- 📊 Interactive sales data visualization
- 📈 Time series forecasting
- 📁 CSV file import support
- 💾 Export forecast results
- 📱 Native iOS UI with SwiftUI
- 📉 Custom chart rendering
- ⚡ Real-time data processing

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/sellytics.git
```

2. Open the project in Xcode:
```bash
cd sellytics
open Sellytics.xcodeproj
```

3. Build and run the project in Xcode

## Project Structure

```
Sellytics/
│
├── Models/
│   ├── SalesData.swift
│   └── TimeSeriesForecaster.swift
│
├── Services/
│   └── CSVParser.swift
│
├── ViewModels/
│   ├── SalesForecastViewModel.swift
│   └── SalesDataModel.swift
│
├── Views/
│   ├── ContentView.swift
│   └── DocumentPicker.swift
│
└── SellyticsApp.swift
```

## Usage

### Data Import

1. Prepare your CSV file with the following format:
```csv
date,sales
2024-01-01,1000
2024-01-02,1200
...
```

2. Launch Sellytics and tap "Select Sales Data File"
3. Choose your CSV file
4. The app will automatically parse and display your data

### Generating Forecasts

1. After importing data, select the forecast period (30, 60, 90, or 180 days)
2. Tap "Generate Sales Forecast"
3. View the forecast results on the interactive chart
4. Export results using the "Export Forecast" button

## Technical Details

### Core Components

- **SwiftUI**: Modern declarative UI framework
- **Charts Framework**: Native charting capabilities
- **Combine**: Reactive programming framework
- **MVVM Architecture**: Clean separation of concerns

### Data Processing

The app uses a sophisticated data processing pipeline:

1. CSV Parsing with error handling
2. Data validation and transformation
3. Time series analysis
4. Exponential smoothing forecasting

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Future Enhancements

- [ ] Multiple forecasting models
- [ ] Cloud sync capabilities
- [ ] Advanced data analytics
- [ ] Machine learning integration
- [ ] Custom chart annotations
- [ ] Batch processing support

## Known Issues

- Large CSV files (>100MB) may cause performance issues
- Limited to daily sales data format
- Currently supports single currency only

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Swift Charts](https://developer.apple.com/documentation/charts) - iOS charting framework
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) - UI framework
- [Apple Developer Documentation](https://developer.apple.com/documentation)
