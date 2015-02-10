//
//  XMLParser.swift
//  RSS Reader
//
//  Created by Yu Andrew - andryu on 1/7/15.
//  Copyright (c) 2015 Andrew Yu. All rights reserved.
//

import UIKit

@objc protocol XMLParserDelegate{

}

class XMLParser: NSObject, NSXMLParserDelegate {
    
    var parsedDataArray = [Dictionary<String, AnyObject>]()
    var currentDataDict = Dictionary<String, AnyObject>()
    var currentElement: String?
    var foundCharacters: String?
    var imagePath: String?
    
    func parseXMLContentsOfURL(urlString: String) -> Bool{
        let url = NSURL(string: urlString)
        if let parser = NSXMLParser(contentsOfURL: url) {
            parser.delegate = self
            return parser.parse()
        } else {
            println("xml parser object is nil")
            return false
        }
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        currentElement = elementName
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        let str = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if foundCharacters == nil {
            foundCharacters = str
        } else {
            foundCharacters = foundCharacters! + str
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        if (currentElement == elementName) {
            if (currentElement! == "title" && foundCharacters! != "Ray Wenderlich" ||
                currentElement! == "link" && foundCharacters! != "http://www.raywenderlich.com" ||
                currentElement! == "pubDate") {
                if currentElement! == "pubDate" {
                    var dateFormat = NSDateFormatter()
                    dateFormat.dateFormat = "EE, d LLLL yyyy HH:mm:ss Z"
                    if let date = dateFormat.dateFromString(foundCharacters!) {
                        currentDataDict[currentElement!] = date
                    }
                } else {
                    currentDataDict[currentElement!] = foundCharacters!
                }
            }
        }
        if (elementName == "item") {
            parsedDataArray.append(currentDataDict)
            currentDataDict = Dictionary<String, String>()
        }
        foundCharacters = nil
    }
    
    func parser(parser: NSXMLParser!, foundCDATA CDATABlock: NSData!) {
        if currentElement == "content:encoded" {
            if let cdataString = NSString(data: CDATABlock, encoding: NSUTF8StringEncoding) {
                if cdataString.componentsSeparatedByString("<img src=\"").count > 1 {
                    let temp = cdataString.componentsSeparatedByString("<img src=\"")[1] as NSString
                    if temp.componentsSeparatedByString("\" alt=\"").count > 1 {
                        if let imageLink = temp.componentsSeparatedByString("\" alt=\"")[0] as? NSString {
                            downloadAndSaveImageToPathWithURLString(imageLink)
                        }
                    }
                }
            }
        }
        currentDataDict["imagePath"] = imagePath
        imagePath = nil
    }
    
    func downloadAndSaveImageToPathWithURLString(URLString: String) {
        if let url = NSURL(string: URLString) {
            if var imageData = NSData(contentsOfURL: url) {
                let fileManager = NSFileManager.defaultManager()
                if let docDir = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0] as? NSURL {
                    let tempArray = URLString.componentsSeparatedByString("/")
                    imagePath = docDir.URLByAppendingPathComponent(tempArray[tempArray.count-1]).path
                    if !fileManager.fileExistsAtPath(imagePath!) {
                        var error: NSError?
                        imageData.writeToFile(imagePath!, options: nil, error: &error)
                        if error != nil {
                            println(error)
                        }
                    }
                }
            }
        }
    }

}
