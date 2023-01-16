//
//  DoorDashView.swift
//  Adidev 3 Apps
//
//  Created by Joshua Boelman on 1/13/23.
//

import SwiftUI

struct DoorDashView: View {
    
    //MARK: - Variables
    @State private var searchTerm = ""
    
    var items2 = [
            Item(image: "takeoutbag.and.cup.and.straw", text: "Trending"),
            Item(image: "figure.walk", text: "Fast Food"),
            Item(image: "wineglass", text: "Drinks"),
            Item(image: "birthday.cake", text: "Deserts"),
            Item(image: "cpu", text: "Snacks"),
            Item(image: "facemask.fill", text: "Chicken"),
            Item(image: "house", text: "Poke"),
            Item(image: "lamp.desk", text: "Sandwiches")
            
        ]
    
    var items = [
            Item(image: "takeoutbag.and.cup.and.straw", text: "Convenience"),
            Item(image: "carrot", text: "Grocery"),
            Item(image: "wineglass", text: "Alcohol"),
            Item(image: "pawprint", text: "Pets"),
            Item(image: "percent", text: "Offers"),
            Item(image: "bag", text: "Retail"),
            Item(image: "house", text: "Home"),
            Item(image: "lamp.desk", text: "Office")
            
        ]
    
    var filterOptions = [
            "💨 Dashpass","🏷️ Offers","Pickup","⭐️ Ratings", "Under 30 min", "Price ⬇️"
            
        ]
    
    var Titles = ["Order Again", "Now on Doordash", "Fastest Near You", "Trending Now", "Most Popular Local Restaurants", "Hidden Gems", "Recently Viewed", "National Favorites"]

    //MARK: - End Variables

    var body: some View {
        
        
        
        VStack{
            
            //MARK: - Address
            NavigationLink{
                ContentView()
            }label: {
                HStack{
                    Text("📍 2521 Foodie Dr.")
                    Image(systemName: "chevron.down")
                }

            }
            
            //MARK: - End Address

            
            
            ScrollView{
                //MARK: - Icon Sliders
                HorizontalIconSlider(items: items, size: CGFloat(60))
           
                
                Divider()
                HorizontalIconSlider(items: items2, size: CGFloat(40))
                //MARK: - End Icon Sliders
                
                
                HorizontalTextSlider(items: filterOptions)
                
                
                ForEach(Titles, id: \.self) { title in
                    BrowseRestaurants(Title: title)
                }
                
                
            }
       
        }
        .padding(15)
        
        
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        
        
        
        }
}

struct HorizontalIconSlider: View {
    var items: [Item]
    var size: CGFloat
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 20) {
                ForEach(items) { item in
                    VStack {
                        Image(systemName: item.image)
                            .resizable()
    
                            .frame(width: size, height: size)
                            
                        Text(item.text)
                            .font(.caption)
                    }
                }
            }
        }
    }
}

struct HorizontalTextSlider: View {
    var items: [String]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 20) {
                ForEach(items, id: \.self) { item in
                    
                    ZStack{
                        Text(item)
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .zIndex(1)
                        
                        Rectangle()
                            .cornerRadius(30)
                            .foregroundColor(Color.gray)
                            
                    }.frame(width: 100, height: 30)
                    
                }
            }
        }
    }
}

struct Item: Identifiable{
    let id = UUID()
    var image: String
    var text: String
}





struct BrowseRestaurants: View {
    
    
    
    var Title: String
    
    let restaurantData = [
        Restaurant(imageName: "pizza", name: "Pizza My Heart", dist: 2, time: "20", fee: "$2.99",rating: Rating(stars: 3, numRatings: 400)),
        Restaurant(imageName: "sushi", name: "Sushi Palace", dist: 16, time: "25", fee: "$4.99",rating: Rating(stars: 4, numRatings: 122)),
        Restaurant(imageName: "burger", name: "Burger Joint", dist: 3, time: "30", fee: "$5.99",rating: Rating(stars: 5, numRatings: 592)),
        Restaurant(imageName: "indian", name: "Indian Delight", dist: 4, time: "35", fee: "$7.99",rating: Rating(stars: 1, numRatings: 12)),
        Restaurant(imageName: "Vegetable", name: "Vegetable Garden", dist: 1, time: "12", fee: "$1.99",rating: Rating(stars: 3, numRatings: 147)),
        Restaurant(imageName: "mexican", name: "Mexican Grill", dist: 6, time: "40", fee: "$9.99",rating: Rating(stars: 5, numRatings: 52))
    ]
    
    var body: some View {
            
        VStack{
            HStack{
                Text(Title)
                    .bold()
                    .font(.title)
                    .padding(.leading,5)
                Spacer()
                Image(systemName: "arrow.forward.circle")
                    .font(.subheadline)
                    .foregroundColor(Color.blue)
                
            }
            //.padding(20)
            .background()
            
            
            ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(restaurantData.shuffled()) { Restaurant in
                                RestaurantView(Restaurant: Restaurant)
                            }
                        }.background(Color.white)
                        
                    }
                     .scrollContentBackground(.hidden)
                     .background(Color.white)
            
            
            Spacer()
        }
            
    }
        
}

struct Restaurant: Identifiable{
    let id = UUID()
    var imageName: String
    var name: String
    var dist: Int
    var time: String
    var fee: String
    var rating: Rating?
}



struct RestaurantView: View {
    var Restaurant: Restaurant
    var image: UIImage? = UIImage(named: "indian")

    var body: some View {
        VStack {
       
                Image(uiImage: UIImage(named: Restaurant.imageName) ?? image!)
                    
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .frame(width: 300, height: 200, alignment: .leading)
                    
                Spacer()
            
            
            
            
            HStack{
                Text(Restaurant.name).bold()
                    .padding(.leading,5)
                Spacer()
                Image(systemName: "heart")
                    .padding(.trailing,5)
            }
            
            HStack{
                Text("\(Restaurant.dist) mi -").font(.caption)
                Text("\(Restaurant.time) min -").font(.caption)
                Text("\(Restaurant.fee) delivery fee").font(.caption)
                Spacer()
            }.padding(.leading,5)
            
            
     
                if Restaurant.rating != nil {
                    HStack {
                        ForEach(1...Restaurant.rating!.stars, id: \.self) { index in
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            
                                    }
                        Text("(\(Restaurant.rating!.numRatings))")
                            .foregroundColor(Color.gray)
                            .font(.caption)
                        Spacer()
                    }
                    .padding(.leading,5)
                    
                }
                
            
            
            
            Spacer()
            
        }
        .frame(width: 300, height: 250)
        .padding(5)

        
    }
}






struct DoorDashView_Previews: PreviewProvider {
    static var previews: some View {
        
        DoorDashView()
    }
}
