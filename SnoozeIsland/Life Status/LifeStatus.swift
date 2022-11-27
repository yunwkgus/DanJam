//
//  LifeStatus.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/01/03.
//

import SwiftUI


var creatures = ["Cloud tree", "Three-tailed cat", "rose mushroom", "star rock bear", "water drop grass", "Shining O deer"]


var img_name = ["tree", "cat", "mushroom1", "bear", "grass", "deer"]

var descriptions = [ "Clouds bloom instead of leaes.", "It has a three-pronged tail and small horns.", "The cap looks like a rose.", "It has a skin with luminous rocks.", "It is a grass full of water drops.", "A deer has white stripe forming an ‘O’."]


struct LifeStatus: View {
    @EnvironmentObject var data_Test: Data_Test
    @State var selection: Int? = nil
    
    
    
    
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode





    var body: some View {
        
        
        
        NavigationView{
            
        ZStack{
            

            
            Image(data_Test.day as! Bool ? "Day_background" : "Night_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
            
            
            
        
            
            GeometryReader { proxy in
                
  
                VStack(spacing : 0){

                    ZStack(alignment: .center){
                    
                        Text("Life Status").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white)

                    
                    }.frame(width: proxy.size.width, height: proxy.size.height/10, alignment: .center).padding(EdgeInsets(top: proxy.size.height/30, leading: 0, bottom: 0, trailing: 0))
                    
                    Divider().foregroundColor(.white).frame(width: proxy.size.width * 0.8).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    
                    VStack(alignment: .leading, spacing: 0){
                        
                        ForEach(creatures.indices, id: \.self) { index in
                            
                            NavigationLink(destination: DetailView(entry: index), tag: index, selection: $selection) {
                                
                        Button(action:{
                            self.selection = index
                            
                        }){
                            ZStack(alignment: .leading){
                                
                                
                                
                                Image("creature_box").resizable()
                            
                                HStack(alignment: .center, spacing: proxy.size.width * 0.05){
                                    
                                    if UserDefaults.standard.integer(forKey: "consistency") > index {
                                            Image("\(img_name[index])").resizable().frame(width: proxy.size.width*0.2, height: proxy.size.height*0.1)
                                    }
                                    
                                    else{

                                        Image("\(img_name[index])").resizable().renderingMode(.template).foregroundColor(.black).frame(width: proxy.size.width*0.2, height: proxy.size.height*0.1)
                                        }
                                    
                                VStack(alignment: .leading, spacing: 0){
                                    
                                    HStack(spacing: 0){
                                        
                                        
                                        Text("\(creatures[index])").font(Font.custom("Amatic-Bold", size: 25)).foregroundColor(.white).frame(width: proxy.size.width * 0.5, alignment: .leading)
                                        
                                        ZStack{
                                            Rectangle().cornerRadius(5.0).frame(width: proxy.size.width * 0.1, height: proxy.size.height * 0.03).foregroundColor(.gray).opacity(0.3)
                                            Text("D-\(data_Test.stack[index] as! Int)").font(Font.custom("Amatic-Bold", size:15)).foregroundColor(.white)
                                            
                                        }
                                    }
                                    
                                    Text(descriptions[index]).font(Font.custom("AmaticSC-Regular", size:20)).foregroundColor(.white).multilineTextAlignment(.leading)
                                }
                                }.padding(.horizontal, proxy.size.width * 0.05)
                                
                            }
                            
                        }
                    }
                        }
                    
                    }
                    .navigationTitle("")
                    }
                    
                }
            
        }.ignoresSafeArea() // zstack
        }        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if(value.startLocation.x < 20 &&
                       value.translation.width > 100) {
                
                presentationMode.wrappedValue.dismiss()
                
            
            }
       }))
            .navigationBarHidden(true)

        
        
//        Image(systemName: "powersleep").resizable().foregroundColor(.white).frame(width: proxy.size.width * 0.07, height: proxy.size.width * 0.07).offset(x: -proxy.size.width * 0.4)}
        
        
        
        
        
    }
}

struct DetailView: View {
    let entry: Int
    var body: some View {
        switch entry {
        case 0:
            Tree_Detail()
                
        case 1:
            Weasel_Detail()
        case 2:
            Mushroom_Detail()
        case 3:
            Bear_Detail()
        case 4:
            Grass_Detail()
        case 5:
            Deer_Detail()
        default:
            Tree_Detail()
        }
    }
}


struct LifeStatus_Previews: PreviewProvider {
    static var previews: some View {
        LifeStatus().environmentObject(Data_Test())
    }
}
