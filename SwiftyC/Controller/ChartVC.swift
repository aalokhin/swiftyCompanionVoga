//
//  ChartVC.swift
//  SwiftyC
//
//  Created by ANASTASIA on 7/16/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import UIKit
import Charts

class  ChartVC : UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var chart: RadarChartView!
    var allSkills : [SkillForChart] = []
    var skillNames : [String] = []
    var skillValues : [Double] = []
    var userSkills : [Skill] = []
    

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            self.clearAll()
            
            print("42 selected")
            setCursus("42")
        case 1:
            self.clearAll()

            print("piscine c selected")
           setCursus("piscine-c")
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hey from Charts VC!")
        chart.delegate = self
        //chart.chartDescription?.enabled = true

        setCursus("42")
        
       
}
    func clearAll(){
        allSkills = []
        skillNames = []
        skillValues = []
        userSkills = []
        chart.clear()
    }
    func setCursus (_ cursusName : String) {
        guard let cursusUsers = Client.sharedInstance.currrentUser?.cursus_users else { return }
        let index = cursusUsers.index(where: { (item) -> Bool in
            item.cursus?.slug == cursusName
        })
        guard let i = index else {
            print("No cursus  detected")
            self.navigationController?.popViewController(animated: true)
            return
        }
        guard let skills = cursusUsers[i].skills else {
            print("No skills detected")
            self.navigationController?.popViewController(animated: true)
            return
        }
        userSkills = skills
        setSkills(cursusName)
        let sortedSkills = allSkills.sorted{$0.name<$1.name}
        for skill in sortedSkills{
            skillNames.append(skill.name )
            skillValues.append(skill.level)
        }
        setChart(dataPoints: skillNames, values: skillValues)
    }

   
    func setChart(dataPoints: [String], values: [Double]) {
        
      
        let yAxis = chart.yAxis
        yAxis.labelPosition = .insideChart
       
        // this adds labels
        let xAxis = chart.xAxis
        chart.xAxis.valueFormatter = self
        xAxis.labelPosition = .bottom
//        xAxis.valueFormatter
        xAxis.labelFont = .systemFont(ofSize: 5, weight: .light)
        xAxis.drawLabelsEnabled = true

        
        
        
        chart.noDataText = "You need to provide data for the chart."
        var dataEntries: [RadarChartDataEntry] = []
        for i in 0..<dataPoints.count {
           // let str : String = dataPoints[i]
            let dataEntry = RadarChartDataEntry(value: values[i])
            //print(dataEntry.value)
            //print(dataEntry.data ?? "none")
           // print("*******************************")
            dataEntries.append(dataEntry)
        }
        let chartDataSet = RadarChartDataSet(values: dataEntries, label: "Skill")
        chartDataSet.setColor(UIColor(red: 0.4588, green: 0.7137, blue: 0.4, alpha: 1.0))
        chartDataSet.fillColor = UIColor(red: 0.4588, green: 0.7137, blue: 0.4, alpha: 1.0)
        chartDataSet.drawFilledEnabled = true
        chartDataSet.fillAlpha = 0.7
        chartDataSet.lineWidth = 2
        chartDataSet.drawHighlightCircleEnabled = true
        chartDataSet.setDrawHighlightIndicators(false)
        
        
        let chartData = RadarChartData(dataSet: chartDataSet) //(xVals: dataPoints, dataSet: chartDataSet)
 
        
        chartData.setValueFont(.systemFont(ofSize: 12, weight: .light))
        //chartData.setDrawValues(false)
        chartData.setValueTextColor(.black)
        
        
        chart.data = chartData
        chart.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)

    }
    
    func setSkills(_ cursusName : String) {
        var arraySkills : [String] = []
        if (cursusName == "42")
        {
            arraySkills =  Client.sharedInstance.allSkills42
        } else {
            arraySkills = Client.sharedInstance.allSkillsC
        }
        
        for one in arraySkills {
            allSkills.append(SkillForChart(n : one, l : 0))
        }
        
        for one in allSkills {
            let element = userSkills.first(where: { (item) -> Bool in
                item.name == one.name
            })
            if let addEl = element {
                one.level = addEl.level ?? 0
            }
            
        }
        // TO DO!! This is horrible please fix it
        
       for one in allSkills {
            let element = allSkills.first(where: { (item) -> Bool in
                item.name == "Network & system administration"
            })
            if let el = element {
                el.name = "Network & system\nadministration"
            }
        
            let element2 = allSkills.first(where: { (item) -> Bool in
                item.name ==  "Object-oriented programming"
            })
            if let el = element2 {
                el.name = "Object-oriented\nprogramming"
            }
        
        }
        
//        for one in allSkills {
//
//        }
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`")
        
//        for one in allSkills {
//            print(one.name)
//            print(one.level)
//        }
    }
    

}

extension ChartVC: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return skillNames[Int(value) % allSkills.count]
    }
}
