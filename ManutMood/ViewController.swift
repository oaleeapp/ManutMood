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

    let provider = MoyaProvider<MyService>()

    override func viewDidLoad() {
        super.viewDidLoad()

        let sampleData = MyService.analyzeWav(audioData: Data()).sampleData

        provider.request(.analyzeWav(audioData: sampleData)) { result in

            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
//                let statusCode = moyaResponse.statusCode
            // do something with the response data or statusCode

                print(JSON(data))

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

