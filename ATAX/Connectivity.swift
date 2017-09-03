//
//  Connectivity .swift
//  ATAX
//
//  Created by Paul on 9/3/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity
{
    class var isConnectedToInternet: Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
}
