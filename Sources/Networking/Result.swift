//
//  Result.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
