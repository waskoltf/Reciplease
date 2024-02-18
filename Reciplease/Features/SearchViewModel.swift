//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Riboku🎯 on 18/02/2024.
//

import Foundation


class searchRecipeViewModel :ObservableObject{
    @Published  var textInput: String = ""
    @Published  var ingredients: [String] = []
    
}
