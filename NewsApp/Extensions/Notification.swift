//
//  NotificationExtension.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 08/02/22.
//

import Foundation

extension Notification.Name {
    static let refreshData = Notification.Name(R.string.localization.refresh())
}

@objc extension NSNotification {
    public static let refreshData = Notification.Name.refreshData
}
