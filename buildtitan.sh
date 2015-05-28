#!/bin/bash

# origin coordinates
oX=0
oY=150
oZ=285

# door sleep time
doorsleep=10

function sendkeys {
   # replace this with whatever command it takes on your server to send keys to 
   # the minecraft console. In this case, I am running tmux as the minecraft user
   # using a named console.
   sudo -u minecraft tmux send-keys -t minecraft-console "$1" C-m
   sleep .25
}

function clearAllBlocks {
   sendkeys "me Clearing away the area"
   for ((Y = -27; Y < 11; Y++))
   do 
      fill -66 $Y -26 22 $Y 25 air 0 replace
      #fill 0 $Y -16 22 $Y 15 air 0 replace
   done
}

function buildLowerPlatform {
   sendkeys "me Building the door platform"
   # fill the temporary center platform
   fill -9 0 -16 9 0 15 cobblestone 0 replace
   # add stripes to the temporary center platform
   fill 0 0 -16 0 0 15 stone 0 replace
   fill 5 0 -16 5 0 15 stonebrick 0 replace
   fill -1 0 -16 -1 0 15 stonebrick 0 replace
   fill -3 0 -16 -3 0 15 stonebrick 0 replace   
   fill -5 0 -16 -5 0 15 stonebrick 0 replace
   fill -9 0 -16 -9 0 15 stonebrick 0 replace
   # fill the center block
   setblock 0 0 0 iron_block

   # fill the west permanent platform
   fill -10 0 -16 -20 0 15 stone 0 replace
   fill -17 0 -16 -17 0 15 stonebrick 0 replace

   # fill the east permanent platform
   fill 10 0 -16 20 0 15 stone 0 replace
   
   # fill the western strips
   fill -33 0 -16 -33 0 15 cobblestone 0 replace
   fill -64 0 -16 -64 0 15 cobblestone 0 replace
}

function buildUpperPlatform {
   fill 20 4 -16 -20 4 -1 stone 0 replace
   fill 20 4 1 -20 4 15 stone 0 replace
   fill 8 4 0 -8 4 0 stone 0 replace
   fill 12 4 0 20 4 0 stone 0 replace
   fill -12 4 0 -20 4 0 stone 0 replace
   
   # fill the center block
   setblock 0 4 0 iron_block

   # fill the western strips
   fill -33 4 -16 -33 4 15 cobblestone 0 replace
   fill -64 4 -16 -64 4 15 cobblestone 0 replace

   # remove lower overhang
   fill 22 3 -16 21 3 15 air 0 replace
   fill -21 3 -16 -21 3 15 air 0 replace
}

function buildCover {
   sendkeys "me Building the cover"
   
   # western cover
   fill -21 $1 -16 -10 $1 15 stone 0 replace
   fill -13 $1 -16 -12 $1 15 glass 0 replace

   # eastern cover
   fill 10 $1 -16 22 $1 15 stone
   fill 11 $1 -16 12 $1 15 glass

   # western strip covers
   fill -33 $1 -16 -34 $1 15 cobblestone 
   fill -64 $1 -16 -65 $1 15 cobblestone

   # sea lanterns
   for ((Z = 14; Z >= -14; Z -= 4))
   do
      setblock -11 $1 $Z sea_lantern
      setblock -14 $1 $Z sea_lantern
      setblock -18 $1 $Z sea_lantern
      setblock -7 $1 $Z sea_lantern
      setblock -2 $1 $Z sea_lantern
      setblock 2 $1 $Z sea_lantern
      setblock 6 $1 $Z sea_lantern
      setblock 10 $1 $Z sea_lantern
      setblock 14 $1 $Z sea_lantern
      setblock 18 $1 $Z sea_lantern
      setblock -35 $1 $Z sea_lantern
      setblock -66 $1 $Z sea_lantern
   done
}

function buildCenterCover {
   sendkeys "me Building the center cover"

   fill -9 10 -16 9 10 15 stone
   fill -1 10 -16 0 10 15 glass
   
   for ((Z = 14; Z >= -14; Z -= 4))
   do
      setblock -7 10 $Z sea_lantern
      setblock -2 10 $Z sea_lantern
      setblock 2 10 $Z sea_lantern
      setblock 6 10 $Z sea_lantern
   done
}

