void main(){
boolean d;
buffer b;
int which_quest;

if (my_adventures()<50){
    abort("Not enough adventures");
}
b = visit_url( "place.php?whichplace=airport_hot&action=airport4_questhub" );
int[item] questtokens;
for( int i = 1; i <= 3; i++ ) {
    questtokens[ get_property( "_volcanoItem" + i ).to_item() ] = i;
}
if (questtokens contains $item[the tongue of Smimmons]){
    set_property("choiceAdventure1094",1);
    set_property("_volcanoQuestItem","the tongue of Smimmons");
    which_quest = questtokens[$item[the tongue of Smimmons]];
}
else if (questtokens contains $item[Raul's guitar pick]){
    set_property("choiceAdventure1094",2);
    set_property("_volcanoQuestItem","Raul's guitar pick");
    which_quest = questtokens[$item[Raul's guitar pick]];
}
else if (questtokens contains $item[Pener's crisps]){
    set_property("choiceAdventure1094",3);
    set_property("_volcanoQuestItem","Pener's crisps");
    which_quest = questtokens[$item[Pener's crisps]];
}
else if (questtokens contains $item[signed deuce]){
    set_property("choiceAdventure1094",4);
    set_property("_volcanoQuestItem","signed deuce");
    which_quest = questtokens[$item[signed deuce]];
}
else{
abort("No kisses today");
}
d = cli_execute("ccs smoochin");
if (my_basestat($stat[mysticality])>=200){
d = equip($slot[weapon],$item[Staff of the Deepest Freeze]);
}
else if (my_basestat($stat[muscle])>=150){
    d = equip($slot[weapon],$item[stick-knife of loathing]);
}
else if (my_basestat($stat[mysticality])>=125){
d = equip($slot[weapon],$item[Staff of Simmering Hatred]);
}
d = equip($slot[acc1],$item[stinky fannypack]);
d = equip($slot[acc2],$item[stinky fannypack]);
d = equip($slot[acc3],$item[stinky fannypack]);
while (have_effect($effect[Expert Vacationer])<50 && item_amount($item[exotic travel brochure])>0){
    use(1,$item[exotic travel brochure]);
}
while (my_mp()<300){
    restore_mp(50);
}
while (have_effect($effect[Intimidating Mien])<40){
    use_skill(1,$skill[Intimidating Mien]);
}
while (have_effect($effect[Takin' it Greasy])<30){
    use_skill(1,$skill[Grease Up]);
}
while (get_property("_volcanoItem"+which_quest).to_item().item_amount()<1){
adv1(448.to_location(),-1,"");
d = cli_execute("familiars.ash");
}
b = visit_url( "place.php?whichplace=airport_hot&action=airport4_questhub" );
run_choice(which_quest);
d = cli_execute("fitting.ash");
}
