void main()
{
boolean d;
buffer b;
d = cli_execute( "acquire filter helmet, exo-servo leg braces, gate transceiver, rad cloak, high-friction boots, geological sample kit" );
d = cli_execute( "maximize spell damage percent, weapon, type chefstaff" );
d = use_familiar( $familiar[ Trick-or-Treating Tot ] );
string maxer = "all res, equip sea salt scrubs, equip geological sample kit, -weapon";
string hazards = get_property( "_spacegateHazards" );
if( contains_text( hazards, "toxic atmosphere" ) ) maxer += ", equip filter helmet";
if( contains_text( hazards, "high gravity" ) ) maxer += ", equip exo-servo leg braces";
if( contains_text( hazards, "magnetic storms" ) ) maxer += ", equip gate transceiver";
if( contains_text( hazards, "irradiated" ) ) maxer += ", equip rad cloak";
if( contains_text( hazards, "high winds" ) ) maxer += ", equip high-friction boots";
d = cli_execute( "maximize " + maxer );
print("Ready for strange new worlds!");
}
