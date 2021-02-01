//
//  PopListView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 1/12/21.
//

import SwiftUI

struct PoplistView: View {
    
    var userNames : [String]
    @Binding var lastPick : String
    @Binding var show : Bool
    
    var body : some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Text("Relationships:").font(.title).fontWeight(.bold)
                    Spacer()
                }
                ForEach(userNames, id: \.self) { name in
                    ZStack(alignment: .trailing) {
                        HStack {
                            Image("anissagram").resizable()
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("@\(name)").fontWeight(.semibold)
                                Text("Choose Relationship")
                                Divider()
                            }
                            .padding(.top)

                        }.onTapGesture {
                            lastPick = name
                            show.toggle()
                        }
                        Image(systemName: "arrow.right").foregroundColor(.gray)
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .frame(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - 250 , alignment: .center)
        .cornerRadius(10.0)
    }
}
