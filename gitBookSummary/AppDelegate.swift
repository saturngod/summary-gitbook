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


  var filePath:String = ""
  
  @IBOutlet weak var summaryMenu: NSMenuItem!
  @IBOutlet weak var runMenu: NSMenuItem!
  
  @IBOutlet weak var editMenu: NSMenuItem!
  @IBAction func didClickOpen(sender: NSMenuItem) {
    
    openFile();
    
  }
  
  func showAlert() {
    
    let myPopup:NSAlert = NSAlert()
    myPopup.messageText = "SUMMARY.md not found !";
    myPopup.informativeText = "Please chose the correct gitbook folder that include SUMMARY.md."
    myPopup.runModal()
    
  }
  @IBAction func openSummaryMD(sender: NSMenuItem) {
    
    NSWorkspace.sharedWorkspace().openFile(filePath + "/SUMMARY.md")
    
  }
  
  @IBAction func runFromTerminal(sender: NSMenuItem) {
    
/*NSString *s = [NSString stringWithFormat:
@"tell application \"Terminal\" to do script \"cd %@\"", folderPath];

NSAppleScript *as = [[NSAppleScript alloc] initWithSource: s];
[as executeAndReturnError:nil];*/
    var s = "tell application \"Terminal\" to do script \"gitbook serve \(filePath)\""
    
    var appleScript = NSAppleScript(source: s)
    appleScript?.executeAndReturnError(nil)
    

  }
  func openFile() {
    
    menuStage(false)
    
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
          
          self.filePath = url.path!

          var isDir : ObjCBool = false
          if(NSFileManager.defaultManager().fileExistsAtPath(self.filePath + "/SUMMARY.md", isDirectory: &isDir))
          {
            if(!isDir) {
              
              var vc = NSApplication.sharedApplication().mainWindow?.contentViewController as! ViewController
              vc.getTheSummary(self.filePath)
              
              
                  self.menuStage(true)
              
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

    menuStage(false)
    
    
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }
  
  func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
    return true
  }
  
  func menuStage(opened:Bool) {
    
    summaryMenu.hidden = !opened
    summaryMenu.enabled = opened
    editMenu.hidden = !opened
    runMenu.enabled = opened
  }


}

