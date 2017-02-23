//
//  EmotionState.swift
//  ManutMood
//
//  Created by lee on 22/02/2017.
//  Copyright © 2017 swiftwithme. All rights reserved.
//

import RealmSwift

class EmotionState: Object {

    dynamic var id: Int = 0
    dynamic var moodTitle: String = ""
    dynamic var moodDescription: String = ""
    dynamic var moodVoicePath: String = ""
    dynamic var energy: Int = 0
    dynamic var calm: Int = 0
    dynamic var anger: Int = 0
    dynamic var sorrow: Int = 0
    dynamic var joy: Int = 0
    dynamic var createdDate: Date = Date()
    dynamic var modifiedDate: Date = Date()

    convenience init(emotions: [String:Int], title: String, description: String, voicePath: String) {
        self.init() //Please note this says 'self' and not 'super'

        guard let energy = emotions["energy"],
                let calm = emotions["calm"],
                let anger = emotions["anger"],
                let sorrow = emotions["sorrow"],
                let joy = emotions["joy"] else {
                    print("Wrong key for emotions")
                    return
        }

        self.energy = energy
        self.calm = calm
        self.anger = anger
        self.sorrow = sorrow
        self.joy = joy
        self.moodTitle = title
        self.moodDescription = description
        self.moodVoicePath = voicePath
        self.createdDate = Date.init(timeIntervalSinceNow: 0)
        self.modifiedDate = Date.init(timeIntervalSinceNow: 0)

    }

    override static func indexedProperties() -> [String] {
        return ["moodTitle"]
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}
