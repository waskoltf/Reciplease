//
//  ListRecipe.swift
//  Reciplease
//
//  Created by Riboku🎯 on 22/01/2024.
//

import SwiftUI

struct ListRecipeView: View {
    
    @ObservedObject var viewModel = ListRecipeViewModel()
    @ObservedObject var viewModelDetails = DetailsRecipeViewModel()
    @EnvironmentObject var searchRecipeView: searchRecipeViewModel
    
    @State private var selectedRecipe: Recipe?
    @State private var isShowingDetails = false
    
    var body: some View {
        ZStack{
            Color(.brown)
                .ignoresSafeArea(.all)
            Image("Background-phone")
                .resizable()
                .ignoresSafeArea(.all)
            
            ScrollView{
                ForEach(viewModel.recipes) { recipe in
                    
                    VStack(spacing: 15){
                  
                        HStack {
                            // MARK: - IMAGE
                            // Utilisez une URL pour charger l'image depuis le lien fourni dans les données de recette
                            Button(action: {
                                selectedRecipe = recipe
                                isShowingDetails.toggle()
                                viewModelDetails.fetchRecipe()
                            }) {
                                if let imageURL = URL(string: recipe.image) {
                                    AsyncImage(url: imageURL) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        case .failure:
                                            Image(systemName: "photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        @unknown default:
                                            fatalError()
                                        }
                                    }
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.2)
                        .background(.white)
                        .clipped()
                        
                        
                        VStack(spacing: 10){
                            Text("- \(recipe.label)")
                                .font(.custom("American Typewriter", size: 20))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                            
                            
                            
                            Text("- Ingredients: \(searchRecipeView.ingredients.joined(separator: ", "))")
                                .font(.custom("American Typewriter", size: 20))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                            
                            Text("Temps de préparation: \(formattedTotalTime(recipe.totalTime))")
                                .font(.custom("American Typewriter", size: 20))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)

                          
                            
                            
                            
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.85)
                        .cornerRadius(5)
                        .background(Color("YellowSecondColor"))
                        
                    }
                }
            }
            .onAppear(){
                //            let query = searchRecipeView.ingredients.joined(separator: ",")
                let query = "pasta,cheese"
                print(query)
                viewModel.searchRecipes(query: query)
                debugPrint()
                
            }
            .sheet(isPresented: $isShowingDetails) {
                if let selectedRecipe = selectedRecipe {
                    DetailsRecipeView(recipe: selectedRecipe)
                }
            }
        }
    }
    
    func formattedTotalTime(_ totalTime: Double) -> String {
        let totalMinutes = Int(totalTime)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }

}
//
//#Preview {
////    ListRecipe()
//}
