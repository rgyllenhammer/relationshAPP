//
//  User.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/26/20.
//

import Foundation

class User : ObservableObject {
    var sendTo: String?
    var sendFrom: String?
    
    init(sendTo: String, sendFrom: String?) {
        self.sendTo = sendTo
        self.sendFrom = sendFrom
    }
}
