//
//  Product.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var landImages: [String]
    var description: String
    var price: Double
}

//var productList = [Product(name: "Surviving Mars", image: "survivingMars", landImages: ["survivingMars-land1", "survivingMars-land2", "survivingMars-land3"], description: "Surviving Mars is a sci-fi city builder all about colonizing Mars and surviving the process. Choose a space agency for resources and financial support before determining a location for your colony. Build domes and infrastructure, research new possibilities and utilize drones to unlock more elaborate ways to shape and expand your settlement. Cultivate your own food, mine minerals or just relax by the bar after a hard day’s work. Most important of all, though, is keeping your colonists alive. Not an easy task on a strange new planet.", price: 20.0),
//                   Product(name: "Undertale", image: "undertale", landImages: ["undertale-land1", "undertale-land2", "undertale-land3"], description: "Undertale is a 2015 2D role-playing video game created by American indie developer Toby Fox. The player controls a child who has fallen into the Underground: a large, secluded region under the surface of the Earth, separated by a magical barrier. The player meets various monsters during the journey back to the surface, although some monsters might engage the player in a fight. The combat system involves the player navigating through mini-bullet hell attacks by the opponent. They can opt to pacify or subdue monsters in order to spare them instead of killing them. These choices affect the game, with the dialogue, characters, and story changing based on outcomes.", price: 10.0),
//                   Product(name: "Anno 1800", image: "anno1800", landImages: ["anno1800-land1", "anno1800-land2", "anno1800-land3"], description: "Anno 1800 takes place in the 19th century at the dawn of the Industrial Age. Like other Anno games, Anno 1800 is a city-building and strategy game. While it is set in the context of colonial trade, the featured architecture is Victorian Era and the economic engine is factory labor. The core gameplay of Anno 1800 takes place in the Old World, where the needs of the citizens, workers and artisans are central to the management of production and supply chains. A parallel New World city exists, which produces products that laborers in the Old World want to purchase, thus trade routes need to be established. Unlike its colonial 18th century predecessor Anno 1701, the game has a blueprint feature that helps the player to plan out the city.", price: 40.0)]
