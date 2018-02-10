//
//  DataContainer.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

public struct DataContainer<WrappedValue: Decodable>: Decodable {
    
    var value: WrappedValue
}
