//
//  ProfileImageView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 1/14/21.
//

import SwiftUI

struct ProfileImageView: View {
    var captionText : String
    var body: some View {
        VStack {
            Image("anissagram")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)

            HStack {
                Text(captionText).font(.caption)
                Spacer()
            }.padding(.bottom).foregroundColor(.black)
        }
    }
}

