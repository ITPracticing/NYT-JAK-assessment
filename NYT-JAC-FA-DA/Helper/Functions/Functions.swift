//
//  Helper.swift
//  NYT-JAC-FA-DA
//
//  Created by F_Sur on 17/03/2022.
//

import Foundation


/// Make shortf formt of 10 Characters "yyyy-MM-dd"
public func generateShortDateFortmat(date: String) -> String {
    var tempDate = date
    let ix = tempDate.startIndex // the index of 1st character
    let ix2 = tempDate.index(ix, offsetBy: 10) // the index of 8th character
    let ix3 = tempDate.index(ix, offsetBy: date.count - 1) // the index of 26th character
    tempDate.removeSubrange(ix2...ix3)
    return tempDate
}


