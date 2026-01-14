//
//  ViewController.swift
//  MyApp
//
//  Created by ChunyangHuo on 2025/12/26.
//

import Cocoa
import yoga

class ViewController: NSViewController {
    
    override func loadView() {
        // Create the view programmatically
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 480, height: 270))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupYogaLayout()
    }
    
    private func setupYogaLayout() {
        // Create the root Yoga node (container)
        let root = YGNodeNew()!
        // YGFlexDirection: Column=0, ColumnReverse=1, Row=2, RowReverse=3
        YGNodeStyleSetFlexDirection(root, YGFlexDirection(rawValue: 2)!) // Row
        // YGJustify: FlexStart=0, Center=1, FlexEnd=2, SpaceBetween=3, SpaceAround=4, SpaceEvenly=5
        YGNodeStyleSetJustifyContent(root, YGJustify(rawValue: 3)!) // SpaceBetween
        // YGAlign: Auto=0, FlexStart=1, Center=2, FlexEnd=3, Stretch=4, Baseline=5
        YGNodeStyleSetAlignItems(root, YGAlign(rawValue: 2)!) // Center
        YGNodeStyleSetPadding(root, YGEdge(rawValue: 8)!, 20) // All
        YGNodeStyleSetWidth(root, Float(view.bounds.width))
        YGNodeStyleSetHeight(root, Float(view.bounds.height))
        
        // Create three child nodes
        let colors: [NSColor] = [.systemRed, .systemGreen, .systemBlue]
        var childNodes: [YGNodeRef] = []
        
        for i in 0..<3 {
            let child = YGNodeNew()!
            YGNodeStyleSetWidth(child, 100)
            YGNodeStyleSetHeight(child, 100)
            YGNodeInsertChild(root, child, Int(i))
            childNodes.append(child)
        }
        
        // Calculate the layout
        YGNodeCalculateLayout(root, Float(view.bounds.width), Float(view.bounds.height), YGDirection(rawValue: 0)!) // LTR
        
        // Apply the calculated layout to actual NSViews
        for (index, childNode) in childNodes.enumerated() {
            let x = CGFloat(YGNodeLayoutGetLeft(childNode))
            // Yoga uses top-left origin, AppKit uses bottom-left, so we need to flip Y
            let yogaTop = CGFloat(YGNodeLayoutGetTop(childNode))
            let height = CGFloat(YGNodeLayoutGetHeight(childNode))
            let y = view.bounds.height - yogaTop - height
            let width = CGFloat(YGNodeLayoutGetWidth(childNode))
            
            let childView = NSView(frame: NSRect(x: x, y: y, width: width, height: height))
            childView.wantsLayer = true
            childView.layer?.backgroundColor = colors[index].cgColor
            childView.layer?.cornerRadius = 8
            view.addSubview(childView)
        }
        
        // Free the Yoga nodes
        YGNodeFreeRecursive(root)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

