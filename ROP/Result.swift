//
//  Result.swift
//  ROP
//
//  Created by Sean.Yue on 2019/7/25.
//  Copyright © 2019 Sean.Yue. All rights reserved.
//

import Foundation

public enum Result<T, E> {
    case ok(T)
    case error(E)
}

extension Result {
    public func bind<B>(_ f: @escaping (T) -> Result<B, E>) -> Result<B, E> {
        switch self {
        case .ok(let x):
            return f(x)
        case .error(let e):
            return Result<B, E>.error(e)
        }
    }
}
