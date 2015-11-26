//
//  RecordedAudio.swift
//  Pich Perfect
//
//  Created by Javier C. Melendrez on 11/22/15.
//  Copyright © 2015 com.javier. All rights reserved.
//

import Foundation

class RecordedAudio{
    var filePathUrl: NSURL!
    var title: String!
    
    init(titleParam:String, filePathParam:NSURL) {
        filePathUrl = filePathParam
        title = titleParam
    }
    
}