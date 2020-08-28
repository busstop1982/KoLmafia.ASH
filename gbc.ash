string fight( int round, monster opp, string text ){
    if ( opp == $monster[gingerbread tech bro] )
    return "skill licorice rope";
    return get_ccs_action(round);
}
void main(){
    string page;
    boolean d = cli_execute("ccs 5 turns");
    boolean clock = get_property("_gingerbreadClockAdvanced").to_boolean(); //clock used = true
//get_property("_gingerbreadCityTurns").to_int() //"turns" spent - NC counts
    if ( !clock ){
        page = to_location("civic center").to_url().visit_url();
        string [int] cho = available_choice_options();
        foreach key in cho{
            if ( contains_text(cho[key], "set the") ) run_choice(key);
        }
    }
    while ( get_property("_gingerbreadCityTurns").to_int()+5 < 9 ){
        d = cli_execute("BBS.ash");
        adventure(1, $location[Gingerbread Upscale Retail District], "fight");
    }
    if ( get_property("_gingerbreadCityTurns").to_int()+5 == 9){
    page = to_location("Gingerbread Train Station").to_url().visit_url();
    string [int] cho = available_choice_options();
    foreach key in cho{
        if ( contains_text(cho[key], "in the seat") ) run_choice(key);
    }
    }
    while ( get_property("_gingerbreadCityTurns").to_int()+5 < 19 ){
        d = cli_execute("BBS.ash");
        adventure(1, $location[Gingerbread Upscale Retail District], "fight");
    }
if ( get_property("_gingerbreadCityTurns").to_int()+5 == 19){
    d = outfit("Gingerbread Best");
    page = to_location("upscale retail district").to_url().visit_url();
    string [int] cho = available_choice_options();
    foreach key in cho{
        if (contains_text((cho[key]), "Go into the gallery") ) run_choice(key);
    }
    cho = available_choice_options();
    foreach key in cho{
        if ( contains_text((cho[key]), "sculpture") ) run_choice(key);
    }
    print("Candies and chocolate acquired!");
}
d = put_closet(item_amount($item[swizzler]),$item[swizzler]);
d = put_shop(0,0,$item[Ultra Mega Sour Ball]);
if ( item_amount($item[gingerbeard])>1 ){
    d = put_shop(0,0,item_amount($item[gingerbeard])-1,$item[gingerbeard]);
}
d = cli_execute("fitting.ash");
}
//(clock ->) 3 turns -> Train NC (open sewers/candy) -> 9 turns (sewers/retail) -> Retail NC (ginger outfit -> drink)
