//
//  PermissionCheckable.swift
//  YPImagePicker
//
//  Created by Sacha DSO on 25/01/2018.
//  Copyright © 2016 Yummypets. All rights reserved.
//

import UIKit

internal protocol YPPermissionCheckable {
    func doAfterLibraryPermissionCheck(completion: @escaping ((Bool) -> ()))
    func doAfterCameraPermissionCheck(block: @escaping () -> Void)
    func checkLibraryPermission()
    func checkCameraPermission()
}

internal extension YPPermissionCheckable where Self: UIViewController {
    func doAfterLibraryPermissionCheck(completion: @escaping ((Bool) -> ())){
        YPPermissionManager.checkLibraryPermissionAndAskIfNeeded(sourceVC: self) { hasPermission in
            if hasPermission {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    func doAfterCameraPermissionCheck(block: @escaping () -> Void) {
        YPPermissionManager.checkCameraPermissionAndAskIfNeeded(sourceVC: self) { hasPermission in
            if hasPermission {
                block()
            } else {
                ypLog("Not enough permissions.")
            }
        }
    }

    func checkLibraryPermission() {
        YPPermissionManager.checkLibraryPermissionAndAskIfNeeded(sourceVC: self) { _ in }
    }
    
    func checkCameraPermission() {
        YPPermissionManager.checkCameraPermissionAndAskIfNeeded(sourceVC: self) { _ in }
    }
}
