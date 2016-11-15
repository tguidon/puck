//
//  NHL.swift
//  puck
//
//  Created by Taylor Guidon on 11/14/16.
//  Copyright © 2016 Taylor Guidon. All rights reserved.
//

import Foundation

class NHL {
    var NHLTeamNames: [String] = [ "Anaheim", "Ducks",
                                   "Arizona", "Coyotes",
                                   "Boston", "Bruins",
                                   "Buffalo", "Sabres",
                                   "Calgary", "Flames",
                                   "Carolina", "Hurricanes",
                                   "Chicago", "Blackhawks",
                                   "Colorado", "Avalanche",
                                   "Columbus", "Blue", "Jackets",
                                   "Dallas", "Stars",
                                   "Detroit", "Red Wings",
                                   "Edmonton", "Oilers",
                                   "Florida", "Panthers",
                                   "Los Angeles", "Kings",
                                   "Minnesota", "Wild",
                                   "Montreal", "Canadiens",
                                   "Nashville", "Predators",
                                   "New Jersey", "Devils",
                                   "New York Islanders", "NY Islanders", "Islanders",
                                   "New York Rangers", "NY Rangers", "Rangers",
                                   "Philadelphia", "Flyers",
                                   "Pittsburgh", "Penguins",
                                   "Ottawa", "Senators",
                                   "San Jose", "Sharks",
                                   "St Louis", "Blues",
                                   "Tampa", "Bay", "Lightning",
                                   "Toronto", "Maple", "Leafs",
                                   "Vancouver", "Canucks",
                                   "Washington", "Capitals",
                                   "Winnipeg", "Jets"]
    
    func retriveFullNHLTeamName(name: String) -> String? {
        switch name {
        case "Anaheim", "Ducks":
            return "Anaheim Ducks"
        case "Arizona", "Coyotes":
            return "Arizona Coyotes"
        case "Boston", "Bruins":
            return "Boston Bruins"
        case "Buffalo", "Sabres":
            return "Buffalo Sabres"
        case "Calgary", "Flames":
            return "Calgary Flames"
        case "Carolina", "Hurricanes":
            return "Carolina Hurricanes"
        case "Chicago", "Blackhawks":
            return "Chicago Blackhawks"
        case "Colorado", "Avalanche":
            return "Colorado Avalanche"
        case "Columbus", "Blue", "Jackets":
            return "Columbus Jackets"
        case "Dallas", "Stars":
            return "Dallas Stars"
        case "Detroit", "Red Wings":
            return "Detroit Red Wings"
        case "Edmonton", "Oilers":
            return "Edmonton Oilers"
        case "Florida", "Panthers":
            return "Florida Panthers"
        case "Los", "Angeles", "Kings":
            return "Los Angeles Kings"
        case "Minnesota", "Wild":
            return "Minnesota Wild"
        case "Montreal", "Canadiens":
            return "Montreal Canadiens"
        case "Nashville", "Predators":
            return "Nashville Predators"
        case "New", "Jersey", "Devils":
            return "New Jersey Devils"
        case "New York Islanders", "NY Islanders", "Islanders":
            return "New York Islanders"
        case "New York Rangers", "NY Rangers", "Rangers":
            return "New York Rangers"
        case "Philadelphia", "Flyers":
            return "Philadelphia Flyers"
        case "Pittsburgh", "Penguins":
            return "Pittsburgh Penguins"
        case "Ottawa", "Senators":
            return "Ottawa Senators"
        case "San", "Jose", "Sharks":
            return "San Jose Sharks"
        case "St", "Louis", "Blues":
            return "St Louis Blues"
        case "Tampa", "Bay", "Lightning":
            return "Tampa Bay Lightning"
        case "Toronto", "Maple", "Leafs":
            return "Toronto Maple Leafs"
        case "Vancouver", "Canucks":
            return "Vancouver Canucks"
        case "Washington", "Capitals":
            return "Washington Capitals"
        case "Winnipeg", "Jets":
            return "Winnipeg Jets"
        default:
            return nil
        }
    }
}
