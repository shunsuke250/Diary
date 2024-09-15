//
//  Extension.swift
//  Diary
//
//  Created by 副山俊輔 on 2024/09/11.
//

import UIKit

public protocol Chainable {}

public extension Chainable {

    /// apply: 自分自身に対してクロージャを適用し、selfを返す
    @discardableResult
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }

    /// applied: 自分にクロージャを適用し、selfを返すが、discardable結果として使う
    @discardableResult
    func applied<T>(closure: (Self) -> T) -> Self {
        _ = closure(self)
        return self
    }

    /// execute: 自分自身に対してクロージャを実行し、その結果を返す
    @discardableResult
    func execute<T>(closure: (Self) -> T) -> T {
        return closure(self)
    }
}

extension NSObject: Chainable {}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

// MARK: - UITableView
public extension UITableView {
    func registerCell(_ cellType: UITableViewCell.Type) {
        let className = cellType.className
        register(cellType, forCellReuseIdentifier: className)
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}
