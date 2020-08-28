string fr_hat(){

if (  $item[fantasyrealm mage's hat].available_amount() < $item[fantasyrealm warrior's helm].available_amount() ) return "Mage";
else if (  $item[fantasyrealm rogue's mask].available_amount() < $item[fantasyrealm warrior's helm].available_amount() ) return "Rogue";
else return "Warrior";
}

item bonkstick(string mode){
    item  woc;
    if (mode == "melee"){
        foreach key in $items[stick-knife of loathing, hothammer, porcelain police baton]{
                if ( can_equip(key) ){
                    woc = key;
                    break;
                }
        }
    }
    if (mode == "caster"){
        foreach key in $items[staff of kitchen royalty, staff of simmering hatred, staff of the soupbone]{
                if ( can_equip(key) ){
                    woc = key;
                    break;
                }
        }
    }
    return woc;
}

int killed (monster opp){
int done = 0;
string target = opp.to_string();
string [int] map = split_string("_frMonstersKilled".get_property(),",");
foreach key in map{
    if (contains_text(map[key],target)){
        done = substring(map[key],target.length()+1).to_int();
        break;
    }
}
return done;
}

boolean flavour (monster target){
skill flavour;

switch (monster_element(target))
{
case $element[cold]:   flavour = $skill[Spirit of Cayenne];    break;
case $element[spooky]: flavour = $skill[Spirit of Cayenne];    break;
case $element[hot]:    flavour = $skill[Spirit of Garlic];     break;
case $element[stench]: flavour = $skill[Spirit of Peppermint]; break;
case $element[sleaze]: flavour = $skill[Spirit of Peppermint]; break;
case $element[none]:   flavour = $skill[none];                 break;
}
if ( have_skill(flavour) && flavour != $skill[none] ) use_skill(flavour);
return true;
}

string fight ( int round, monster opp, string text ){
    if ( opp == $monster[cursed villager] ){
        if ( round == 2 )
            return "item exploding cigar";
        if ( contains_text( equipped_item($slot[weapon]).to_string().to_lower_case(), "staff" )) return "jiggle chefstaff";
        else return "items porquoise-handled sixgun, hamethyst-handled sixgun";
    }
    if ( opp == $monster[fantasy ourk] || opp == $monster[rubber bat] || opp == $monster[fantasy forest faerie] || opp == $monster[spooky ghost]){
        return "skill Saucegeyser";
    }
    if ( opp == $monster[swamp monster] || opp == $monster[fantasy bandit]){
        if ( my_class() == $class[Pastamancer] ) return "skill Cannelloni Cannon";
        else if ( my_class() == $class[Seal Clubber] ) return "skill Lunging Thrust-Smack";
        else if ( my_class() == $class[Turtle Tamer] ) return "skill Headbutt";
        else return "skill Saucegeyser";
    }
    return get_ccs_action(round);
}

void main(){
//if ( my_adventures() < 38 ) abort("Not enough adventures!");
    boolean d = cli_execute("condition clear");
    buffer b;
    matcher m;
    monster [int] tempm;
    familiar bubu = my_familiar();
    d = cli_execute("ccs fantasyrealm");
    d = use_familiar($familiar[none]);
    d = retrieve_item(1, $item[porquoise-handled sixgun]);
    d = retrieve_item(1, $item[hamethyst-handled sixgun]);
    if ( $item[FantasyRealm G. E. M.].available_amount() < 1){
        b = visit_url("place.php?whichplace=realm_fantasy&action=fr_initcenter");
        string [int] cho = available_choice_options();
        foreach key in cho{
            if ( contains_text(cho[key], fr_hat()) )
                run_choice(key);
        }
    }
    if ($item[FantasyRealm key].available_amount() < 1 ) buy(1,$item[FantasyRealm key]);

    d = equip($slot[weapon], bonkstick("caster") );
    d = equip($slot[off-hand], $item[LyleCo premium magnifying glass]);
    d = equip($slot[acc2], $item[LyleCo premium monocle]);
    d = equip($slot[acc3], $item[FantasyRealm G. E. M.]);
    if ( have_skill($skill[Summon &quot;Boner Battalion&quot;]) ){
        if ( my_mp() < 250 ) restore_mp(250);
        d = use_skill(1, $skill[Summon &quot;Boner Battalion&quot;]);
    }
    while ( killed(506.to_location().get_monsters() [0]) != 5){
        d = adventure(1, 506.to_location(), "fight"); //cursed village
    }
    if ( have_effect($effect[fortunate\, son]) < 1 )
        d = adventure(1, 506.to_location() ); // rubee buff

    foreach i in $ints[502, 503, 504, 505, 507]{
        if ( i == 503 || i == 504 || i == 507) d = equip( $slot[weapon], bonkstick("caster") );
        else d = equip( $slot[weapon], bonkstick("melee") );
        d = flavour(i.to_location().get_monsters() [0]);
        while ( killed(i.to_location().get_monsters() [0]) != 5) {
            d = adventure(1, i.to_location(), "fight");
        }
    }
    d = adventure(1, 507.to_location() ); //sprawling cemetary, get rubees
    d = adventure(1, 503.to_location() ); //towering mountains, open caves
    d = equip( $slot[weapon], bonkstick("caster") );
    d = adventure(6, 510.to_location(), "fight"); //foreboding cave + rubees
    d = cli_execute("fitting.ash");
    d = use_familiar(bubu);
}
