//
//  BaseVC.swift
//  APIExample
//
//  Created by 张乾泽 on 2020/4/17.
//  Copyright © 2020 Agora Corp. All rights reserved.
//

import Cocoa
import AGEVideoLayout

protocol BaseView: NSViewController {
    func showAlert(title: String?, message: String)
    func viewWillBeRemovedFromSplitView()
}

class BaseViewController: NSViewController, BaseView {
    var configs: [String:Any] = [:]
    
    func showAlert(title: String? = nil, message: String) {
        let alert = NSAlert()
        alert.alertStyle = .critical
        alert.addButton(withTitle: "OK")
        if let stitle = title {
            alert.messageText = stitle
        }
        alert.informativeText = message
        
        alert.runModal()
    }
    
    func getAudioLabel(uid:UInt, isLocal:Bool) -> String {
        return "AUDIO ONLY\n\(isLocal ? "Local" : "Remote")\n\(uid)"
    }
    
    func viewWillBeRemovedFromSplitView() {}
}

extension AGEVideoContainer {
    func layoutStream(main: NSView, list: [NSView]) {
        let fullLayout = AGEVideoLayout(level: 0)
            .startPoint(x: 110, y: 5)
            .size(.constant(CGSize(width: self.frame.width - 115, height: self.frame.height - 10)))
        
        let scrollHeight = self.frame.height - 10
        main.removeFromSuperview()
        for view in list {
            view.removeFromSuperview()
        }
        
        let scrollLayout = AGEVideoLayout(level: 1)
            .scrollType(.scroll(.vertical))
            .startPoint(x: 5, y: 5)
            .size(.constant(CGSize(width: 100, height: scrollHeight)))
            .lineSpacing(5)
            .itemSize(.constant(CGSize(width: 100, height: 100)))
        
        
        self.listCount {[list] (level) -> Int in
            var count = 1
            if level == 1 {
                count = list.count
            } else {
                
            }
            return count
        }.listItem {[list] (index) -> NSView in
            if index.level == 0 {
                return main
            } else {
                let view = list[index.item]
                return view
            }
        }
        
        self.removeAllLayouts()
        self.setLayouts([fullLayout, scrollLayout])
    }
    
    func layoutStream(views: [NSView]) {
        let count = views.count
        
        var layout: AGEVideoLayout
        
        switch count {
        case 1:
            layout = AGEVideoLayout(level: 0)
            .itemSize(.scale(CGSize(width: 1, height: 1)))
            break
        case 2:
            layout = AGEVideoLayout(level: 0)
                .itemSize(.scale(CGSize(width: 1, height: 0.5)))
            break
        case 4:
            layout = AGEVideoLayout(level: 0)
                .itemSize(.scale(CGSize(width: 0.5, height: 0.5)))
            break
        case 9:
            layout = AGEVideoLayout(level: 0)
                .itemSize(.scale(CGSize(width: 0.33, height: 0.33)))
            break
        case 16:
            layout = AGEVideoLayout(level: 0)
                .itemSize(.scale(CGSize(width: 0.25, height: 0.25)))
            break
        default:
            return
        }
        
        layout = layout.interitemSpacing(5).lineSpacing(5)
        
        self.listCount { (level) -> Int in
            return views.count
        }.listItem { (index) -> AGEView in
            return views[index.item]
        }
        
        self.setLayouts([layout])
    }
    
    func layoutStream2(views: [NSView]) {
        let count = views.count
        
        var layout: AGEVideoLayout
        
        switch count {
        case 2:
            layout = AGEVideoLayout(level: 0)
                .itemSize(.scale(CGSize(width: 0.5, height: 1)))
            break
        default:
            return
        }
        
        self.listCount { (level) -> Int in
            return views.count
        }.listItem { (index) -> AGEView in
            return views[index.item]
        }
        
        self.setLayouts([layout])
    }
    
    func layoutStream3x3(views: [NSView]) {
        let count = views.count
        
        var layout: AGEVideoLayout
        
        if count > 9  {
            return
        } else {
            layout = AGEVideoLayout(level: 0)
                .itemSize(.scale(CGSize(width: 0.33, height: 0.33)))
        }
        
        self.listCount { (level) -> Int in
            return views.count
        }.listItem { (index) -> AGEView in
            return views[index.item]
        }
        
        self.setLayouts([layout])
    }
}
