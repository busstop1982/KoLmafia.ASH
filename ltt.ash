

string mob ( int round, monster opp, string text )
{
if ( round >10 ) return "item exploding cigar";
return get_ccs_action(round);
}

string boss ( int round, monster opp, string text )
{
string putout;
string dcolor;
string cyn;
    //for the construct, get the required disc-color and use it; with or w/o healing crystal
if ( opp == $monster[ unusual construct ] )
    {
    if ( contains_text(text, "LANO BUPABU NIZEVE") || contains_text(text, "LANO SOM NIZEVE") || contains_text(text, "LANO PATA NIZEVE") ) dcolor = "black";
    if ( contains_text(text, "LANO FUFUGAKRO NIZEVE") || contains_text(text, "LANO BULAZAK NIZEVE") || contains_text(text, "LANO BELA NIZEVE") || contains_text(text, "LANO BU NIZEVE") ) dcolor = "blue";
    if ( contains_text(text, "LANO ZEVEBENI NIZEVE") || contains_text(text, "LANO BE NIZEVE") || contains_text(text, "LANO ZAKSOM NIZEVE") ) dcolor = "green";
    if ( contains_text(text, "LANO ZEVESTANO NIZEVE") || contains_text(text, "LANO ZEVE NIZEVE") || contains_text(text, "LANO CHAKRO NIZEVE") ) dcolor = "red";
    if ( contains_text(text, "LANO PACHA NIZEVE") || contains_text(text, "LANO NIPA NIZEVE") || contains_text(text, "LANO SOMPAPA NIZEVE") ) dcolor = "white";
    if ( contains_text(text, "LANO CHO NIZEVE") || contains_text(text, "LANO FUNI NIZEVE") || contains_text(text, "LANO TAZAK NIZEVE") ) dcolor = "yellow";

    if ( (my_maxhp() - my_hp()) >= 500 )
        cyn = ", new age healing crystal";
    else
        cyn = "";

    putout = "item strange disc ("+dcolor+")"+cyn;

    }

if ( opp == $monster[ granny hackleton ] ) putout = "attack";

if ( opp == $monster[ clara ] ) putout = "skill shrap";

return putout;
}

void clerk(){
int choose;
int price = 0;
boolean bribe = false;
//potentially paying for overtime
visit_url("place.php?whichplace=town_right&action=townright_ltt&pwd");
string [int] cho = available_choice_options();
        foreach key in cho {
            if ( contains_text(cho[key], "overtime")){
                price = substring( cho[key], 14, index_of(cho[key], " Meat") ).to_int();
                choose = key;
                bribe = true;
            }
        }
        if (price < 50000 && bribe){
            print("Bribing clerk with "+price+" meat.");
            run_choice(choose);
        }
        if (price > 50000)
            abort("The new telegram is over 9000(*10 meat)! Please buy manually.");
//get the new telegram

visit_url("place.php?whichplace=town_right&action=townright_ltt&pwd");
cho = available_choice_options();
    foreach key in cho {
        if ( contains_text(cho[key], "Wagon Train Escort Wanted") || contains_text(cho[key], "Many Children") || contains_text(cho[key], "Madness at the Mine") ){
            run_choice(key);
            print("Picking telegram: "+cho[key]);
        }
    }
}


void main(){
boolean d = cli_execute("goal clear");
if ( !have_skill($skill[Frigidalmatian]) )
    if ( retrieve_item(1, $item[Hjodor's Guide to Arctic Dalmatians (used)]))
        use(1, $item[Hjodor's Guide to Arctic Dalmatians (used)]);
if ( !have_skill($skill[Silent Treatment]) )
    if ( retrieve_item(1, $item[The Journal of Mime Science Vol. 4 (used)]))
        use(1, $item[The Journal of Mime Science Vol. 4 (used)]);

//check for enough adv
if ( my_adventures() < 30 && get_property("questLTTQuestByWire") == "unstarted") abort("Not enough adventures!");
if ( get_property("questLTTQuestByWire") != "unstarted" )
    if ( my_adventures() < 1+(4-to_int(substring(get_property("questLTTQuestByWire"), 4)))*(9-to_int(get_property("lttQuestStageCount"))))
        abort("Not enough adventures!");

if ( get_property("questLTTQuestByWire") == "unstarted")
    clerk ();

cli_execute("ccs Telegram");
if ( !have_equipped($item[protonic accelerator pack]) ) equip($item[protonic accelerator pack]);
while ( get_property("questLTTQuestByWire") != "unstarted" ) {
    d = cli_execute("familiars.ash");
    //if boss is up, gear up
    if ( (get_property("questLTTQuestByWire") == "step3" && get_property("lttQuestStageCount") == 9) || (get_property("questLTTQuestByWire") == "step4" ) ) {
        familiar bjorni = my_bjorned_familiar();
        d = cli_execute("maximize spell damage, spell damage percent, myst, equip Rain-Doh green lantern, -tie");
        if ( can_equip($item[Staff of the Deepest Freeze]) && get_property("lttQuestName") == "Many Children")
           equip($item[Staff of the Deepest Freeze]);
        if ( my_hp() + 50 < my_maxhp() ) d = use_skill(1,$skill[Cannelloni Cocoon]);
        if ( my_mp() < 300 ){
            restore_mp( 300 - my_mp() );
        }
        if (have_effect($effect[Frigidalmatian])<1){
          d = use_skill(1,$skill[Frigidalmatian]);
        }
        if ( get_property("lttQuestName") == "Missing: Many Children" && my_mp() < 380 ){
                restore_mp(400);
        }
        adventure(1, to_location("Investigating a Plaintive Telegram"), "boss");
        d = cli_execute("fitting.ash");
        d = cli_execute("familiars.ash");
    }
    else adventure( 1, to_location("Investigating a Plaintive Telegram"), "mob" );
}
foreach key in $items[nugget of ticksilver, nugget of thicksilver, nugget of slicksilver, nugget of sicksilver, nugget of nicksilver, nugget of quicksilver, nugget of wicksilver, red-hot knucklebone, shuddering cow skull]{
put_shop(0,0,item_amount(key),key);
}

}
