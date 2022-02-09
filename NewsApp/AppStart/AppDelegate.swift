//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 04/02/22.
//

import UIKit
import RIBs
@_exported import Rswift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var launchRouter: LaunchRouting?
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        launchRouter = RootBuilder(dependency: AppComponent()).build()
        launchRouter?.launchFromWindow(window)

        return true
    }
}
