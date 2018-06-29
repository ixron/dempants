/**************************************************************************
* dempants by ixron
* Version 0.3
* https://github.com/ixron/dempants
**************************************************************************/
script "dempants";
notify "charles christ";

/**************************************************************************
Script Options:
 - level : Will make pants based on class to assist in leveling.
 - meat  : Will make pants to use for meat farming. 
**************************************************************************/

/*
TODO:
 - Add more script options.
*/

//-------------------------------------------------------------------------
// Max price used when buying from the mall
int bubblinCrudeMax = 100;			//1x bubblin' crude - 5789 (Regenerate 5-15 MP per Adventure)
int royalJellyMax = 154; 			//1x royal jelly - 830 (Regenerate 5-15 HP per Adventure)
int tacoShellMax = 100; 			//1x taco shell - 173 (+30% Meat from Monsters)
int porquoiseMax = 1000; 			//1x porquoise - 706 (+60% Meat from Monsters) math the number
int tinyDancerMax = 2000; 			//1x tiny dancer - 7338 (+30% Item Drops from Monsters)
int knobGoblinFirecrackerMax = 200; //3x Knob Goblin firecracker - 747 (+3 Muscle Stats Per Fight)
int razorSharpCanLidMax = 100; 		//3x razor-sharp can lid - 559 (+3 Mysticality Stats Per Fight)
int spiderWebMax = 100; 			//3x spider web - 27 (+3 Moxie Stats Per Fight)
int syntheticMarrowMax = 1000; 		//5x synthetic marrow - 7327 (+25% to all Mus gains)
int hauntedBatteryMax = 1000; 		//5x haunted battery - 7324 (+25% to all Myst gains)
int theFunkMax = 1000; 				//5x the funk - 7330 (+25% to all Moxie gains)
int barSkinMax = 100; 				//1x bar skin - 70 (+50% Combat Initiative)
int disassembledCloverMax = 1000; 	//1x ten-leaf clover - 24 (Occasional Hilarity)

//-------------------------------------------------------------------------
boolean itemShop (item n, int count, int maxCost) {
	boolean countGoal = false;
	if(can_interact()) {
		if ( item_amount( n ) < count) {
			print("Trying to buy: " + count + " " + n + " @ " + maxCost, "blue");
			buy((count - item_amount( n )),n,maxCost);
		}	
	} else if (!in_hardcore()) {
		
		if ( (item_amount( n )+storage_amount( n )) < count ) {
			print("Trying to buy: " + count + " " + n + " @ " + maxCost, "blue");
			buy((count - (item_amount( n ) + storage_amount( n ))),n,maxCost);
		}
		if ( (item_amount( n )+storage_amount( n )) > count && item_amount( n ) < count) {
			if ( pulls_remaining() > (count - item_amount( n ))) {
				take_storage(count - item_amount( n ), n );			
			}		
		}		
	}	
	if ( item_amount( n ) >= count) {
		countGoal = true;
		}
	return countGoal;
}

