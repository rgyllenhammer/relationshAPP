//
//  PageTitleView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 1/14/21.
//

import SwiftUI

struct PageTitleView: View {
    var title : String
    var body: some View {
        HStack{
            Text(title).font(.largeTitle).fontWeight(.bold)
            Spacer()
        }
    }
}

