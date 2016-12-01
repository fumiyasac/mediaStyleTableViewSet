//
//  AppDelegate.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/28.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /**
         * Navigation部分は今回はコードで配置（Transitionの設定をコードで行うため）
         * 使用するStoryboard名とViewControllerに設定したIdentifierの値を元に一番最初に表示するViewControllerを取得する
         */
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        //UINavigationBarの戻るボタンのカスタマイズ（タイトルが出てしまうので画像に置換する）
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "arrow-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "arrow-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        //UINavigationControllerクラスを継承したカスタムクラスをルートとなるViewControllerに設定する
        let nav = TransitionNavigationController(rootViewController: controller)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

