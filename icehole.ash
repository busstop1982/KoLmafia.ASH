  string fight( int round, monster opp, string text ){
    return get_ccs_action(round);
}

void fishy () {
    item hat = equipped_item($slot[hat]);
    if ( have_effect($effect[driving waterproofly]) == 0 )
        equip ($item[mer-kin scholar mask]);
    if ( get_property("skateParkStatus") == "ice" ){
        visit_url("sea_skatepark.php?action=state2buff1&pwd");
        if ( have_effect($effect[driving waterproofly]) == 0 )
            equip (hat);
    }
    else if (retrieve_item(1, $item[centauri fish wine])){
        if ( have_effect($effect[ode to booze]) < 2 ) use_skill($skill[the ode to booze]);
        drink(1, $item[centauri fish wine]);
        cli_execute("shrug ode to booze");
    }
    else {
    outfit("Backup");
    abort("Can't get fishy.");
    }
}

void walford (){
    boolean done = true;
    visit_url("place.php?whichplace=airport_cold&action=glac_walrus");
    string [int] cho = available_choice_options();
    foreach key in cho{
        if ( contains_text(cho[key], "get you some") || contains_text(cho[key], "bucket") ) done = false;
    }
    if ( !done ){
        foreach key in cho{
            if ( contains_text(cho[key], "get you some") || contains_text(cho[key], "Turn in") || contains_text(cho[key], "your leave") ) {run_choice(key); return;}
        }
    }
    else
        abort("Already done that today!");
}

void drive (){
    int fuel;
    matcher m = create_matcher ( "fuel gauge reads (.+?) (?:litre|litres) of fuel.", visit_url("campground.php?action=workshed") );
    if (m.find()) fuel = m.group(1).to_int();
    int usebread = (37-fuel)/6;
    int mbread = usebread - item_amount($item[loaf of soda bread]);

    if ( mbread > 0 && retrieve_item(mbread+2, $item[soda water]) && retrieve_item(mbread+2, $item[wad of dough]) )
        craft ("cook", mbread+2, $item[soda water], $item[wad of dough]);
    if ( usebread > 0 ){
        cli_execute("asdonmartin fuel "+usebread+" loaf of soda bread");
    }
    m = create_matcher ( "fuel gauge reads (.+?) (?:litre|litres) of fuel.", visit_url("campground.php?action=workshed") );
    if (m.find()) fuel = m.group(1).to_int();
    if ( fuel < 37 ) cli_execute("asdonmartin fuel 1 loaf of soda bread");
    if ( fuel < 32 ) cli_execute("asdonmartin fuel 1 loaf of soda bread");
    cli_execute("asdonmartin drive waterproofly");

}
// if quest is done and not turned in, starting this will spend adv in the icehole
void main(){
    walford();
    item offhand = equipped_item($slot[off-hand]);
    boolean d;
    d = retrieve_item(1, $item[alarm accordion]);
    d = retrieve_item(1, $item[aerogel accordion]);
    d = equip($item[walford's bucket]);
    d = equip($slot[acc3], $item[stinky fannypack]);
    d = equip($slot[acc2], $item[stinky fannypack]);
    //d = cli_execute("outfit guzzler");
    d = cli_execute("ccs ice hole");
    d = cli_execute("shrug ode to booze");
    if ( have_effect($effect[Driving Waterproofly]) < (100 - get_property("walfordBucketProgress").to_int())/5 )
        drive();
    if ( have_effect($effect[Fishy]) == 0 )
        fishy();
    while ( have_effect($effect[Fishy]) > have_effect($effect[Donho's Bubbly Ballad]) && (have_effect($effect[Donho's Bubbly Ballad])<30)){
        if ( my_mp() < 80 ) restore_mp( 80 - my_mp() );
        use_skill( 1 , $skill[Donho's Bubbly Ballad]);
    }
    if ( have_effect($effect[Expert vacationer]) < 1 )d = use(1, $item[exotic travel brochure]);
    while ( get_property("walfordBucketProgress").to_int() < 100 ){
        d = cli_execute("familiars.ash");
        adventure(1, to_location("The Ice Hole"), "fight");
    }
    walford();
    d = cli_execute("fitting.ash");
    foreach key in $items[octolus-skin cloak, norwhal helmet, sardine can key]{
        put_shop(0,0,item_amount(key)-1, key);
    }
}
