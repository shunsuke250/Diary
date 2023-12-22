//
//  DiaryModel.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/11/26.
//

import Foundation
struct DiaryModelObject {
    var year: Int // 年
    var month: Int // 月
    var day: Int // 日
    var weekday: String // 曜日
    var content: String // 日記
}

struct DiaryModel {
    var date: Date
    var contents: String
}
