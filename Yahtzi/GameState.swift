//
//  GameState.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 6/5/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import Foundation

class GameState {
    
    var ones: String
    var twos: String
    var threes: String
    var fours: String
    var fives: String
    var sixes: String
    var threeOfAKind: String
    var fourOfAKind: String
    var fullHouse: String
    var smallStraight: String
    var largeStraight: String
    var chance: String
    var yahtzi: String
    
    var bonus: Int
    
    var score: Int
    
    var diceOne: Int
    var diceTwo: Int
    var diceThree: Int
    var diceFour: Int
    var diceFive: Int
    
    var oneTapped: Bool
    var twoTapped: Bool
    var threeTapped: Bool
    var fourTapped: Bool
    var fiveTapped: Bool
    
    init(_ ones: String, _ twos: String, _ threes: String, _ fours: String, _ fives: String, _ sixes: String, _ threeOfAKind: String, _ fourOfAKind: String, _ fullHouse: String, _ smallStraight: String, _ largeStraight: String, _ chance: String, _ yahtzi: String, _ bonus: Int, _ score: Int, _ diceOne: Int, _ diceTwo: Int, _ diceThree: Int, _ diceFour: Int, _ diceFive: Int, _ oneTapped: Bool, _ twoTapped: Bool, _ threeTapped: Bool, _ fourTapped: Bool, _ fiveTapped: Bool) {
        self.ones = ones
        self.twos = twos
        self.threes = threes
        self.fours = fours
        self.fives = fives
        self.sixes = sixes
        self.threeOfAKind = threeOfAKind
        self.fourOfAKind = fourOfAKind
        self.fullHouse = fullHouse
        self.smallStraight = smallStraight
        self.largeStraight = largeStraight
        self.chance = chance
        self.yahtzi = yahtzi
        self.bonus = bonus
        self.score = score
        self.diceOne = diceOne
        self.diceTwo = diceTwo
        self.diceThree = diceThree
        self.diceFour = diceFour
        self.diceFive = diceFive
        self.oneTapped = oneTapped
        self.twoTapped = twoTapped
        self.threeTapped = threeTapped
        self.fourTapped = fourTapped
        self.fiveTapped = fiveTapped
    }
    
    // MARK: - Setter methods
    func setOnes(ones: String) {
        self.ones = ones
    }
    
    func setTwos(twos: String) {
        self.twos = twos
    }
    
    func setThrees(threes: String) {
        self.threes = threes
    }
    
    func setFours(fours: String) {
        self.fours = fours
    }
    
    func setFives(fives: String) {
        self.fives = fives
    }
    
    func setSixes(sixes: String) {
        self.sixes = sixes
    }
    
    func setThreeOfAKind(threeOfAKind: String) {
        self.threeOfAKind = threeOfAKind
    }
    
    func setFourOfAKind(fourOfAKind: String) {
        self.fourOfAKind = fourOfAKind
    }
    
    func setFullHouse(fullHouse: String) {
        self.fullHouse = fullHouse
    }
    
    func setSmallStraight(smallStraight: String) {
        self.smallStraight = smallStraight
    }
    
    func setLargeStraight(largeStraight: String) {
        self.largeStraight = largeStraight
    }
    
    func setChance(chance: String) {
        self.chance = chance
    }
    
    func setYahtzi(yahtzi: String) {
        self.yahtzi = yahtzi
    }
    
    func setBonus(bonus: Int) {
        self.bonus = bonus
    }
    
    func setScore(score: Int) {
        self.score = score
    }
    
    func setDiceOne(diceOne: Int) {
        self.diceOne = diceOne
    }
    
    func setDiceTwo(diceTwo: Int) {
        self.diceTwo = diceTwo
    }
    
    func setDiceThree(diceThree: Int) {
        self.diceThree = diceThree
    }
    
    func setDiceFour(diceFour: Int) {
        self.diceFour = diceFour
    }
    
    func setDiceFive(diceFive: Int) {
        self.diceFive = diceFive
    }
    
    func setOneTapped(oneTapped: Bool) {
        self.oneTapped = oneTapped
    }
    
    func setTwoTapped(twoTapped: Bool) {
        self.twoTapped = twoTapped
    }
    
    func setThreeTapped(threeTapped: Bool) {
        self.threeTapped = threeTapped
    }
    
    func setFourTapped(fourTapped: Bool) {
        self.fourTapped = fourTapped
    }
    
    func setFiveTapped(fiveTapped: Bool) {
        self.fiveTapped = fiveTapped
    }
    
    // MARK: - Getter methods
    func getOnes() -> String {
        return self.ones
    }
    
    func getTwos() -> String {
        return self.twos
    }
    
    func getThrees() -> String {
        return self.threes
    }
    
    func getFours() -> String {
        return self.fours
    }
    
    func getFives() -> String {
        return self.fives
    }
    
    func getSixes() -> String {
        return self.sixes
    }
    
    func getThreeOfAKind() -> String {
        return self.threeOfAKind
    }
    
    func getFourOfAKind() -> String {
        return self.fourOfAKind
    }
    
    func getFullHouse() -> String {
        return self.fullHouse
    }
    
    func getSmallStraight() -> String {
        return self.smallStraight
    }
    
    func getLargeStraight() -> String {
        return self.largeStraight
    }
    
    func getChance() -> String {
        return self.chance
    }
    
    func getYahtzi() -> String {
        return self.yahtzi
    }
    
    func getBonus() -> Int {
        return self.bonus
    }
    
    func getScore() -> Int {
        return self.score
    }
    
    func getDiceOne() -> Int {
        return self.diceOne
    }
    
    func getDiceTwo() -> Int {
        return self.diceTwo
    }
    
    func getDiceThree() -> Int {
        return self.diceThree
    }
    
    func getDiceFour() -> Int {
        return self.diceFour
    }
    
    func getDiceFive() -> Int {
        return self.diceFive
    }
    
    func getOneTapped() -> Bool {
        return self.oneTapped
    }
    
    func getTwoTapped() -> Bool {
        return self.twoTapped
    }
    
    func getThreeTapped() -> Bool {
        return self.threeTapped
    }
    
    func getFourTapped() -> Bool {
        return self.fourTapped
    }
    
    func getFiveTapped() -> Bool {
        return self.fiveTapped
    }
    
}