function buildVillagerPens {
   sendkeys "me Building villager pens"

   setblock -10 4 0 stone
   setblock -9 5 0 glass
   setblock -9 6 0 glass
   setblock -10 5 -1 glass
   setblock -10 6 -1 glass
   setblock -10 5 1 glass
   setblock -10 6 1 glass
   setblock -11 5 0 glass
   setblock -11 6 0 glass
   setblock -10 7 0 sea_lantern

   setblock 10 4 0 stone
   setblock 9 5 0 glass
   setblock 9 6 0 glass
   setblock 10 5 -1 glass
   setblock 10 6 -1 glass
   setblock 10 5 1 glass
   setblock 10 6 1 glass
   setblock 11 5 0 glass
   setblock 11 6 0 glass
   setblock 10 7 0 sea_lantern

   setblock -48 4 0 stone
   setblock -47 5 0 glass
   setblock -47 6 0 glass
   setblock -48 5 -1 glass
   setblock -48 6 -1 glass
   setblock -48 5 1 glass
   setblock -48 6 1 glass
   setblock -49 5 0 glass
   setblock -49 6 0 glass
   setblock -48 7 0 sea_lantern
}

function summonVillagers {
   sendkeys "me Summoning Villagers"
   for ((i = 0; i < 25; i++))
   do
      sendkeys "summon Villager $[oX+10] $[oY+5] $[oZ]"
      sendkeys "summon Villager $[oX-10] $[oY+5] $[oZ]"
      sendkeys "summon Villager $[oX-48] $[oY+5] $[oZ]"
   done
}

function buildGolemChute {
   # drop shaft
   fill -2 -3 16 2 -19 16 stained_glass 0 replace
   fill -2 -3 12 2 -19 12 stained_glass 0 replace
   fill -2 -3 16 -2 -20 12 iron_block 0 replace
   fill 2 -3 16 2 -20 12 iron_block 0 replace
   fill -2 -20 16 2 -20 16 iron_block
   fill -2 -20 12 2 -20 12 iron_block

   # signs
   setblock 1 -19 15 wall_sign 4
   setblock 1 -19 14 wall_sign 4
   setblock 1 -19 13 wall_sign 4
   setblock -1 -19 15 wall_sign 5
   setblock -1 -19 14 wall_sign 5
   setblock -1 -19 13 wall_sign 5
   setblock 0 -19 13 wall_sign 3
   setblock 0 -19 14 wall_sign 3
   setblock 0 -19 15 wall_sign 0

   # lava
   setblock 1 -18 15 flowing_lava
   setblock -1 -18 15 flowing_lava
   setblock 1 -18 13 flowing_lava
   setblock -1 -18 13 flowing_lava

} 

