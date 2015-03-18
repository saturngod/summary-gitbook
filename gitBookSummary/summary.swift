//
//  SUMMARY.swift
//  gitBookSummary
//
//  Created by Htain Lin Shwe on 18/3/15.
//  Copyright (c) 2015 comquas. All rights reserved.
//

import Foundation

public class summary {
  
  public func getSummaryFromMarkDown(md:String) -> Array<[String:String]> {
    
    var markdown = Markdown()
    let outputHtml: String = markdown.transform(md)
    
    return self.getSummaryFromHTML(outputHtml)
  }
  
  public func getSummaryFromHTML(html:String) -> Array<[String:String]> {
    
    var err : NSError?
    var parser     = HTMLParser(html: html, error: &err)
    if err != nil {
      println(err)
      exit(1)
    }
    
    var bodyNode   = parser.body
    
    var links:Array<[String:String]> = []
    if let ulNode = bodyNode?.findChildTag("ul") {
      
      links = getData(ulNode)
      
    }
    
    return links
    
  }
  
  
  public func getData(ulNode:HTMLNode) -> Array<[String:String]> {
    
    var links:Array<[String:String]> = []
    
    getDataWithLevel(ulNode,level: 0,reArr: &links)
    
    return links
  }
  
  func getDataWithLevel(ulNode:HTMLNode,level:NSInteger,inout reArr:Array<[String:String]>) {
    var lis = ulNode.findChildTagsAtFirstLevel("li")
    
    for li in lis {
      
      var aTag:HTMLNode = li.findChildTag("a")!
      
      var href = aTag.getAttributeNamed("href")
      
      //println("level : \(level) , A: \(aTag?.contents) \n===\n")
      var dataInfo:[String:String] = ["level" : "\(level)","title": aTag.contents,"href":href]
      
      reArr.append(dataInfo)
      
      var uls = li.findChildTagsAtFirstLevel("ul")
      
      for ul in uls {
        var next = level + 1
        getDataWithLevel(ul,level:next,reArr: &reArr)
      }
      
      
    }
    
  }

}
