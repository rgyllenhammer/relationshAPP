//
//  DbTestView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 12/6/20.
//

import SwiftUI
import UIKit
import Firebase

struct DbTestView: View {
    var ref = Database.database().reference()
    
    var body: some View {
        Button(action: {            
            
        }, label: {
            Text("Add to db")
        })
    }
}

struct DbTestView_Previews: PreviewProvider {
    static var previews: some View {
        DbTestView()
    }
}
