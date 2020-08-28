
string log( int what ){ // 1 = skill, 2 = times used, 3 = times req, 4 = monster
string output;
matcher m = create_matcher("Looks like you've cast (.+?) during (\\d+) of the required (\\d+) encounters with (?:a|an|some|the) (.+?)!", visit_url("questlog.php?which=1"));

  while (m.find()){
    output = m.group(what);
    }
  return output;
}

//find location
location where() {
string loc = visit_url("messages.php?box=Correspondence");
matcher m = create_matcher("look in (.*?)\\)", loc);
m.find();
if( m.group(1) == "The Orcish Frat House" ){
return 27.to_location();
}
else if ( m.group(1) == "The Junkyard" ){
return 154.to_location();
}
else return m.group(1).to_location();
}

//find the most common monster to ban
void banzors(monster bounty, location where){
  if ( get_property("_newYouQuestBan") != "" && get_property("_newYouQuestBan") != "none") return;
  float [monster] spawn_chance = appearance_rates(where);
  monster toban = $monster[none];
  float chance = 0;
  foreach key in spawn_chance {
    if ( spawn_chance[key] > chance && key != bounty && key != $monster[none]) {
      toban = key;
      chance = spawn_chance[key];
    }
  }
  set_property("_newYouQuestBan",toban);
}

string fight( int round, monster opp, string text) {
  if ( opp == get_property("_newYouQuestMonster").to_monster() ){
    if ( $effect[On the Trail].have_effect() < 1 && get_property("_newYouCanTO").to_boolean() == true)
      return "skill transcendent olfaction";
    if ( round == 1 )
      return get_property("_newYouQuestSkill").to_skill();
    else
      return get_ccs_action(round);
  }
  else {
    if ( opp == get_property("_newYouQuestBan").to_monster() && have_equipped($item[Pantsgiving]) && have_skill($skill[Talk about politics]) ){
      return "skill Talk about Polictics";
    }
    else
      if ( opp == get_property("_newYouQuestBan").to_monster() && have_skill($skill[Snokebomb]) ){
        return "skill snokebomb";
      }
    else
      return get_ccs_action(round);
  }
}

void main(){
if(get_property("_newYouQuestCompleted")==true)abort("You already did that today.");
location togo = where();
set_property("_newYouQuestLocation",togo);
banzors(get_property("_newYouQuestMonster").to_monster(), get_property("_newYouQuestLocation").to_location() );

if ( get_property("_newYouQuestMonster") == "" || get_property("_newYouQuestMonster") == "none" ){
  abort("Something buggered up - please set _newYouQuestMonster.");
}
if ( get_property("_newYouQuestSkill").to_skill() == $skill[none] ){
  abort("Something buggered up - please set _newYouQuestSkill.");
}

if ( get_property("_newYouQuestMonster").to_monster() == $monster[Lobsterfrogman] )
  abort ("Frogmen wanted - manual handling required.");
if ( get_property("_newYouQuestMonster").contains_text("duck") )
  abort ("Dooks!");
if ( get_property("_newYouQuestMonster") == "factory worker" )
  abort ("Volcano stuff wanted - manual handling required.");
if ( get_property("_newYouQuestMonster") == "Orcish Frat Boy" )
  abort ("Orcish stuff wanted - manual handling required.");
if ( get_property("_newYouQuestMonster").contains_text("ninja")){
  abort ("Ninja stuff wanted - manual handling required.");
}


boolean d;
if (item_amount($item[empty rain-doh can])<1 && retrieve_item(1, $item[can of rain-doh]) ) use(1, $item[can of rain-doh]);
if ( !retrieve_item(1, $item[porquoise-handled sixgun]) ) abort("no six-gun.");
if (get_property("_newYouQuestSharpensToDo") == 40)
if (!user_confirm("This will take 40 adventures! Continue?") )
{
abort("Wise choice.");
}
if ( togo == 122.to_location() && have_effect($effect[Ultrahydrated]) < 1 ){
d = cli_execute("set cloverProtectActive = false");
use(1, $item[disassembled clover]);
}
if (togo == 214.to_location() || togo == 215.to_location() || togo == 217.to_location() || togo == 218.to_location() || togo == 219.to_location() ){
set_property("_newYouCanTO",false);
}
else set_property("_newYouCanTO",true);
print("Casting "+"_newYouQuestSkill".get_property()+" against "+"_newYouQuestMonster".get_property()+" in the "+togo);
d = cli_execute("ccs 5 turns");
while (!get_property("_newYouQuestCompleted").to_boolean() && my_adventures() != 0){
d = cli_execute("BBS.ash");
if ( togo == $location[The Hidden Bowling Alley] && item_amount($item[bowling ball]) > 0) put_closet(item_amount($item[bowling ball]), $item[bowling ball]);
adventure(1, togo, "fight");
}
if ( !get_property("cloverProtectActive").to_boolean() ) set_property("cloverProtectActive", "true");
print("All done!");

}
