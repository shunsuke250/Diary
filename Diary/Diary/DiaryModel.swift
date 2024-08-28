//
//  DiaryModel.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/11/26.
//

import Foundation
import CoreData

struct DiaryModelObject {
    /// 年
    var year: Int
    /// 月
    var month: Int
    /// 日
    var day: Int
    /// 曜日
    var weekday: Weekday
    /// 内容
    var content: String
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

        // 日付で降順にソートする
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Diary.date), ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        guard let diaryEntries = try? context.fetch(fetchRequest) else {
            return .init()
        }

        return diaryFormat(data: diaryEntries)
    }

    static func diaryFormat(data: [Diary]) -> [DiaryModelObject] {
        var formattedData = [DiaryModelObject]()

        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")

        data.forEach { diary in
            if let date = diary.date {
                let year = calendar.component(.year, from: date)
                let month = calendar.component(.month, from: date)
                let day = calendar.component(.day, from: date)

                let weekdayIndex = calendar.component(.weekday, from: date)
                guard let weekday = Weekday(rawValue: weekdayIndex) else {
                    return
                }

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
