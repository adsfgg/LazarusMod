# LazarusMod revision 1 - (28/10/2020)
## Alien

### Clog
* Removed flameable multiplier

### Cyst
* Increased maturity time to 90 seconds from 20 seconds
* Removed infestation multiplier, infestation will now grow at the normal rate
* Gorges can grow cysts regardless of their build state
* Removed Hive type bonuses
* Health
  * Starting health increased to 70 from 50
  * Armor reduced to 0 from 1
  * Mature cyst HP increased to 450
  * Mature cyst armor decreased to 0 from 1

### Drifters
* Drifters can no longer build cysts
* Removed Hive type bonuses

### Eggs
* Lifeform egg drops removed

### Embryo
* Embryo HP scales with base lifeform HP

### Fade
* Cost
  * Cost lowered to 35 pres from 37
* Movement
  * Removed auto-crouch
  * Removed ground slide
  * Air friction decreases with Celerity (0.01 per spur, base 0.17)
  * Remove speed cap without Celerity
* Swipe
  * Swipe damage increased to 75 from 37.5
  * Swipe damage type changed to StructuresOnlyLight from Puncture
  * Swipecone changed to 0.7 x 1 from 0.7 x 1.2

### Gestation Softcap
* Removed gestation softcap

### Gestation Time
* Added additional gestation time when re-evolving upgrades

### Gorge
* Babblers
  * Babbler will always take at least 20 damage when attacked
  * Babbler auto spawn disabled
  * Reduce health to 10 from 12
  * Babblers need to be created from eggs
* HealSpray
  * HealSpray no longer adds maturity
  * HealSpray no longer reduces evolution time
* Hydra
  * Spread is now static at 8 radians
  * ROF is random between 0.5 and 1.5 seconds
  * Increase build time to 13 seconds from 8 seconds
  * Increase Hydra cost to 2 pres from 0
  * Increase health to 350, gains 100 hp from maturity
  * No longer scales with Biomass
* Movement
  * Increased air control to 30 from 9
  * Lowered max backward speed scalar to 0.5 from 0.7
  * Lowered start slide speed to 7,.75 from 9.6
  * Lowered max sliding speed to 13 from 14
  * Increased slide cooldown to 1.5 seconds from 0.5 seconds
  * Decreased belly slide control to 10 from 25
  * Increased belly slide friction to 0.2 from 0.1
  * Increased belly slide friction on infestation to 0.068 from 0.039
  * Increased belly slide energy cost to 25 from 20
  * Gorges can no longer attack while belly sliding
  * Air friction will increase linearly based on player speed. Min: 0.12, Max:0.15
* Spit
  * Changed damage type to Normal from Light
* Structures
  * Increased build energy cost to 20 from 15
* Tunnels
  * Gorge Tunnels are now built from the Gorge
* Web
  * Lower webbed duration to 2 seconds from 5 seconds
  * Health increased to 50 from 10
  * Remove web charges
  * Increase number of webs per Gorge to 10 from 3
  * Webs no longer cloak
  * Webs now require webs to be researched by the commander - Biomass 5
  * Decreased web slowdown to 15% from 34%

### Hitboxes
* Hitboxes for Skulk, Lerk and Fade now match the model

### Lerk
* Cost
  * Cost lowered to 20 from 21
* Health
  * HP lowered to 125 from 180
  * Armor increased to 40 from 30
  * HP per biomass increased to 3 from 2
  * Carapace armor increased to 60 from 50
* Movement
  * Swoop gravity multiplier lowered to 4x from 6x
  * Lerks will bleed speed faster initially when gliding
  * Flap force scales with celerity
* Spikes
  * Spread increased to 4 from 3.6
  * Spike size decreased to 0.03 from 0.06
  * Damage increased to 7 from 5
* Spores
  * Increased Biomass requirement to 7 from 5
* Umbra
  * Lowered Biomass requirements of Umbra to 5 from 6

### Onos
* Increased Onos health to 900 from 700
* Decreased Onos Health per Biomass to 25 from 50
* BoneShield
  * Lowered Biomass requirement to 4 from 6
* Cost
  * Cost lowered to 55 from 62

### Shade
* Increased health to 750 from 600
* Increased mature health to 1500 from 1200

### Shift
* Increased health to 750 from 600
* Increased armor to 75 from 60
* Increased mature health to 1100 from 880
* Increased mature armor to 150 from 120

### Skulk
* Bite
  * Bitecone changed to 0.7 x 1 from 1.2 x 1.2
* Health
  * HP lowered to 70 from 75
  * Carapace armor increased to 30 from 25
