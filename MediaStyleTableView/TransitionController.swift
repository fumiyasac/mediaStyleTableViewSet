//
//  TransitionController.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/29.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//画面遷移時に使用するアニメーションの実装をUIViewControllerAnimatedTransitioningを採用したクラスにて行う
class TransitionController: NSObject, UIViewControllerAnimatedTransitioning {

    //遷移の方向を決定するためのメンバ変数
    //(case1) Push → forward == true
    //(case2) Pop  → forward == false
    var forward = false
    
    //アニメーションの時間を定義する
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    /**
     * アニメーションの実装を定義する
     * この場合には画面遷移コンテキスト（UIViewControllerContextTransitioningを採用したオブジェクト）
     * → 遷移元や遷移先のViewControllerやそのほか関連する情報が格納されているもの
     */
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if forward {
            
            //Push時のアニメーションを実行する
            forwardTransition(transitionContext)
            
        } else {

            //Pop時のアニメーションを実行する
            backwardTransition(transitionContext)
        }
    }
    
    //Push時のアニメーションを実行するメソッド（引数は画面遷移時のコンテキスト）
    fileprivate func forwardTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        //コンテキストを元にViewControllerのインスタンスを取得する（存在しない場合は処理を終了）
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        //アニメーションの実態となるコンテナビューを作成
        let containerView = transitionContext.containerView
        
        //遷移先のviewをaddSubviewする（fromVC.viewは最初からcontainerViewがsubviewとして持っている）
        containerView.addSubview(toVC.view)
        
        //addSubviewでレイアウトが崩れるため再レイアウトする
        toVC.view.layoutIfNeeded()
        
        //アニメーション用のimageViewを新しく作成する（遷移元及び遷移先と一緒に行う）
        guard let sourceImageView = (fromVC as? ViewController)?.createImageView() else {
            return
        }
        guard let destinationImageView = (toVC as? DetailController)?.createImageView() else {
            return
        }
        
        //遷移先のimageViewをaddSubviewする
        containerView.addSubview(sourceImageView)
        
        //遷移先のアルファ値を0にしておく
        toVC.view.alpha = 0.0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.05, options: UIViewAnimationOptions(), animations: {
            
            //アニメーションを開始し、遷移先のimageViewのframeとcontetModeを遷移元のimageViewに代入する
            sourceImageView.frame = destinationImageView.frame
            sourceImageView.contentMode = destinationImageView.contentMode
            
            //遷移元に配置したCollectionView内にあるcellのimageViewを非表示にする
            (fromVC as? ViewController)?.selectedImageView?.isHidden = true
            
            //遷移先のアルファ値を1に変更する
            toVC.view.alpha = 1.0
            
        }, completion: { finished in
            
            //アニメーションを終了する
            transitionContext.completeTransition(true)
        })
    }
    
    //Pop時のアニメーションを実行するメソッド（引数は画面遷移時のコンテキスト）
    fileprivate func backwardTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        //コンテキストを元にViewControllerのインスタンスを取得する（存在しない場合は処理を終了）※Pushと逆のアニメーション
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        let containerView = transitionContext.containerView
        
        /**
         * アニメーションの実態となるコンテナビューを作成
         * 最初からcontainerViewがsubviewとして持っているfromVC.viewを削除
         */
        fromVC.view.removeFromSuperview()
        
        //遷移先のviewをaddSubviewする（toView -> fromViewの順にaddSubview）
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        
        guard let sourceImageView = (fromVC as? DetailController)?.createImageView() else {
            return
        }
        guard let destinationImageView = (toVC as? ViewController)?.createImageView() else {
            return
        }

        //遷移元のimageViewをaddSubviewする
        containerView.addSubview(sourceImageView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.05, options: UIViewAnimationOptions(), animations: {
            
            //アニメーションを開始し、画像を遷移元のimageViewのframeに合わせて遷移元のアルファを0にする
            sourceImageView.frame = destinationImageView.frame
            fromVC.view.alpha = 0.0
            
        }, completion: { finished in
            
            //遷移元のimageViewを見えない状態にして、遷移先のimageViewを見える状態にする
            sourceImageView.isHidden = true
            (toVC as? ViewController)?.selectedImageView?.isHidden = false
            
            //アニメーションを終了する
            transitionContext.completeTransition(true)
        })
    }

}
