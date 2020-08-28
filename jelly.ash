string fight ( int round, monster opp, string text ){
    return get_ccs_action(round);
}

void main(int jellies)
{
    if ( jellies <= "_spaceJellyfishDrops".get_property().to_int() ){
      abort("Already got that many jellies today!");
    }
    boolean d;
    location togo;
    familiar now = my_familiar();
    d = cli_execute("familiar space jellyfish");
    d = cli_execute("ccs jelly like stench");
    d = cli_execute("goal clear");
    if ( "sideDefeated".get_property() == "hippies" || "sideDefeated".get_property() == "neither"){
        togo = "hippy camp (bombed back to the stone age)".to_location();
    }
    else togo = "hippy camp".to_location();
    int current_jelly = item_amount($item[stench jelly]);

    while ( jellies > "_spaceJellyfishDrops".get_property().to_int() && my_adventures()>0 ){
      adventure(1, togo, "fight");
    }
    use_familiar(now);
    print_html("Gots jellies!");
}
