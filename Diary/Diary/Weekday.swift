//
//  Weekday.swift
//  Diary
//
//  Created by 副山俊輔 on 2024/08/28.
//

import UIKit

enum Weekday: Int, CaseIterable {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    var displayName: String {
        switch self {
        case .sunday: return "日"
        case .monday: return "月"
        case .tuesday: return "火"
        case .wednesday: return "水"
        case .thursday: return "木"
        case .friday: return "金"
        case .saturday: return "土"
        }
    }

    var color: UIColor {
        switch self {
        case .sunday:
                .red
        case .saturday:
                .blue
        default:
                .black
        }
    }
}