* Movement
  * Max speed lowered to 7.0 from 7.25
  * Wall walking increases max speed by 0.25
  * Sneak modifier lowered to 0.5 from 0.5931035
  * Wall jump force lowered to 5.2 from 6.4
  * Wall jump force now scales with Celerity (0.1 per Spur)

### Spawn With Upgrades
* Aliens will no longer spawn with upgrades pre selected

### Structures
* Crag
  * Increased heal percentage to 6% from 4.2%
  * Increased minimum heal amount to 10 from 7
  * Increased maximum heal amount to 60 from 42
  * Crags now heal a percentage of your base HP instead of your max HP
  * HP
    * Health increased to 600 from 480
    * Armor increased to 200 from 160
    * Mature health increased to 700 from 560
    * Mature armor increased to 340 from 272
* Cyst
  * Flamable damage multiplier decreased to 2.5 from 7

### Upgrades
* Adrenaline
  * Lowered max energy pool from 160 to 130
  * Removed per-lifeform energy recuperation rates
    * All lifeforms will use a flat recuperation rate of 13 energy per second.
* Camouflage
  * Aliens will now uncloak when moving fast
* Carapace
  * Increased max Skulk armor to 30 from 25
  * Increased max Lerk armor to 60 from 50
* Crush
  * Removed Crush
* Focus
  * Removed Focus
* Silence
  * Added Silence upgrade to Shade hive.
  * Allows players to become Silent, intensity scales with Veil count
* Vampirism
  * Removed Vampirism

## Marine

### ARC
* Cost reduced to 10 from 15
* Damage reduced to 450 from 530
* Build time reduced to 7 from 10
* Health decreased to 2000 from 2600
* Armor while deployed increased to 500 from 400

### AnimationChanges
* Increased duration of Rifle bash animation by 25%
  * This is to counteract the fast reload animation cancel

### Jetpacks
* Weapon weight no longer affects fuel usage.

### Medpack
* Initial heal increased to 50 HP from 25 HP
* Pickup delay increased to 0.53 from 0.45
* Removed medpack HoT
* Changed auto-snap radius to match AmmoPack

### Structures
* ArmsLab
  * Cost decreased to 15 from 20
* PowerNode
  * Build rate halved when building with builder

### Upgrades
* Armor
  * Armor 1 research time lowered to 60 seconds from 75 seconds
* Weapons
  * Weapons 1 research time lowered to 60 seconds from 75 seconds

### Weapons
* Flamethrower
  * Can now be researched and purchased on the Armory
* GrenadeLauncher
  * Can now be researched and purchased from the Advanced Armory
* Heavy Machine Gun
  * Can now be researched and purchased from the Advanced Armory
* Pistol
  * Increased damage to 25 from 20
  * Changed damage type to Light from Normal
* Shotgun
  * Falloff removed
  * Spread changed to different pattern
  * All pellets are the same size and do the same damage
  * Shotgun upgraded damage multiplier changed to 10% from 5.9%
* Weapon Stay Time
  * Dropped weapons expiration time increased to 25 seconds from 16 seconds
* Welder
  * Cost increased to 3 from 2
  * Drop cost increased to 4 from 3
  * Welded entities no longer use eHP for health calculations

## Global

### Lighting
* Blackout Time
  * Increase blackout time after killing a power node to 15 seconds from 12 seconds.
* Initial Hive Power
  * Power node no longer starts destroyed in the main Hive room

### Map
* Eggs will now show as dots on the minimap, Embryos will show as a unique icon.
* This allows players to spot evolving lifeforms on the map

### Resources
* InitialPres
  * Initial Marine pres increased to 20 from 15
  * Initial Alien pres increased to 15 from 12
* PresRate
  * Pres per tick per RT lowered to 0.1 from 0.125

## Fixes & Improvements

### Armory
* Increased resupply range to 2.5 from 2

### Armory HP Bar
* Fixed a bug that caused the HP bar for the Armory/Advanced Armory to display at inconsistent heights

### Fade
* Fixed that a Fade's active weapon wouldn't reset when becoming a commander while partway through the Metabolize animation

### Female Sprinting Sounds
* Fixed a bug that caused the start and end sprinting sounds for the Female marine to be swapped

### Keep Upgrades
* Fixed a bug that meant players would lose their upgrades when using console commands to change lifeforms

### Scoreboard
* Fix that the scoreboard can sometimes be slow to open

<br/>

<div style="position:fixed;left:0;bottom:0;width:100%;background-color:#a9a9a9;color:black;text-align:center">
<div style="display:inline-block;float:left;padding-left:20%">
[ <- Previous ]
</div>
<div style="display:inline-block;">
Revision 1
</div>
<div style="display:inline-block;float:right;padding-right:20%">
[ Next -> ]
</div>
</div>