void main(string params) {
	
	string type = my_primestat();
	string alignment = "1&m=1";
	string resist = "&e=5";
	string left = "&s1=-1%2C0";
	string right = "&s2=-1%2C0";
	string middle = "&s3=-1%2C0";
	
	if ( item_amount($item[portable pantogram]) == 0 ) {
		print("You do not have a portable pantogram in your bag." , "red");
        return;
    }    
    if ( get_property("_pantogramModifier") != "" ) {
        print("You've already summoned a pair of amazing, arcane, artisanal pants today." , "orange");
        return;
    }
	
	switch ( params ) {
		case "level":
			switch ( type ) {
				case "Mysticality":				
					alignment = "1&m=2";
					
					if ( itemShop ($item[bubblin' crude],1, bubblinCrudeMax) ) {
						left = "&s1=5789%2C1";
					} else if ( itemShop ($item[royal jelly],1, royalJellyMax) ) {
						left = "&s1=830%2C1";
					} else {
						left = "&s1=-2%2C0";
					}
					
					if ( itemShop ($item[haunted battery],5, hauntedBatteryMax) ) {
						right = "&s2=7324%2C5";
					} else if ( itemShop ($item[razor-sharp can lid],3, razorSharpCanLidMax) ) {
						right = "&s2=559%2C3";
					} else {
						right = "&s2=-2%2C0";
					}
					
					if ( itemShop ($item[bar skin],1, barSkinMax) ) {
						middle = "&s3=70%2C1";
					} else {
						middle = "&s3=-1%2C0";
					}
					
					break;
				case "Muscle":
					alignment = "1&m=1";
					
					if ( itemShop ($item[royal jelly],1, royalJellyMax) ) {
						left = "&s1=830%2C1";
					} else if ( itemShop ($item[bubblin' crude],1, bubblinCrudeMax) ) {
						left = "&s1=5789%2C1";
					} else {
						left = "&s1=-1%2C0";
					}
					
					if ( itemShop ($item[synthetic marrow],5, syntheticMarrowMax) ) {
						right = "&s2=7327%2C5";
					} else if ( itemShop ($item[Knob Goblin firecracker],3, knobGoblinFirecrackerMax) ) {
						right = "&s2=747%2C3";
					} else {
						right = "&s2=-1%2C0";
					}
					
					if ( itemShop ($item[bar skin],1, barSkinMax) ) {
						middle = "&s3=70%2C1";
					} else {
						middle = "&s3=-1%2C0";
					}
					
					break;
				case "Moxie":
					alignment = "1&m=3";
					
					if ( itemShop ($item[royal jelly],1, royalJellyMax) ) {
						left = "&s1=830%2C1";
					} else if ( itemShop ($item[bubblin' crude],1, bubblinCrudeMax) ) {
						left = "&s1=5789%2C1";
					} else {
						left = "&s1=-1%2C0";
					}
					
					if ( itemShop ($item[the funk],5, theFunkMax) ) {
						right = "&s2=7330%2C5";
					} else if ( itemShop ($item[spider web],3, spiderWebMax) ) {
						right = "&s2=27%2C3";
					} else {
						right = "&s2=-1%2C0";
					}
					
					if ( itemShop ($item[bar skin],1, barSkinMax) ) {
						middle = "&s3=70%2C1";
					} else {
						middle = "&s3=-1%2C0";
					}		
					break;
				default:
					print("Level - Default case hit." , "red");
			}		
			break;
		case "meat":
			switch ( type ) {
				case "Mysticality":
					alignment = "1&m=2";
					
					if ( itemShop ($item[bubblin' crude],1, bubblinCrudeMax) ) {
						left = "&s1=5789%2C1";
					} else if ( itemShop ($item[royal jelly],1, royalJellyMax) ) {
						left = "&s1=830%2C1";
					} else {
						left = "&s1=-2%2C0";
					}
					
					if ( itemShop ($item[porquoise],1, porquoiseMax) ) {
						right = "&s2=706%2C1";
					} else if ( itemShop ($item[taco shell],1, tacoShellMax) ) {
						right = "&s2=173%2C1";
					} else if ( itemShop ($item[tiny dancer],1, tinyDancerMax) ) {
						right = "&s2=7338%2C1";
					} else {
						right = "&s2=-2%2C0";
					}
					
					if ( itemShop ($item[disassembled clover],1, disassembledCloverMax) ) {
						use( 1, $item[disassembled clover] );
						middle = "&s3=24%2C1";
					} else if ( itemShop ($item[bar skin],1, barSkinMax) ) {
						middle = "&s3=70%2C1";
					} else {
						middle = "&s3=-1%2C0";
					}							
					break;
				case "Muscle":
					alignment = "1&m=1";
					
					if ( itemShop ($item[royal jelly],1, royalJellyMax) ) {
						left = "&s1=830%2C1";
					} else if ( itemShop ($item[bubblin' crude],1, bubblinCrudeMax) ) {
						left = "&s1=5789%2C1";
					} else {
						left = "&s1=-1%2C0";
					}
					
					if ( itemShop ($item[porquoise],1, porquoiseMax) ) {
						right = "&s2=706%2C1";
					} else if ( itemShop ($item[taco shell],1, tacoShellMax) ) {
						right = "&s2=173%2C1";
					} else if ( itemShop ($item[tiny dancer],1, tinyDancerMax) ) {
						right = "&s2=7338%2C1";
					} else {
						right = "&s2=-1%2C0";
					}
					
					if ( itemShop ($item[disassembled clover],1, disassembledCloverMax) ) {
						use( 1, $item[disassembled clover] );
						
						middle = "&s3=24%2C1";
					} else if ( itemShop ($item[bar skin],1, barSkinMax) ) {
						middle = "&s3=70%2C1";
					} else {
						middle = "&s3=-1%2C0";
					}					
					break;
				case "Moxie":
					alignment = "1&m=3";
					
					if ( itemShop ($item[royal jelly],1, royalJellyMax) ) {
						left = "&s1=830%2C1";
					} else if ( itemShop ($item[bubblin' crude],1, bubblinCrudeMax) ) {
						left = "&s1=5789%2C1";
					} else {
					left = "&s1=-1%2C0";
					}
					
					if ( itemShop ($item[porquoise],1, porquoiseMax) ) {
						right = "&s2=706%2C1";
					} else if ( itemShop ($item[taco shell],1, tacoShellMax) ) {
						right = "&s2=173%2C1";
					} else if ( itemShop ($item[tiny dancer],1, tinyDancerMax) ) {
						right = "&s2=7338%2C1";
					} else {
						right = "&s2=-1%2C0";
					}
					
					if ( itemShop ($item[disassembled clover],1, disassembledCloverMax) ) {
						use( 1, $item[disassembled clover] );
						middle = "&s3=24%2C1";
					} else if ( itemShop ($item[bar skin],1, barSkinMax) ) {
						middle = "&s3=70%2C1";
					} else {
						middle = "&s3=-1%2C0";
					}					
					break;
				default:
					print("Meat - Default case hit." , "red");
			}			
			break;		
		default:
			print("Unrecognized setting." , "red");
			return;
	}
	
	visit_url("inv_use.php?pwd&which=99&whichitem=9573");
	visit_url("choice.php?whichchoice=1270&pwd&option=" + alignment + resist + left + right + middle, true, true);
	print("Pantcifer, the Lord of Pants Hell accepts your sacrifice.  Enjoy dempants." , "green");
}
