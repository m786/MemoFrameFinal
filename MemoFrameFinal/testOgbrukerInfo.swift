//
//  testOgbrukerInfo.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 09.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class testOgbrukerInfo{

    private var _brukerInfo: NSDictionary = [:]
    private var _testInfo: TestInfo!
    
    var brukerInfo: NSDictionary {
        set { _brukerInfo = newValue }
        get { return _brukerInfo }
    }
    
    var testInfo: TestInfo{
        set { _testInfo = newValue }
        get { return _testInfo }
    }


}
