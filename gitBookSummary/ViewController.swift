//
//  ViewController.swift
//  gitBookSummary
//
//  Created by Htain Lin Shwe on 17/3/15.
//  Copyright (c) 2015 comquas. All rights reserved.
//

import Cocoa

class ViewController: NSViewController , NSTableViewDataSource,NSTableViewDelegate {

  var tableData:Array<[String:String]> = []
  var folderPath:String = ""
  @IBOutlet var tableView: NSTableView!
  override func viewDidLoad() {
    super.viewDidLoad()

    //loadSummary();

    
  }
  override func viewDidAppear() {
    super.viewDidAppear()
    
    if let window =  self.view.window {
      window.makeKeyAndOrderFront(nil)
      window.level = Int(CGWindowLevelForKey(CGWindowLevelKey(kCGStatusWindowLevelKey)))
    }
  }
  
  func getTheSummary(filePath:String) {
    
    loadSummary(filePath)
  }
  
  func loadSummary(filePath:String) {
    
    // Do any additional setup after loading the view.
    var summaryMdFile = filePath + "/SUMMARY.md"
    folderPath = filePath
    if let summaryMdContent = String(contentsOfFile: summaryMdFile, encoding: NSUTF8StringEncoding, error: nil) {
      var summmaryParser = summary()
      self.tableData = summmaryParser.getSummaryFromMarkDown(summaryMdContent)
      self.tableView.reloadData()
    }

    
  }
  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }
  
  
  

  //tableview delegate and datasource
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return self.tableData.count
  }
  

  func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
    
    var info:[String:String] = self.tableData[row]
    
    var str =  info["title"]!
    var levelStr = info["level"]
    var loopCount = levelStr?.toInt()
    
    for(var i=0; i < loopCount; i++) {
      str = " - " + str
    }
    
    return str
    
  }
  
  func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
    
    var info:[String:String] = self.tableData[row]
    
    if let href = info["href"] {
      var toOpen = folderPath + "/" + href
    
      NSWorkspace.sharedWorkspace().openFile(toOpen)
    }
    return true
  }
}

