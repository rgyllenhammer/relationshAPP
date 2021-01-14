//
//  NothingToDisplayView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 1/14/21.
//

import SwiftUI

struct NothingToDisplayView: View {
    var body: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text("Nothing to display")
        }
        .foregroundColor(.gray)
        .padding(.top)
    }
}

struct NothingToDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        NothingToDisplayView()
    }
}