function buildGolemDropHandler {

   # hoppers under lava
   setblock 0 -21 13 hopper 2
   setblock 0 -21 14 hopper 2
   setblock 0 -21 15 hopper 2
   setblock -1 -21 13 hopper 5
   setblock -1 -21 14 hopper 5
   setblock -1 -21 15 hopper 5
   setblock 1 -21 13 hopper 4
   setblock 1 -21 14 hopper 4
   setblock 1 -21 15 hopper 4
   
   # sorter
   setblock 0 -21 12 hopper 2
   setblock 0 -22 12 hopper 3 replace "{Items:[{id:265,Count:64,Slot:0},{id:42,Count:1,Slot:1,tag:{display:{Name:SorterItem}}},{id:42,Count:1,Slot:2,tag:{display:{Name:SorterItem}}},{id:42,Count:1,Slot:3,tag:{display:{Name:SorterItem}}},{id:42,Count:1,Slot:4,tag:{display:{Name:SorterItem}}}]}"
   setblock 0 -23 12 hopper 2
   setblock 0 -23 13 iron_block
   setblock 0 -23 14 iron_block
   setblock 0 -23 15 iron_block 
   setblock 0 -24 14 iron_block
   setblock 0 -24 16 iron_block
   setblock 0 -25 15 iron_block
   setblock 0 -22 13 unpowered_comparator 2
   setblock 0 -22 14 redstone_wire
   setblock 0 -22 15 redstone_wire
   setblock 0 -23 16 redstone_wire
   setblock 0 -24 15 unpowered_repeater 
   setblock 0 -24 13 redstone_torch 4 
   
   # ingot splitter
   setblock 0 -23 11 hopper
   setblock -2 -25 11 iron_block
   setblock -1 -25 11 hopper
   setblock 0 -25 11 iron_block
   setblock 1 -25 11 hopper
   setblock 2 -25 11 iron_block
   setblock -2 -24 11 iron_block
   setblock -1 -24 11 golden_rail
   setblock 0 -24 11 golden_rail
   setblock 1 -24 11 golden_rail
   setblock 2 -24 11 iron_block
   summon MinecartHopper 1 -24 11 "{Motion:[1.0,0.0,0.0]}"
   setblock -3 -24 11 lever 10
   setblock 2 -26 11 hopper 2
   setblock 1 -26 11 hopper 5
   setblock 0 -26 11 iron_block
   setblock -1 -26 11 hopper 4
   setblock -2 -26 11 hopper 2

   # nether spitter
   setblock 0 -21 11 hopper 2
   setblock 0 -21 10 hopper 2

   # hoppers leading up to dispenser
   setblock 0 -21 11 hopper 2 "{Items:[{Slot:0,id:red_flower,Count:64},{Slot:1,id:red_flower,Count:64},{Slot:2,id:red_flower,Count:64},{Slot:3,id:red_flower,Count:64},{Slot:4,id:red_flower,Count:64}]}"
   setblock 0 -21 10 hopper 2 "{Items:[{Slot:0,id:red_flower,Count:64},{Slot:1,id:red_flower,Count:64},{Slot:2,id:red_flower,Count:64},{Slot:3,id:red_flower,Count:64},{Slot:4,id:red_flower,Count:64}]}"
   setblock 0 -21 9 hopper 2 "{Items:[{Slot:0,id:red_flower,Count:64},{Slot:1,id:red_flower,Count:64},{Slot:2,id:red_flower,Count:64},{Slot:3,id:red_flower,Count:64},{Slot:4,id:red_flower,Count:64}]}"
   setblock 0 -21 8 hopper 2 "{Items:[{Slot:0,id:red_flower,Count:64},{Slot:1,id:red_flower,Count:64},{Slot:2,id:red_flower,Count:64},{Slot:3,id:red_flower,Count:64},{Slot:4,id:red_flower,Count:64}]}"
   setblock 0 -21 7 hopper 2 "{Items:[{Slot:0,id:red_flower,Count:64},{Slot:1,id:red_flower,Count:64},{Slot:2,id:red_flower,Count:64},{Slot:3,id:red_flower,Count:64},{Slot:4,id:red_flower,Count:64}]}"
   setblock 0 -21 6 hopper 2 "{Items:[{Slot:0,id:red_flower,Count:64},{Slot:1,id:red_flower,Count:64},{Slot:2,id:red_flower,Count:64},{Slot:3,id:red_flower,Count:64},{Slot:4,id:red_flower,Count:64}]}"
   setblock 0 -21 5 hopper 2 "{Items:[{Slot:0,id:red_flower,Count:64},{Slot:1,id:red_flower,Count:64},{Slot:2,id:red_flower,Count:64},{Slot:3,id:red_flower,Count:64},{Slot:4,id:red_flower,Count:64}]}"
   setblock 0 -21 4 hopper 0 "{Items:[{Slot:0,id:red_flower,Count:64},{Slot:1,id:red_flower,Count:64},{Slot:2,id:red_flower,Count:64},{Slot:3,id:red_flower,Count:64},{Slot:4,id:red_flower,Count:64}]}"
   setblock 0 -22 4 hopper 2  "{Items:[{Slot:0,id:red_flower,Count:64},{Slot:1,id:red_flower,Count:64},{Slot:2,id:red_flower,Count:64},{Slot:3,id:red_flower,Count:64},{Slot:4,id:red_flower,Count:64}]}"
   setblock 0 -22 3 dispenser 2
   
   # platform and redstone for dispenser
   fill -3 -23 3 3 -23 5 iron_block 0 replace 
   setblock -1 -22 3 iron_block
   setblock 1 -22 3 iron_block
   setblock 2 -22 3 unpowered_repeater 3 replace
   setblock 2 -22 5 unpowered_repeater 3 replace
   setblock 1 -22 4 unpowered_comparator 1 replace
   setblock 3 -22 3 redstone_wire
   setblock 3 -22 4 redstone_wire
   setblock 3 -22 5 redstone_wire
   setblock 2 -22 4 redstone_wire
   setblock 1 -22 5 redstone_wire 

   fill -3 -26 2 3 -26 4 iron_block 0 replace
   setblock -3 -26 4 iron_block 0 replace
   setblock 3 -26 4 iron_block 0 replace
   
   setblock 2 -25 3 sticky_piston 4 replace
   setblock -1 -25 3 sticky_piston 5 replace
   setblock 0 -25 3 redstone_block 0 replace

   setblock 3 -25 3 redstone_wire
   setblock -2 -25 3 redstone_wire
   setblock 0 -25 4 hopper 5 replace
   setblock 1 -25 4 hopper 4 replace "{Items:[{id:265,Count:32,Slot:0}]}"
   setblock 2 -25 4 unpowered_comparator 1 replace
   setblock -1 -25 4 unpowered_comparator 3 replace
   setblock -2 -25 4 iron_block
   setblock 3 -25 4 iron_block
   setblock 3 -24 4 unlit_redstone_torch
   
   # item elevator
   setblock -2 -26 10 hopper 2
   setblock -2 -26 9 hopper 2
   setblock -2 -26 8 hopper 2
   setblock -3 -27 7 packed_ice
   setblock -4 -27 7 packed_ice
   setblock -4 -27 8 iron_block
   setblock -4 -27 9 iron_block
   setblock -4 -27 10 packed_ice
   setblock -4 -27 11 packed_ice
   setblock -4 -27 12 packed_ice
   setblock -4 -27 13 packed_ice
   setblock -4 -27 14 iron_block
   setblock -3 -26 6 iron_block
   setblock -4 -26 6 iron_block
   setblock -5 -26 6 iron_block
   setblock -5 -26 7 iron_block
   setblock -5 -26 8 iron_block
   setblock -5 -26 9 iron_block
   setblock -5 -26 10 iron_block
   setblock -5 -26 11 iron_block
   setblock -5 -26 12 iron_block
   setblock -3 -26 8 iron_block
   setblock -3 -26 9 iron_block
   setblock -3 -26 10 iron_block
   setblock -3 -26 11 iron_block
   setblock -3 -26 12 iron_block
   setblock -3 -26 14 iron_block
   setblock -5 -26 14 iron_block
   setblock -3 -26 15 iron_block
   setblock -4 -26 15 iron_block
   setblock -5 -26 15 iron_block
   setblock -4 -26 14 fence
   setblock -4 -26 13 fence
   setblock -5 -26 13 stained_glass
   setblock -3 -26 13 stained_glass
   setblock -3 -25 7 stained_glass
   setblock -4 -25 7 stained_glass
   setblock -4 -25 8 stained_glass
   setblock -4 -25 9 stained_glass
   setblock -4 -25 10 stained_glass
   setblock -4 -25 11 stained_glass
   setblock -4 -25 12 stained_glass

   setblock 2 -26 10 hopper 2
   setblock 2 -26 9 hopper 2
   setblock 2 -26 8 hopper 2
   setblock 3 -27 7 packed_ice
   setblock 4 -27 7 packed_ice
   setblock 4 -27 8 iron_block
   setblock 4 -27 9 iron_block
   setblock 4 -27 10 packed_ice
   setblock 4 -27 11 packed_ice
   setblock 4 -27 12 packed_ice
   setblock 4 -27 13 packed_ice
   setblock 4 -27 14 iron_block
   setblock 3 -26 6 iron_block
   setblock 4 -26 6 iron_block
   setblock 5 -26 6 iron_block
   setblock 5 -26 7 iron_block
   setblock 5 -26 8 iron_block
   setblock 5 -26 9 iron_block
   setblock 5 -26 10 iron_block
   setblock 5 -26 11 iron_block
   setblock 5 -26 12 iron_block
   setblock 3 -26 8 iron_block
   setblock 3 -26 9 iron_block
   setblock 3 -26 10 iron_block
   setblock 3 -26 11 iron_block
   setblock 3 -26 12 iron_block
   setblock 3 -26 14 iron_block
   setblock 5 -26 14 iron_block
   setblock 3 -26 15 iron_block
   setblock 4 -26 15 iron_block
   setblock 5 -26 15 iron_block
   setblock 4 -26 14 fence
   setblock 4 -26 13 fence
   setblock 5 -26 13 stained_glass
   setblock 3 -26 13 stained_glass
   setblock 3 -25 7 stained_glass
   setblock 4 -25 7 stained_glass
   setblock 4 -25 8 stained_glass
   setblock 4 -25 9 stained_glass
   setblock 4 -25 10 stained_glass
   setblock 4 -25 11 stained_glass
   setblock 4 -25 12 stained_glass
   
   fill -2 -27 5 2 -27 7 iron_block
   setblock 0 -26 7 iron_block
   setblock -1 -26 7 unpowered_comparator 5 replace
   setblock 1 -26 7 unpowered_comparator 3 replace
   setblock -2 -26 7 dispenser 4 replace
   setblock 2 -26 7 dispenser 5 replace

   setblock 0 -26 6 unpowered_repeater 0 replace 
   setblock -2 -26 6 unpowered_repeater 2 replace
   setblock 2 -26 6 unpowered_repeater 2 replace 
   setblock -1 -26 6 redstone_wire
   setblock 1 -26 6 redstone_wire
   setblock -2 -26 5 redstone_wire 
   setblock -1 -26 5 redstone_wire
   setblock 0 -26 5 redstone_wire
   setblock 1 -26 5 redstone_wire
   setblock 2 -26 5 redstone_wire

 
   setblock -3 -26 7 flowing_water
   setblock 3 -26 7 flowing_water
   
   fill 3 -25 13 5 -3 15 stained_glass 0
   fill -3 -25 13 -5 -3 15 stained_glass 0
   
   # portal
   fill -2 -25 2 2 -21 2 obsidian
   fill -1 -24 2 1 -22 2 portal
   fill -2 -25 1 2 -21 1 iron_block
}




