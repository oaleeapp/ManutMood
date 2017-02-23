//
//  ViewController.swift
//  ManutMood
//
//  Created by lee on 16/02/2017.
//  Copyright © 2017 swiftwithme. All rights reserved.
//  Ture Man - Damon

import UIKit
import Moya
import Alamofire
import SwiftyJSON
import RealmSwift
import Charts



class ViewController: UIViewController {
 
    @IBOutlet weak var emotionLabel: UILabel!
    
    let provider = MoyaProvider<MyService>()

    @IBOutlet weak var emotionPieChartView: PieChartView!
       override func viewDidLoad() {
        super.viewDidLoad()

        self.emotionLabel.text = "Hello World!"
        let sampleData = MyService.analyzeWav(audioData: Data()).sampleData

        provider.request(.analyzeWav(audioData: sampleData)) { result in
            
            switch result {
                
                
            case let .success(moyaResponse):
                let data = moyaResponse.data
            //let statusCode = moyaResponse.statusCode
            // do something with the response data or statusCode

                print(JSON(data))
                DispatchQueue.main.async() {
                    self.emotionLabel.text = JSON(data).dictionaryValue.description
                    let emotionsJSON = JSON(data).dictionaryValue
                    var entries: [PieChartDataEntry] = []
                    for (key, value) in emotionsJSON {
                        let newEntry = PieChartDataEntry(value: value.doubleValue, label: key)

                        entries.append(newEntry)

                    }
                    NSHomeDirectory()

                    let pieDataSet = PieChartDataSet(values: entries, label: "Emotion State")
                    pieDataSet.colors = [UIColor.blue,UIColor.red,UIColor.yellow,UIColor.green,UIColor.cyan]
                    let pieData = PieChartData(dataSets: [pieDataSet])
                    self.emotionPieChartView.data = pieData


//                    var entries: [RadarChartDataEntry] = []
//                    for (key, value) in emotionsJSON {
//                        let newEntry = RadarChartDataEntry(value: value.doubleValue, data: key as AnyObject?)
//
//                        entries.append(newEntry)
//
//                    }
//
//                    let pieDataSet = RadarChartDataSet(values: entries, label: "Emotion State")
//                    let pieData = RadarChartData(dataSets: [pieDataSet])
//                    self.emotionPieChartView.data = pieData

                    
                }

                


//                let emotions = ["energy":emotionsJSON["energy"]?.intValue,
//                                "calm":emotionsJSON["calm"]?.intValue,
//                                "anger":emotionsJSON["anger"]?.intValue,
//                                "sorrow":emotionsJSON["sorrow"]?.intValue,
//                                "joy":emotionsJSON["joy"]?.intValue]

//                let newEmotionState = EmotionState(emotions: emotions as! [String : Int], title: "new mood", description: "lalala", voicePath: "/test/test")

//                let realm = try! Realm()
//                
//                try! realm.write {
//                    realm.add(newEmotionState)
//                }




            case let .failure(error):

                print(error)
                
                }
        }
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//This is for learning pull request 

