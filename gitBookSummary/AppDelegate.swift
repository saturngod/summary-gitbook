//
//  AppDelegate.swift
//  gitBookSummary
//
//  Created by Htain Lin Shwe on 17/3/15.
//  Copyright (c) 2015 comquas. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


  @IBAction func didClickOpen(sender: NSMenuItem) {
    

    
    openFile();
    
  }
  
  func showAlert() {
    
    let myPopup:NSAlert = NSAlert()
    myPopup.messageText = "SUMMARY.md not found !";
    myPopup.informativeText = "Please chose the correct gitbook folder that include SUMMARY.md."
    myPopup.runModal()
    
  }
  func openFile() {
    var openPanel = NSOpenPanel()
    
    openPanel.title = "Choose A Gitbook Folder"
    openPanel.showsResizeIndicator = true
    openPanel.showsHiddenFiles = false
    openPanel.canChooseDirectories = true
    openPanel.canChooseFiles = false
    openPanel.allowsMultipleSelection = false
    
    openPanel.beginWithCompletionHandler { (result) -> Void in
      if result == NSFileHandlingPanelOKButton {
        
        if let url = openPanel.URL {
          
          var filePath = url.path!
          
          println(filePath + "/SUMMARY.md")
          
          var isDir : ObjCBool = false
          if(NSFileManager.defaultManager().fileExistsAtPath(filePath + "/SUMMARY.md", isDirectory: &isDir))
          {
            if(!isDir) {
              var vc = NSApplication.sharedApplication().mainWindow?.contentViewController as ViewController
              vc.getTheSummary(filePath)
            }
            else {
              self.showAlert();
              self.openFile();
            }
          }
          else {
            self.showAlert();
            self.openFile();
          }

          
        }
        
        
        
      }
    }
  }

  func applicationDidFinishLaunching(aNotification: NSNotification) {
    // Insert code here to initialize your application


    
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }


}

