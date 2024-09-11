//
//  Extension.swift
//  Diary
//
//  Created by 副山俊輔 on 2024/09/11.
//

import Foundation

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
