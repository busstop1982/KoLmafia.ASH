string fight(int round, monster opp, string text){
    if ( round==0 ){
        if ( opp == 1861.to_monster() ) return "item abstraction: thought, rain-doh blue balls";
        if ( opp == 1860.to_monster() ) return "item abstraction: action, rain-doh blue balls";
        if ( opp == 1859.to_monster() ) return "item abstraction: sensation, rain-doh blue balls";
    }
    if ( round==1 ){
        return "skill sing along";
    }
    if ( my_primestat()==$stat[moxie] && !will_usually_miss() ) return "attack";
    else return "skill saucegeyser";
}

void main(){
    boolean d;
    if ( item_amount($item[rain-doh blue balls])<0 ){
        d = retrieve_item(1,$item[can of rain-doh]);
        d = use(1,$item[can of rain-doh]);
    }
    familiar boo = my_familiar();
    familiar bjorn = my_bjorned_familiar();
    if (bjorn == $familiar[machine elf]){
        d = bjornify_familiar($familiar[warbear drone]);
    }
    d = use_familiar($familiar[machine elf]);
    while ( "_machineTunnelsAdv".get_property()!=5 ){
        adv1(458.to_location(),-1,"fight");
    }
    d = cli_execute("familiars.ash");
}
