//
//  CountryViewController.swift
//  Books
//
//  Created by Dang Duy Cuong on 9/30/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import UIKit
import Charts

class CountryViewController: UIViewController {
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var titleConfirmedLabel: UILabel!
    @IBOutlet weak var titleDeathsLabel: UILabel!
    @IBOutlet weak var titleRecoveredLabel: UILabel!
    
    @IBOutlet weak var flagImage: UIImageView!
    
    @IBOutlet weak var dailyConfirmed: UILabel!
    @IBOutlet weak var dailyDeaths: UILabel!
    @IBOutlet weak var dailyRecovered: UILabel!
    
    @IBOutlet weak var totalConfirmed: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    
    var numberofDowloadDataEntry = [PieChartDataEntry]()
    var infoCountry = Covid19Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDisplay()
        //tong ca nhiem, chet, khoi
        //hang ngay
        if let todayCases = infoCountry.todayCases {
            dailyConfirmed.text = "\t\(todayCases)"
        }
        if let todayDeaths = infoCountry.todayDeaths {
            dailyDeaths.text = "\t\(todayDeaths)"
        }
        if let todayRecovered = infoCountry.todayRecovered {
            dailyRecovered.text = "\t\(todayRecovered)"
        }
        //tong so
        if let cases = infoCountry.cases {
            totalConfirmed.text = "\t\(cases)"
        }
        if let todayDeaths = infoCountry.deaths {
            totalDeaths.text = "\t\(todayDeaths)"
        }
        if let recovered = infoCountry.recovered {
            totalRecovered.text = "\t\(recovered)"
        }
        
        loadImage()
        
//        guard let flagUrl = URL(string: infoCountry.countryInfo?.flag ?? "") else {
//            print("Flag Error")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: flagUrl) { (data, response, error) in
//            if let data = data {
//                let downloadedImage = UIImage(data: data)
//                DispatchQueue.main.async {
//                    self.flagImage.image = downloadedImage
//                }
//            }
//        }
//        task.resume()
        let dataPoints = ["Phục hồi", "Tử vong"]
        customizeChart(dataPoints: dataPoints, values: [Double(infoCountry.recovered!), Double(infoCountry.deaths!)])
    }
    
    func loadImage() {
        guard let flagUrl = URL(string: infoCountry.countryInfo?.flag ?? "") else {
            print("Flag Error")
            return
        }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: flagUrl) else {
                return
            }
            DispatchQueue.main.async {
                self.flagImage.image = UIImage(data: data)
            }
        }
    }
    
    func setDisplay() {
        titleConfirmedLabel.setDefaultTitleField()
        titleDeathsLabel.setDefaultTitleField()
        titleRecoveredLabel.setDefaultTitleField()
        
        dailyConfirmed.setDefaultFont()
        dailyDeaths.setDefaultFont()
        dailyRecovered.setDefaultFont()
        
        totalConfirmed.setDefaultFont()
        totalDeaths.setDefaultFont()
        totalRecovered.setDefaultFont()
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        if let cases = infoCountry.cases {
            pieChartView.centerText = "Tổng số nhiễm \(cases)"
        }
            
            // 1. Set ChartDataEntry
            var dataEntries: [ChartDataEntry] = []
            for i in 0..<dataPoints.count {
                let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
                dataEntries.append(dataEntry)
            }
            // 2. Set ChartDataSet
    //        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: nil)
            let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
//            pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        pieChartDataSet.colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)]
            // 3. Set ChartData
            let pieChartData = PieChartData(dataSet: pieChartDataSet)
            let format = NumberFormatter()
            format.numberStyle = .none
            let formatter = DefaultValueFormatter(formatter: format)
            pieChartData.setValueFormatter(formatter)
            // 4. Assign it to the chart’s data
            pieChartView.data = pieChartData
        }
        
        private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
            var colors: [UIColor] = []
            for _ in 0..<numbersOfColor {
                let red = Double(arc4random_uniform(256))
                let green = Double(arc4random_uniform(256))
                let blue = Double(arc4random_uniform(256))
                let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
                colors.append(color)
            }
            return colors
        }
    
}

