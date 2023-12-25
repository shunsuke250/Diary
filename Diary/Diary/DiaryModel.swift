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
}
