//
//  ZocDocView.swift
//  Adidev 3 Apps
//
//  Created by Joshua Boelman on 1/13/23.
//

import SwiftUI

struct ZocDocView: View {
    
    let searchables = [("Illness", "magnifyingglass"),("Near me", "pin.fill" ), ("Today","calendar" ), ("I'll choose my insurance later", "person.crop.rectangle.badge.plus")]
    
    
    let lightBlue = Color(red: 137/255, green: 207/255, blue: 240/255)
    
    @State private var searchText = ""
    
    var body: some View {
        
        
        ScrollView{
            //MARK: - Title
            NavigationLink{
                ContentView()
            }label: {
                Text("Josh, find local doctors who \ntake your insurance")
                    .font(.title)
            }
           
            //MARK: - End Title
            
            //MARK: - Search Box
            List(){
                
                
                ForEach(searchables, id: \.0.self){ x in
                    SearchBar(searchText: $searchText, text: x.0, icon: x.1)
                }
                Button{
                    //Do Nothing
                }label:{
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color.yellow)
                            .padding(5)
                        Text("Find care")
                            .foregroundColor(Color.black)
                            .padding(10)
                    }
                                    
                }
            }
            .frame(height: 350)
            .background(lightBlue)
            .scrollContentBackground(.hidden)
            //MARK: - End Search Box
            
            
            
            //MARK: - TSS
            TSS()
            //MARK: - End TSS
            
            
            BrowseDoctors()
            
        }.background(lightBlue)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        
    }
}

struct ZocDocView_Previews: PreviewProvider {
    static var previews: some View {
        ZocDocView()
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    var text: String
    var icon: String = "magnifyingglass"
    
    var body: some View {
        HStack {
            Button(action: {
                // Perform search
            }) {
                Image(systemName: icon)
                    .padding(.leading, 2)
            }
            TextField("\(text)", text: $searchText)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
            
        }
        .padding(.horizontal, 10)
    }
}

struct TSS: View {
    
    let data: [(name: String, image: String)] =  [("Video visit", "video.circle"),("Primary care", "heart.circle" ), ("OBGYN","figure.seated.side.air.lower" ), ("Dentist", "mouth"), ("Dermatologist", "sun.max.trianglebadge.exclamationmark"), ("Psychiatrist", "brain.head.profile")]
    

    var body: some View {
        let gridItemLayout = [GridItem(.adaptive(minimum: 120))]
        
        VStack{
            
            Text("Top-searched specialties")
                .font(.title3)
                .padding(.trailing,130)
                .bold()
                .padding(.top,20)
            
            LazyVGrid(columns: gridItemLayout, spacing: 8) {
                ForEach(data, id: \.0.self) { item in
                    VStack{
                        Image(systemName: item.1)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40,height:40)
                        Text("\(item.0)")
                            .font(.subheadline)
                            .frame(width: 100,height:30)
                          
                    }
                    .frame(width: 80,height:80)
                    .padding()
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                }
            }
            Spacer()
        }.background(Color.white)
        
        }
    
          
}

struct BrowseDoctors: View {
    
    var doctors: [Doctor] = [Doctor(imageName: "person.fill", name: "Dr. Aman Katyal, MD", type: "Primary Care Doctor"),
                             Doctor(imageName: "person.fill", name: "Dr. Ajay Hira, MD", type: "Oncologist", rating: Rating(stars: 4, numRatings: 46)),
                             Doctor(imageName: "person.fill", name: "Dr. Lalita Abhyankar, MD", type: "Primary Care Doctor", rating: Rating(stars: 3, numRatings: 94)),
                             Doctor(imageName: "person.fill", name: "Dr. Stephen Strange, MD", type: "Mystical Doctor", rating: Rating(stars: 5, numRatings: 657)),
                             Doctor(imageName: "person.fill", name: "Dr. Kwan Chun, MD", type: "Primary Care Doctor", rating: Rating(stars: 4, numRatings: 116)),
                             Doctor(imageName: "person.fill", name: "Dr. Elmer Hartman, MD", type: "Family Guy Doctor", rating: Rating(stars: 1, numRatings: 4))]
    
    var body: some View {
            
                HStack{
                    Text("Browse doctors nearby")
                        .bold()
                        .font(.title3)
                    Spacer()
                    Text("See all")
                        .font(.subheadline)
                        .foregroundColor(Color.blue)
                    
                }
                .padding(20)
                .background()
                
        ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(doctors) { doctor in
                            DoctorView(doctor: doctor)
                        }
                    }.background(Color.white)
                    
                }
                 .frame(height: 120)
                 .scrollContentBackground(.hidden)
                 .background(Color.white)
                
    }
        
}

struct Doctor: Identifiable{
    let id = UUID()
    var imageName: String
    var name: String
    var type: String
    var rating: Rating?
}

struct Rating{
    var stars: Int
    var numRatings: Int
}

struct DoctorView: View {
    var doctor: Doctor
    
    var body: some View {
        VStack {
            Image(systemName: doctor.imageName)
                .resizable()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
            
            Text(doctor.name).bold()
            Text(doctor.type).font(.caption)
            
            if doctor.rating != nil {
                HStack {
                    ForEach(1...doctor.rating!.stars, id: \.self) { index in
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                        
                                        
                                }
                    Text("(\(doctor.rating!.numRatings))")
                        .foregroundColor(Color.gray)
                        .font(.caption)
                }
            }
            
        }
        .frame(width: 180,height: 120)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
        )
        .padding()
        
        
//        func generateStars(_ stars: Double) -> [Image] {
//            var images: [Image] = []
//            var _stars = stars
//            while _stars > 0 {
//                if _stars == 0.5 {
//                    images.append(Image(systemName: "star.leadinghalf.filled"))
//                    _stars -= 0.5
//                }else{
//                    images.append(Image(systemName: "star.fill"))
//                    _stars -= 1.0
//                }
//            }
//
//            return images
//        }
        
        
    }
}
