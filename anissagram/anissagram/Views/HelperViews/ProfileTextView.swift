//
//  ProfileTextView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 1/14/21.
//

import SwiftUI

struct ProfileTextView: View {
    var textToDisplay : String
    var body: some View {
        HStack {
            Text(textToDisplay)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding(.bottom)
        .foregroundColor(.gray)
    }
}

