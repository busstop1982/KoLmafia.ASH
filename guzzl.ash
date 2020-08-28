item sp_it(location loc){
  item out;
  switch ( loc ){
    case (151.to_location()):
    case (152.to_location()):
    case (153.to_location()):
      if(have_effect($effect[Absinthe-Minded])<9) out = $item[tiny bottle of absinthe];
      else out = $item[none];
      break;
    case (265.to_location()):
    case (266.to_location()):
      if(have_effect($effect[Transpondent])<9) out = $item[transporter transponder];
      else out = $item[none];
      break;
    case (225.to_location()):
      if(have_effect($effect[Down the Rabbit Hole])<9) out = $item[&quot;DRINK ME&quot; potion];
      else out = $item[none];
    default:
      out = $item[none];
  }
  return out;
}

item sp_eq(location loc){
  item out;
  switch ( loc ){
    case ($location[the f'c'le]):
    case ($location[the poop deck]):
    case ($location[belowdecks]):
      out = $item[pirate fledges];
      break;
    case ($location[8-bit realm]):
      out = $item[continuum transfunctioner];
      break;
    case ($location[inside the palindome]):
      out = $item[talisman o' namsilat];
      break;
    default:
      out = $item[none];
  }
  return out;
}

void main(){
  if ( get_property("questGuzzlr").to_string() == "unstarted" ) abort("No current client.");
  boolean b;
  void d;
  if ( !get_property("hasCocktailKit").to_boolean() && retrieve_item(1,$item[Queue Du Coq cocktailcrafting kit])) b = use($item[Queue Du Coq cocktailcrafting kit]);
  if (contains_text(visit_url("questlog.php?which=1"),"personalized Guzzlr cocktail") && item_amount($item[buttery boy]) < 1){
    craft("cocktail",1,$item[dish of clarified butter],$item[Guzzlr cocktail set]);
  }
  item quest_booze = get_property("guzzlrQuestBooze").to_item();
  if (!retrieve_item(1,quest_booze) && !buy(1,quest_booze)){
    abort("Can't get the proper booze.");
  }
  location loc = get_property("guzzlrQuestLocation").to_location();

  string maxxer = "maximize combat, outfit guzzlr uniform, equip fourth of may cosplay saber, equip lucky gold ring";
  b = cli_execute("ccs 5 turns");
  if ( get_property("_stinkyCheeseCount").to_int() < 100 ) maxxer += ", equip stinky cheese eye";
  item acc_eq = sp_eq(loc);
  if ( sp_it(loc) != $item[none]) b = use(1,sp_it(loc));
  if ( acc_eq != $item[none]) maxxer += ", equip "+acc_eq.to_string();
  b = cli_execute(maxxer);
  d = set_location(loc);
  while ( (get_property("questGuzzlr").to_string() == "started" ||  get_property("questGuzzlr").to_string() == "step1") && my_adventures() > 0 ){
    foreach key in $strings["musk of the moose", "Carlweather's Cantata of Confrontation"]{
        if ( have_effect(key.to_effect()) < 5 ) use_skill(1,key.to_skill());
    }
    b = adv1(loc,-1,"");
    b = cli_execute("familiars.ash");
  }
  b = cli_execute("fitting.ash");
}
