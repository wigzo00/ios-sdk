//
//  WigzoDispatchQueue.swift
//  
//
//  Created by Rihan on 24/11/22.
//

import Foundation

private let dispatchQueue = DispatchQueue(label: Configuration.STORAGE_KEY.value())

internal class WigzoDispatchQueue {
    static func execute(executable : @escaping () -> Void) -> Void {
        dispatchQueue.async {
            executable()
        }
    }
}