function fill {
   sendkeys "fill $[oX+$1] $[oY+$2] $[oZ+$3] $[oX+$4] $[oY+$5] $[oZ+$6] $7 $8 $9"
}

function setblock {
   #/setblock <x> <y> <z> <tilename> [datavalue] [oldblockHandling] [datatag]
   sendkeys "setblock $[oX+$1] $[oY+$2] $[oZ+$3] $4 $5 $6 $7"
}


function placedoor {
   setblock $1 $2 $3 wooden_door 0 replace
   sleep 0.1
   setblock $1 $[1+$2] $3 wooden_door 8 replace
}

function removedoor {
   setblock $1 $2 $3 air
   #setblock $1 $[1+$2] $3 air
}

function placedoorstrip {
   for ((z = -16; z < 16; z++))
   do
      placedoor $1 $2 $z
      sleep $doorsleep
   done
}

function createvillage {
   placedoor $[$1+5] $2 $[$3-1]
   sleep $doorsleep
   placedoor $[$1-64] $2 $3
   sleep $doorsleep
   placedoor $[$1-33] $2 $3
   sleep $doorsleep
   removedoor $[$1-64] $2 $3
   sleep $doorsleep
   placedoor $[$1-17] $2 $3
   sleep $doorsleep
   removedoor $[$1-33] $2 $3
   sleep $doorsleep
   placedoor $[$1-9] $2 $3
   sleep $doorsleep
   removedoor $[$1-17] $2 $3
   sleep $doorsleep
   placedoor $[$1-5] $2 $3
   sleep $doorsleep
   removedoor $[$1-9] $2 $3
   sleep $doorsleep
   placedoor $[$1-3] $2 $3
   sleep $doorsleep  
   removedoor $[$1-5] $2 $3
   sleep $doorsleep
   placedoor $[$1-1] $2 $3
   sleep $doorsleep  
   removedoor $[$1-3] $2 $3
   sleep $doorsleep
   placedoor $[$1-0] $2 $3
   sleep $doorsleep
   removedoor $[$1-1] $2 $3
   sleep $doorsleep
   removedoor $[$1+5] $2 $[$3-1]
   sleep $doorsleep
}

