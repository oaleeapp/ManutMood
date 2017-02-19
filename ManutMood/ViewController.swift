//
//  ViewController.swift
//  ManutMood
//
//  Created by lee on 16/02/2017.
//  Copyright © 2017 swiftwithme. All rights reserved.
//

import UIKit
import Moya
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
 
    @IBOutlet weak var emotionLabel: UILabel!
    
    let provider = MoyaProvider<MyService>()

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
                }
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

