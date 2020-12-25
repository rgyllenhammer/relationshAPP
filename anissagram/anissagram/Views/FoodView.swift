//
//  FoodView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/26/20.
//

import SwiftUI

struct RestauantItem: Identifiable{
    let id: Int
    let name: String
}

struct FoodView: View {
    
    func buttonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 4 * 10) / 3
    }
    
    @State var stringToAdd = ""
    @State var dinnerDecided = false
    @State var dinner : RestauantItem? = nil
    @State var choices : [RestauantItem] = [
        RestauantItem(id: 0, name: "Manpuku"),
        RestauantItem(id: 1, name: "Me ;)"),
    ]
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        VStack{
            HStack{
                Text("Choices:").font(.largeTitle).fontWeight(.bold)
                Spacer()
            }.padding(.top)
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(choices){ choice in
                        ChoiceView(choices: $choices, name: choice.name, colorIndex: choice.id).padding(.bottom, 1)
                    }
                }
            }
            HStack{
                Text("Add more:").font(.largeTitle).fontWeight(.bold)
                Spacer()
            }
            TextField("Restaurant...", text: $stringToAdd)
                .padding(.all, 5)
                .font(.title2)
                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                .cornerRadius(5)
                
            HStack{
                Button(action: {
                    if (stringToAdd.count > 0){
                        let newChoice = RestauantItem(id: choices.count, name: stringToAdd)
                        choices.append(newChoice)
                        stringToAdd = ""
                    }
    
                }, label: {
                    Text("Add Restaurant").foregroundColor(.red)
                })
                
                Spacer()
                
                Button(action: {
                    dinnerDecided = true
                    dinner = choices.randomElement()!
                }, label: {
                    Text("Generate Dinner").foregroundColor(.orange)
                })
                
            }
            .font(.title2)
            HStack{
                if (dinnerDecided){
                    ChoiceView(choices: $choices, name: dinner!.name, colorIndex: dinner!.id)
                } else {
                    Text("Dinner at ...")
                        .frame(width: buttonWidth(), height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .foregroundColor(.gray)
                        .cornerRadius(20)
                }

            }.padding()
            
            
        }.padding(.horizontal)
    }
}

struct ChoiceView: View{
    @Binding var choices : [RestauantItem]
    var colors: [Color] = [.red, Color(red: 254/255, green: 97/255, blue: 43/255, opacity: 1), .orange]
    var name: String
    var colorIndex: Int
    var body: some View{
        VStack{
            Text(name)
        }
        .frame(width: buttonWidth(), height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(colors[colorIndex % 3])
        .foregroundColor(.white)
        .cornerRadius(20)
        .onTapGesture {
            choices.removeAll{(rest) -> Bool in
                              return rest.name == name
            }
        }
    }
    
    func buttonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 4 * 10) / 3
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView()
    }
}