function createvilages {
   for ((z = -16; z < 16; z++))
   do
      createvillage 0 $1 $z
   done
}

function expandvilages {
   for x in 1 3 5 7 9 10 11 12 13 14 15 16 17 18 19 20
   do
      placedoorstrip $x $1
      placedoorstrip $[0 - $x] $1
   done
}

function clearinnerdoors {
   fill 9 $1 -16 -9 $[1+$1] 15 air 0 replace
}

function createlowervillages {
   createvilages 1
   expandvilages 1
   clearinnerdoors 1
}

function createuppervillages {
   createvilages 5
   expandvilages 5
   clearinnerdoors 5
}

function repositionvillagerpens {
   setblock 10 4 -1 stone 0 replace
   setblock 10 4 1 stone 0 replace
   setblock 11 4 0 stone 0 replace
   setblock -10 4 -1 stone 0 replace
   setblock -10 4 1 stone 0 replace
   setblock -11 4 0 stone 0 replace

   setblock 9 4 0 stone_slab 8 replace
   setblock -9 4 0 stone_slab 8 replace

   setblock 8 4 0 stained_glass 0 replace
   setblock -8 4 0 stained_glass 0 replace

   setblock 10 3 0 carpet 0 replace
   setblock -10 3 0 carpet 0 replace

   setblock 7 4 0 piston 5 replace
   setblock -7 4 0 piston 4 replace

   setblock 10 4 0 air 0 replace
   setblock -10 4 0 air 0 replace

   setblock 6 4 0 redstone_block 0 replace
   setblock -6 4 0 redstone_block 0 replace

   setblock 6 4 0 air 0 replace
   setblock -6 4 0 air 0 replace
   setblock 7 4 0 air 0 replace
   setblock -7 4 0 air 0 replace

   setblock 9 3 0 stained_glass 0 replace
   setblock -9 3 0 stained_glass 0 replace
   fill 9 5 -1 11 7 1 air 0 replace
   fill -9 5 -1 -11 7 1 air 0 replace
}

