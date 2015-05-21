#!/bin/bash

# origin coordinates
oX=0
oY=150
oZ=285


function sendkeys {
   # replace this with whatever command it takes on your server to send keys to 
   # the minecraft console. In this case, I am running tmux as the minecraft user
   # using a named console.
   sudo -u minecraft tmux send-keys -t minecraft-console "$1" C-m
   sleep .25
}


function clearAllBlocks {
   sendkeys "me Clearing away the area"
   for ((Y = -20; Y < 11; Y++))
   do 
      fill -66 $Y -16 22 $Y 16 air 0 replace
      #fill 0 $Y -16 22 $Y 15 air 0 replace
   done
}

function buildLowerPlatform {
   sendkeys "me Building the lower platform"
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

function buildLowerCover {
   sendkeys "me Building the lower cover"
   
   # western cover
   fill -21 3 -16 -10 3 15 stone 0 replace
   fill -13 3 -16 -12 3 15 glass 0 replace

   # eastern cover
   fill 10 3 -16 22 3 15 stone
   fill 11 3 -16 12 3 15 glass

   # western strip covers
   fill -33 3 -16 -34 3 15 cobblestone 
   fill -64 3 -16 -65 3 15 cobblestone

   # sea lanterns
   for ((Z = 14; Z >= -14; Z -= 4))
   do
      setblock -11 3 $Z sea_lantern
      setblock -14 3 $Z sea_lantern
      setblock -18 3 $Z sea_lantern
      setblock -7 3 $Z sea_lantern
      setblock -2 3 $Z sea_lantern
      setblock 2 3 $Z sea_lantern
      setblock 6 3 $Z sea_lantern
      setblock 10 3 $Z sea_lantern
      setblock 14 3 $Z sea_lantern
      setblock 18 3 $Z sea_lantern
      setblock -35 3 $Z sea_lantern
      setblock -66 3 $Z sea_lantern
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
   fill -2 0 16 2 -19 16 stained_glass 0 replace
   fill -2 -1 12 2 -19 12 stained_glass 0 replace
   fill -2 -1 16 -2 -20 12 iron_block 0 replace
   fill 2 -1 16 2 -20 12 iron_block 0 replace
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
   
   # item splitter
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
   summon MinecartHopper 1 -24 11
   setblock -3 -24 11 lever 2
   setblock 2 -26 11 hopper 2
   setblock 1 -26 11 hopper 5
   setblock 0 -26 11 iron_block
   setblock -1 -26 11 hopper 4
   setblock -2 -26 11 hopper 2

   
}

function fill {
   sendkeys "fill $[oX+$1] $[oY+$2] $[oZ+$3] $[oX+$4] $[oY+$5] $[oZ+$6] $7 $8 $9"
}

function setblock {
   #/setblock <x> <y> <z> <tilename> [datavalue] [oldblockHandling] [datatag]
   sendkeys "setblock $[oX+$1] $[oY+$2] $[oZ+$3] $4 $5 $6 $7"
}


#clearAllBlocks
#buildLowerPlatform
#buildLowerCover
#buildCenterCover
#buildVillagerPens
#summonVillagers
#buildGolemChute
buildGolemDropHandler



sendkeys "me Finished building the Iron Titan"
echo AllDone
