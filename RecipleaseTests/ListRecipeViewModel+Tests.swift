//
//  SearchRecipeViewModel+Tests.swift
//  RecipleaseTests
//
//  Created by Riboku🎯 on 18/02/2024.
//

// CMD + SHIFT + O

import Foundation
import XCTest

@testable import Reciplease

class ListRecipeViewModel_Tests: XCTestCase {
    
    let sut = ListRecipeViewModel()
    
    func test_searchRecipes_withResults() {
        // arrange
        let mock: [Recipe] = [] // le json attendu
        
        // act
        sut.searchRecipes(query: "test-query")
        
        // assert
        XCTAssertEqual(sut.recipes.count, mock.count)
        
        let firstRecipe = sut.recipes.first!
        let firstMockRecipe = mock.first!
        
        XCTAssertEqual(firstRecipe.id, firstMockRecipe.id)
    }
    
    func test_searchRecipes_withFailure() {
        
    }
}
