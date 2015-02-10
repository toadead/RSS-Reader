// Playground - noun: a place where people can play

import UIKit
import Foundation

/*
let imageURLString = "http://cdn2.raywenderlich.com/wp-content/uploads/2014/11/corecontrols2-250x250.png"
var data = NSData(contentsOfURL: NSURL(string: imageURLString)!);
let image = UIImage(data: data!)
data = UIImageJPEGRepresentation(image, 0.0)

let fileManager = NSFileManager.defaultManager()
let docDir = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0] as NSURL
println(docDir.path)
let imagePath = docDir.path! + "/image1.png"
data?.writeToFile(imagePath, atomically: true)
*/


println(NSSearchPathDirectory.DocumentationDirectory.rawValue)
println(NSSearchPathDomainMask.UserDomainMask.rawValue)