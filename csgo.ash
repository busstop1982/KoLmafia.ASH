
void main(int day){
  boolean b;
  void v;
  if (day == 1){
    foreach stone in $items[porquoise, hamethyst, baconstone]{
      b = autosell(stone.item_amount(),stone);
    }
    b = cli_execute("Detective Solver.ash");
    foreach key in $items[codpiece, cool jelly donut, cold-filtered water]{
      b = cli_execute("acquire "+key);
    }
    b = cli_execute("garden pick");
    b = use(1,$item[codpiece]);
    b = use_skill(1,$skill[summon sugar sheets]);
    b = use(8,$item[bubblin' crude]);
    b = autosell(1,$item[oil cap]);
    b = cli_execute("horsery dark");
    b = cli_execute("briefcase enchantment spell hot adventures");
    if ( cli_execute("numberology 14") ){
      b = autosell(14,$item[moxie weed]);
    }
    foreach key in $items[toy accordion, Dramatic&trade; range, fortune cookie, li'l unicorn costume]{
      b = buy(1,key);
    }
    b = use(1,$item[Dramatic&trade; range]);
    b = use(1,$item[astral six-pack]);
    b = cli_execute("fold makeshift garbage shirt");
    b = cli_execute("terminal educate extract.edu");
    b = cli_execute("terminal educate turbo.edu");
    b = cli_execute("terminal enquiry stats.enq");
    b = use_skill(1,$skill[sauce contemplation]);
    b = use_skill(1,$skill[the magical mojomuscular melody]);
    visit_url("place.php?whichplace=realm_fantasy&action=fr_initcenter");
    run_choice(2);
    //pantogram
    visit_url("inv_use.php?pwd=&which=f-1&whichitem=9573");
    visit_url("choice.php?whichchoice=1270&pwd&option=1&m=2&e=1&s1=-2,0&s2=-2,0&s3=-1,0",
    true, false);
    b = maximize("mp, equip makeshift garbage shirt", false);
    b = cli_execute("shower mp");
    b = cli_execute("pool 3");
    v = print_html("Ready for day one!");
  }
  else if (day == 2){
    //get pantogram pants
    visit_url("inv_use.php?pwd=&which=f-1&whichitem=9573");
    visit_url("choice.php?whichchoice=1270&pwd&option=1&m=2&e=1&s1=-1,0&s2=-1,0&s3=-1,0",
    true, false);
    //get warrior hat from FR
    visit_url("place.php?whichplace=realm_fantasy&action=fr_initcenter");
    run_choice(1);
    b = cli_execute("breakfast");
    b = cli_execute("garden pick");
//    b = cli_execute("horsery pale horse");
    foreach key in $items[fish hatchet, blunt cat claw]{
      b = cli_execute("acquire "+key);
    }
    b = cli_execute("acquire 3 cold-filtered water");
    b = cli_execute("bastille barbecue brutalist cannon");
    b = cli_execute("terminal extrude food");
    b = cli_execute("terminal extrude booze");
    b = cli_execute("terminal extrude booze");
    b = cli_execute("briefcase collect");
    b = cli_execute("briefcase enchantment weapon hot -combat");
    b = use(1,$item[milk of magnesium]);
    b = eat(1,$item[sausage without a cause]);
    b = eat(1,$item[blunt cat claw]);
    b = cli_execute("pool 1");
    b = maximize("weapon damage",false);
    v = print_html("Ready for day two!");
  }
  else{print_html("please enter day of run");}
}
