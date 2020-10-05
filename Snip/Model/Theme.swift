//
//  Theme.swift
//  Snip
//
//  Created by Anthony Fernandez on 10/5/20.
//  Copyright © 2020 pictarine. All rights reserved.
//

import Foundation


public enum CodeViewTheme: String, CaseIterable {
  
  case bbedit = "bbedit"
  case allHallowEve = "all-hallow-eve"
  case idleFingers = "idleFingers"
  case spaceCadet = "spaceCadet"
  case idle = "idle"
  case oceanic = "oceanic"
  case clouds = "clouds"
  case github = "github"
  case ryanLight = "ryan-light"
  case blackPearl = "black-pearl"
  case monoIndustrial = "monoindustrial"
  case happyHappyJoyJoy2 = "happy-happy-joy-joy-2"
  case cube2Media = "cube2media"
  case friendshipBracelet = "friendship-bracelet"
  case classicModified = "classic-modified"
  case amy = "amy"
  case `default` = "demo"
  case rdrak = "rdark"
  case espresso = "espresso"
  case sunburst = "sunburst"
  case madeOfCode = "made-of-code"
  case arona = "arona"
  case putty = "putty"
  case nightlion = "nightlion"
  case sidewalkchalk = "sidewalkchalk"
  case swyphsii = "swyphs-ii"
  case iplastic = "iplastic"
  case solarizedLight = "solarized-(light)"
  case macClassic = "mac-classic"
  case pastelsOnDark = "pastels-on-dark"
  case irBlack = "ir_black"
  case material = "material"
  case monokaiFannonedition = "monokai-fannonedition"
  case monokaiBright = "monokai-bright"
  case eiffel = "eiffel"
  case base16Light = "base16-light"
  case oceanicMuted = "oceanic-muted"
  case summerfruit = "summerfruit"
  case espressoLibre = "espresso-libre"
  case krtheme = "krtheme"
  case mreq = "mreq"
  case chanfle = "chanfle"
  case venom = "venom"
  case juicy = "juicy"
  case coda = "coda"
  case fluidvision = "fluidvision"
  case tomorrowNightBlue = "tomorrow-night-blue"
  case magicwbAmiga = "magicwb-(amiga)"
  case twilight = "twilight"
  case vibrantInk = "vibrant-ink"
  case summerSun = "summer-sun"
  case monokai = "monokai"
  case railsEnvy = "rails-envy"
  case merbivore = "merbivore"
  case dracula = "dracula"
  case pastie = "pastie"
  case lowlight = "lowlight"
  case spectacular = "spectacular"
  case smoothy = "smoothy"
  case vibrantFin = "vibrant-fin"
  case blackboard = "blackboard"
  case slushPoppies = "slush-&-poppies"
  case freckle = "freckle"
  case fantasyscript = "fantasyscript"
  case tomorrowNightEighties = "tomorrow-night-eighties"
  case rhuk = "rhuk"
  case toyChest = "toy-chest"
  case fake = "fake"
  case emacsStrict = "emacs-strict"
  case merbivoreSoft = "merbivore-soft"
  case fadeToGrey = "fade-to-grey"
  case monokaiSublime = "monokai-sublime"
  case johnny = "johnny"
  case railscasts = "railscasts"
  case argonaut = "argonaut"
  case tomorrowNightBright = "tomorrow-night-bright"
  case lazy = "lazy"
  case tomorrowNight = "tomorrow-night"
  case bongzilla = "bongzilla"
  case glitterbomb = "glitterbomb"
  case irWhite = "ir_white"
  case zenburnesque = "zenburnesque"
  case notebook = "notebook"
  case djangoSmoothy = "django-(smoothy)"
  case blackboardBlack = "blackboard-black"
  case blackPearlii = "black-pearl-ii"
  case kuroir = "kuroir"
  case cobalt = "cobalt"
  case ayuMirage = "ayu-mirage"
  case chromeDevtools = "chrome-devtools"
  case prospettiva = "prospettiva"
  case espressoSoda = "espresso-soda"
  case birdsOfParadise = "birds-of-paradise"
  case textExMachina = "text-ex-machina"
  case django = "django"
  case tomorrow = "tomorrow"
  case solarizedDark = "solarized-(dark)"
  case plasticcodewrap = "plasticcodewrap"
  case materialPalenight = "material-palenight"
  case bespin = "bespin"
  case espressoTutti = "espresso-tutti"
  case vibrantTango = "vibrant-tango"
  case tubster = "tubster"
  case darkpastel = "darkpastel"
  case dawn = "dawn"
  case tango = "tango"
  case cloudsMidnight = "clouds-midnight"
  
  
  static var list : [CodeViewTheme] {
    return Self.allCases.sorted { $0.rawValue < $1.rawValue }
  }
}
