//maybe use proxy record fields like familiar.drops_today or familiar.drops_limit
void main(){
    boolean d;
    familiar name;
    familiar dft_fam;
//default familiars:
    familiar dft_crown = $familiar[adorable seal larva];
    familiar dft_bjorn = $familiar[warbear drone];
    if (hippy_stone_broken()){
        dft_fam = $familiar[robortender];
    }
    else dft_fam = $familiar[intergnat];

    record fam {
        familiar who;
        string cdrop;
        int maxdrop;
        boolean crown;
    };
fam [int] mate;

    int [string, string] buddy;
    buddy ["Trick-or-Treating Tot", "_hoardedCandyDropsCrown"] = 3;
    buddy ["Garbage Fire", "_garbageFireDropsCrown"] = 3;
    buddy ["Optimistic Candle", "_optimisticCandleDropsCrown"] = 3;
    buddy ["Machine Elf", "_abstractionDropsCrown"] = 25;
    buddy ["Rogue Program", "_tokenDrops"] = 5;
    buddy ["Baby Sandworm", "_aguaDrops"] = 5;
    buddy ["Li'l Xenomorph", "_transponderDrops"] = 5;
    buddy ["Pair of Stomping Boots", "_bootStomps"] = 3;
    buddy ["Llama lama", "_gongDrops"] = 5;
    buddy ["Cat Burglar", "_catBurglarCharge"] = 10;
    buddy ["Fist turkey", "_turkeyBooze"] = 5;
    buddy ["Green Pixie", "_absintheDrops"] = 5;

    int i = 1;
    foreach key1, key2 in buddy{
        mate[i].who = key1.to_familiar();
        mate[i].cdrop = key2;
        mate[i].maxdrop = buddy[key1, key2];
        mate[i].crown = contains_text(key2, "Crown");
        i++;
    }

sort mate by value.maxdrop;

if ( have_equipped($item[crown of thrones]) ){
    foreach key in mate{
        if ( mate[key].crown && mate[key].cdrop.get_property().to_int() < mate[key].maxdrop){
        name = mate[key].who;
        break;
        }
    else name = dft_crown;
    }
    name.enthrone_familiar();
}

if ( have_equipped($item[buddy bjorn]) ){
    foreach key in mate{
        if ( mate[key].crown && mate[key].cdrop.get_property().to_int() < mate[key].maxdrop && my_enthroned_familiar()!=mate[key].who){
            name = mate[key].who;
            break;
        }
        else name = dft_bjorn;
    }
    name.bjornify_familiar();
}

    foreach key in mate{
        if ( !mate[key].crown && mate[key].cdrop.get_property().to_int() < mate[key].maxdrop ){
            name = mate[key].who;
            break;
        }
        else name = dft_fam;

    }
    if ( my_inebriety() == inebriety_limit() && my_familiar()==$familiar[stooper] ){
        name = my_familiar();
    }
    name.use_familiar();
}
