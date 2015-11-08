//
//  SEManager.swift
//  WinePiano
//
//  Copyright (c) 2015年 Haruyoshi Kuwamura. All rights reserved.
//

import Foundation
import AVFoundation //AVFoundationフレームワークをインポートする

class SEManager:NSObject,AVAudioPlayerDelegate{
    //var player:AVAudioPlayer? ← 削除
    //AVAudioPlayer を格納する配列を宣言
    var soundArray = [AVAudioPlayer]()
    
    //音を再生するsePlayメソッド
    func sePlay(soundName:String){
        //サウンドファイルを読み込む
        let url  = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent(soundName)
        do {
            let player = try AVAudioPlayer(contentsOfURL: url)
            soundArray.append(player)   //配列にplayerを追加する
            player.delegate = self
            player.prepareToPlay()     //音を即時再生する準備
            player.play()              //音を再生する
        }catch{
            print("Error!")
        }
    }
    //サウンド再生後に実行されるメソッド
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        //再生が終わった変数のインデックスを調べる
        let i:Int = soundArray.indexOf(player)!
        //上記で調べたインデックスの要素を削除する。
        soundArray.removeAtIndex(i)
    }
}