function createspawnplatforms {
   # clear out temporary blocks
   fill -9 0 -25 9 10 24 air 0 replace

   # platforms
   fill -9 5 -24 9 5 23 stone_slab 8 replace
   fill -9 1 -24 9 1 23 stone_slab 8 replace
   fill -9 -3 -24 9 -3 23 stone_slab 8 replace

   # hole
   fill -1 -3 -16 1 5 15 air 0 replace

   # rails
   fill -10 -2 -17 -10 -2 -25 stone 0 replace
   fill -10 -2 -25 10 -2 -25 stone 0 replace
   fill 10 -2 -17 10 -2 -25 stone 0 replace
   fill 10 -2 -17 10 -2 -25 stone 0 replace
   
   fill -10 2 -17 -10 2 -25 stone 0 replace
   fill -10 2 -25 10 2 -25 stone 0 replace
   fill 10 2 -17 10 2 -25 stone 0 replace
   fill 10 2 -17 10 2 -25 stone 0 replace

   fill -10 6 -17 -10 6 -25 stone 0 replace
   fill -10 6 -25 10 6 -25 stone 0 replace
   fill 10 6 -17 10 6 -25 stone 0 replace
   fill 10 6 -17 10 6 -25 stone 0 replace


   fill -10 -2 16 -10 -2 24 stone 0 replace
   fill -10 -2 24 10 -2 24 stone 0 replace
   fill 10 -2 16 10 -2 24 stone 0 replace
   fill 10 -2 16 10 -2 24 stone 0 replace
   
   fill -10 2 16 -10 2 24 stone 0 replace
   fill -10 2 24 10 2 24 stone 0 replace
   fill 10 2 16 10 2 24 stone 0 replace
   fill 10 2 16 10 2 24 stone 0 replace

   fill -10 6 16 -10 6 24 stone 0 replace
   fill -10 6 24 10 6 24 stone 0 replace
   fill 10 6 16 10 6 24 stone 0 replace
   fill 10 6 16 10 6 24 stone 0 replace

   setblock -10 -1 -25 iron_bars 0 replace
   setblock -9 -1 -25 iron_bars 0 replace
   setblock -10 -1 -24 iron_bars 0 replace
   setblock 10 -1 -25 iron_bars 0 replace
   setblock 9 -1 -25 iron_bars 0 replace
   setblock 10 -1 -24 iron_bars 0 replace
   setblock -10 -1 24 iron_bars 0 replace
   setblock -9 -1 24 iron_bars 0 replace
   setblock -10 -1 23 iron_bars 0 replace
   setblock 10 -1 24 iron_bars 0 replace
   setblock 9 -1 24 iron_bars 0 replace
   setblock 10 -1 23 iron_bars 0 replace

   setblock -10 3 -25 iron_bars 0 replace
   setblock -9 3 -25 iron_bars 0 replace
   setblock -10 3 -24 iron_bars 0 replace
   setblock 10 3 -25 iron_bars 0 replace
   setblock 9 3 -25 iron_bars 0 replace
   setblock 10 3 -24 iron_bars 0 replace
   setblock -10 3 24 iron_bars 0 replace
   setblock -9 3 24 iron_bars 0 replace
   setblock -10 3 23 iron_bars 0 replace
   setblock 10 3 24 iron_bars 0 replace
   setblock 9 3 24 iron_bars 0 replace
   setblock 10 3 23 iron_bars 0 replace

   setblock -10 7 -25 iron_bars 0 replace
   setblock -9 7 -25 iron_bars 0 replace
   setblock -10 7 -24 iron_bars 0 replace
   setblock 10 7 -25 iron_bars 0 replace
   setblock 9 7 -25 iron_bars 0 replace
   setblock 10 7 -24 iron_bars 0 replace
   setblock -10 7 24 iron_bars 0 replace
   setblock -9 7 24 iron_bars 0 replace
   setblock -10 7 23 iron_bars 0 replace
   setblock 10 7 24 iron_bars 0 replace
   setblock 9 7 24 iron_bars 0 replace
   setblock 10 7 23 iron_bars 0 replace

   setblock -9 -2 -24 stone 0 replace
   setblock 9 -2 -24 stone 0 replace
   setblock -9 -2 23 stone 0 replace
   setblock 9 -2 23 stone 0 replace
   setblock -9 2 -24 stone 0 replace
   setblock 9 2 -24 stone 0 replace
   setblock -9 2 23 stone 0 replace
   setblock 9 2 23 stone 0 replace
   setblock -9 6 -24 stone 0 replace
   setblock 9 6 -24 stone 0 replace
   setblock -9 6 23 stone 0 replace
   setblock 9 6 23 stone 0 replace

   setblock -9 -1 -24 flowing_water 0 replace
   setblock 9 -1 -24 flowing_water 0 replace
   setblock -9 -1 23 flowing_water 0 replace
   setblock 9 -1 23 flowing_water 0 replace
   setblock -9 3 -24 flowing_water 0 replace
   setblock 9 3 -24 flowing_water 0 replace
   setblock -9 3 23 flowing_water 0 replace
   setblock 9 3 23 flowing_water 0 replace
   setblock -9 7 -24 flowing_water 0 replace
   setblock 9 7 -24 flowing_water 0 replace
   setblock -9 7 23 flowing_water 0 replace
   setblock 9 7 23 flowing_water 0 replace

   fill -7 -2 -24 7 -2 -24 flowing_water 0 replace
   fill -7 2 -24 7 2 -24 flowing_water 0 replace
   fill -7 6 -24 7 6 -24 flowing_water 0 replace
   fill -7 -2 23 7 -2 -24 flowing_water 0 replace
   fill -7 2 23 7 2 -24 flowing_water 0 replace
   fill -7 6 23 7 6 -24 flowing_water 0 replace
   
   #fill -8 -2 -21 -8 -2 20 flowing_water 0 replace
   #fill -8 2 -22 -8 2 21 flowing_water 0 replace
   #fill -8 6 -22 -8 6 21 flowing_water 0 replace
   #fill 8 -2 -22 8 -2 21 flowing_water 0 replace
   #fill 8 2 -22 8 2 21 flowing_water 0 replace
   #fill 8 6 -22 8 6 21 flowing_water 0 replace
}


function summon {
   sendkeys "summon $1 $[oX+$2] $[oY+3] $[oZ+$4] $5"
}

clearAllBlocks
#buildLowerPlatform
#buildCover 3
#buildCenterCover
#buildVillagerPens
#summonVillagers
#buildGolemChute
#buildGolemDropHandler
#createlowervillages
#repositionvillagerpens
#buildCover 7
#buildUpperPlatform
#createuppervillages
createspawnplatforms


sendkeys "me Finished building the Iron Titan"
echo AllDone
