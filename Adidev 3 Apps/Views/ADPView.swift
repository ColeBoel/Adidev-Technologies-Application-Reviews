//
//  ADPView.swift
//  Adidev 3 Apps
//
//  Created by Joshua Boelman on 1/13/23.
//

import SwiftUI

struct ADPView: View {
    
    var Dates: [String] = ["Aug 10,2021", "Aug 14, 2021", "Sep 13, 2021", "Sep 16, 2021","Dec 1, 2021", "Dec 5, 2021", "Jan 10, 2022", "Jan 15, 2022"]
    
    var Types: [String] = ["Adjustment", "Regular Pay", "On Demand"]
    
    var body: some View {
        
        VStack{
            
            NavigationLink{
                ContentView()
            }label: {
                HStack{
                    Image(systemName: "arrow.left")
                    Spacer()
                    Text("Pay")
                        .font(.title3)
                    Spacer()
                    Image(systemName: "message")
                }.padding(10)
            }
            
            
            
            HStack{
                Text("My Pay")
                    .font(.title2)
                    .frame(alignment:.leading)
                Spacer()
            }.padding(10)
               
    
            Divider()
            
            VStack{
                FinancialView()
                    
            }
                .frame(height: 250)
           
            BlueButton(text: "View Details")
            
            HStack{
                Text("Statements & Activity")
                    .font(.title2)
                    .frame(alignment:.leading)
                Spacer()
            }.padding(10)
               
            Divider()
            
            
            ScrollView{
                ForEach(Dates, id: \.self) { date in
                    Statement(date: date, type: Types.randomElement()!, hours: Double(arc4random_uniform(10)) + 1)
                }
            }
            
            BlueButton(text: "View All")
        }.padding(.horizontal,15)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    
}

struct ADPView_Previews: PreviewProvider {
    static var previews: some View {
        ADPView()
    }
}

struct CircleButton: View{
    
    var text: String
    var body: some View{
        ZStack{
            Text(text)
            .font(.caption)
            .foregroundColor(Color.black)
            .zIndex(1)
            
            Rectangle()
                .cornerRadius(30)
                .foregroundColor(Color.gray)
                
        }.frame(width: 80, height: 30)
    }
}



struct FinancialView: View {
   
    
    var body: some View {
        
    //MARK: - Date & Title
        HStack{
            Text("Aug 13, 2021")
            Spacer()
            CircleButton(text: "Regular Pay")
            
            HStack{
                Image(systemName: "eye.slash")
                Text("Hide")
                    .font(.caption)
                    
            }.foregroundColor(Color.blue)
           

            
        }.padding(10)
        
        //MARK: - End Date & Title

        //MARK: - Graph

        HStack{
            ZStack{
                PieChart()
                Circle()
                    .zIndex(1)
                    .foregroundColor(Color.white)
                    .frame(width: 120, height: 120)
             
            }.frame(width: 200,height: 200)
            
            VStack{
                
                
                Spacer()

                    Text("Take Home")
                        .padding(.trailing, 70)
                Spacer()

                    Text("$1,450.47")
                        .font(.title)
                        .foregroundColor(Color.green)
                        .padding(.trailing,10)
                        .bold()
                
                Spacer()

                
                HStack{
                    Text("Hours")
                    Spacer()
                    Text("Gross           ")
                    
                }.frame(alignment: .leading)
                
                
                
                 HStack{
                     Text("80")
                         .bold()
                     Spacer()
                     Text("$1,923.08")
                         .bold()
                     
                 }.frame(alignment: .leading)
                  .padding(.trailing,10)
                    
                Spacer()

            }
            
          

            
        }
        //MARK: - End Graph
      
       
        
        
    }
}

struct Statement: View{
    
    var date: String
    var type: String
    var hours: Double
    
    var body: some View{
        
        
        VStack{
            
            HStack{
                Text(date)
                    .bold()
                    .font(.subheadline)
                Spacer()
                CircleButton(text: type)
            }.padding(.top,15)
            
            HStack{
                Text("Take Home")
                    
                Spacer()
                Text("Hours")
                Spacer()
                Text("Gross")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.blue)
            }
              
            HStack{
                
                Text("$\(String(format: "%.2f", hours * 34.23))")
                Spacer()
                Text("       \(String(format: "%.0f", hours))")
                Spacer()
                Text("         $\(String(format: "%.2f", hours * 49.92))")
                Spacer()
            }.padding(.top,5)
            .bold()
            
        }.frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.12)
            .padding(.bottom,10)
        Divider()
            
    }
    
    
}



struct PieChart: View {
    private var slices = [
        PieSlice(start: Angle(degrees: 15),
                 end: Angle(degrees: 180),
                 color: .red),
        PieSlice(start: Angle(degrees: 180),
                 end: Angle(degrees: 200),
                 color: .blue),
        PieSlice(start: Angle(degrees: 200),
                 end: Angle(degrees: 230),
                 color: .purple),
        PieSlice(start: Angle(degrees: 230),
                 end: Angle(degrees: 265),
                 color: .orange),
        PieSlice(start: Angle(degrees: 265),
                 end: Angle(degrees: 375),
                 color: .green)
    ]
    
    var body: some View {
        ZStack(alignment: .center) {
            
            ForEach(slices, id: \.self) { slice in
                Path { path in
                    path.move(to: CGPoint(x: 100, y: 100))
                    path.addArc(center: CGPoint(x: 100, y: 100),
                                radius: 100,
                                startAngle: slice.start,
                                endAngle: slice.end,
                                clockwise: false
                    )
                }
                .fill(slice.color)
            }
            
            

        }
    }
}

private struct PieSlice : Hashable {
    var start: Angle
    var end: Angle
    var color: Color
}


struct BlueButton: View {
    var text: String
    
    var body: some View{
        HStack{
            Text(text)
                .padding(10)
                .font(.subheadline)
                .bold()
                
        }
        .foregroundColor(Color.blue)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.blue, lineWidth: 3)
        )
    }
    
    
    
    
}



