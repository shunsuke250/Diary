//
//  DiaryModel.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/11/26.
//

import Foundation
import CoreData

struct DiaryModelObject {
    var year: Int // 年
    var month: Int // 月
    var day: Int // 日
    var weekday: String // 曜日
    var content: String // 日記
}

struct DiaryModel {
    static func saveDiary(date: Date, content: String) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.perform {
            // 新しいDiaryEntryインスタンスの作成
            guard let newEntry = NSEntityDescription.insertNewObject(
                forEntityName: "Diary", into: context
            ) as? Diary else {
                return
            }
            newEntry.date = date
            newEntry.content = content

            do {
                try context.save()
            } catch let error as NSError {
                print("保存に失敗: \(error), \(error.userInfo)")
            }
        }
    }

    static func fetchDiary() -> [DiaryModelObject] {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Diary> = Diary.fetchRequest()

        do {
            let diaryEntries = try context.fetch(fetchRequest)
            return diaryFormat(data: diaryEntries)
        } catch let error as NSError {
            print("読み込みに失敗: \(error), \(error.userInfo)")
            return [DiaryModelObject(year: 2023, month: 2, day: 21, weekday: "日", content: "このように文章を\n改行して入力することができます。\nこのアプリはLifeBearの日記機能のUIを参考にして\n作成されています。")]
        }
    }

    static func diaryFormat(data: [Diary]) -> [DiaryModelObject] {
        var formattedData = [DiaryModelObject]()

        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        yearFormatter.locale = Locale(identifier: "ja_JP")
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        monthFormatter.locale = Locale(identifier: "ja_JP")
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        dayFormatter.locale = Locale(identifier: "ja_JP")
        
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE"
        weekdayFormatter.locale = Locale(identifier: "ja_JP")
        
        data.forEach { diary in
            if let date = diary.date {
                let year = Int(yearFormatter.string(from: date)) ?? 0
                let month = Int(monthFormatter.string(from: date)) ?? 0
                let day = Int(dayFormatter.string(from: date)) ?? 0
                let weekday = weekdayFormatter.string(from: date)
                let content = diary.content ?? ""

                let diaryModel = DiaryModelObject(
                    year: year, month: month, day: day, weekday: weekday, content: content
                )
                formattedData.append(diaryModel)
            }
        }

        return formattedData
    }
}
