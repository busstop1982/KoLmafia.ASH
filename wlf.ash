void buy_missing( item what, int howmany )
{
	boolean d = retrieve_item(howmany - item_amount( what ), what);
	if( item_amount( what ) < howmany )
	{
        d = buy( howmany - item_amount( what ), what );
	}
}

void buy_missing( item what )
{
	buy_missing( what, 1 );
}

void main()
{
	boolean d;
	buffer b;
        d = equip($item[smooth velvet hat]);
        d = equip($item[smooth velvet shirt]);
        d = equip($item[smooth velvet pants]);
        d = equip($slot[acc1],$item[smooth velvet hanky]);
        d = equip($slot[acc2],$item[smooth velvet socks]);
        d = equip($slot[acc3],$item[smooth velvet pocket square]);
        b = visit_url("place.php?whichplace=airport_hot&action=airport4_zone1");
        b = run_choice(7);
        d = cli_execute("fitting.ash");

    d = adv1($location[An Overgrown Shrine (Southwest)], -1, ""); // Deal with pending timepranks
	b = visit_url( "place.php?whichplace=airport_hot&action=airport4_questhub" );
	if( get_property( "_volcanoItemRedeemed" ).to_boolean() )
	{
		print( "Already done W.L.F. quest" );
	}
	else
	{
		int[item] questtokens;
		for( int i = 1; i <= 3; i++ )
		{
			questtokens[ get_property( "_volcanoItem" + i ).to_item() ] = i;
		}
		if( questtokens contains $item[ New Age healing crystal ] )
		{
			print( "Acquiring " + $item[ New Age healing crystal ].to_string() );
			buy_missing( $item[ New Age healing crystal ], 5 );
			print( "Turning in " + $item[ New Age healing crystal ].to_string() );
			b = visit_url( "place.php?whichplace=airport_hot&action=airport4_questhub" );
			b = run_choice( questtokens[ $item[ New Age healing crystal ] ] );
			return;
		}
		if( questtokens contains $item[ SMOOCH bottlecap ] )
		{
			print( "Acquiring " + $item[ SMOOCH bottlecap ].to_string() );
			buy_missing( $item[ SMOOCH bottlecap ], 1 );
			print( "Turning in " + $item[ SMOOCH bottlecap ].to_string() );
			b = visit_url( "place.php?whichplace=airport_hot&action=airport4_questhub" );
			b = run_choice( questtokens[ $item[ SMOOCH bottlecap ] ] );
			return;
		}
		if( questtokens contains $item[ gooey lava globs ] )
		{
			print( "Acquiring " + $item[ gooey lava globs ].to_string() );
			buy_missing( $item[ gooey lava globs ], 5 );
			print( "Turning in " + $item[ gooey lava globs ].to_string() );
			b = visit_url( "place.php?whichplace=airport_hot&action=airport4_questhub" );
			b = run_choice( questtokens[ $item[ gooey lava globs ] ] );
			return;
		}
		if( questtokens contains $item[ fused fuse ] )
		{
			print( "Acquiring " + $item[ fused fuse ].to_string() );
			if( !get_property( "_claraBellUsed" ).to_boolean() )
			{
				d = use( 1, $item[ Clara's bell ] );
				string oldchoice = get_property( "choiceAdventure1091" );
				set_property( "choiceAdventure1091", "7" );
				d = adv1($location[An Overgrown Shrine (Southwest)], -1, ""); // Deal with pending timepranks
				d = adventure( 1, $location[ LavaCo&trade; Lamp Factory ] );
				set_property( "choiceAdventure1091", oldchoice );
			}
			if( item_amount( $item[ fused fuse ] ) > 0 )
			{
				print( "Turning in " + $item[ fused fuse ].to_string() );
				b = visit_url( "place.php?whichplace=airport_hot&action=airport4_questhub" );
				b = run_choice( questtokens[ $item[ fused fuse ] ] );
			}
			else
			{
				print( "Failed to get " + $item[ fused fuse ] );
			}
			return;
		}
		if( questtokens contains $item[ smooth velvet bra ] )
		{
			print( "Acquiring " + $item[ smooth velvet bra ].to_string() );
			buy_missing( $item[ unsmoothed velvet ], 9 );
			d = create( 3, $item[ smooth velvet bra ] );
			print( "Turning in " + $item[ smooth velvet bra ].to_string() );
			b = visit_url( "place.php?whichplace=airport_hot&action=airport4_questhub" );
			b = run_choice( questtokens[ $item[ smooth velvet bra ] ] );
			return;
		}
		if( questtokens contains $item[ SMOOCH bracers ] )
		{
			print( "Acquiring " + $item[ SMOOCH bracers ].to_string() );
			buy_missing( $item[ superheated metal ], 15 );
			d = create( 3, $item[ SMOOCH bracers ] );
			print( "Turning in " + $item[ SMOOCH bracers ].to_string() );
			b = visit_url( "place.php?whichplace=airport_hot&action=airport4_questhub" );
			b = run_choice( questtokens[ $item[ SMOOCH bracers ] ] );
			return;
		}
		if( questtokens contains $item[ superduperheated metal ] )
		{
			print( "Acquiring " + $item[ superduperheated metal ].to_string() );
			buy_missing( $item[ superduperheated metal ], 1 );
			print( "Turning in " + $item[ superduperheated metal ].to_string() );
			b = visit_url( "place.php?whichplace=airport_hot&action=airport4_questhub" );
			b = run_choice( questtokens[ $item[ superduperheated metal ] ] );
			return;
		}
		print( "Unable to find a \"cheap\" quest" );
	}

}
