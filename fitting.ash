boolean stat_gt(int x, stat check_me){
    return my_basestat( check_me ) >= x;
}

item fit_hat(){
    item hat;
    switch ( my_primestat() ){

    case ( $stat[moxie] ):
      if ( stat_gt(250, my_primestat() ) ){
        if (my_class() == $class[disco bandit]) hat = $item[covers-your-head];
        if (my_class() == $class[accordion thief]) hat = $item[zombie mariachi hat];
      }
      else if ( stat_gt(100, my_primestat()) ) hat = $item[noir fedora];
      else hat = $item[biker's hat];
      break;

    case ( $stat[mysticality] ):
      if ( stat_gt(250, my_primestat()) ){
        if (my_class() == $class[sauceror]) hat = $item[Thunkula's drinking cap];
        if (my_class() == $class[pastamancer]) hat = $item[mayor ghost's toupee];
      }
      else hat = $item[Amoon-Ra Cowtep's nemes];
      break;

    case ( $stat[muscle] ):
      if ( stat_gt(250, my_primestat()) ){
        if (my_class() == $class[seal clubber]) hat = $item[Great Wolf's headband];
        if (my_class() == $class[turtle tamer]) hat = $item[Unkillable Skeleton's skullcap];
      }
      else hat = $item[electrician's hardhat];
      break;

    default:
      hat = $item[iunion crown];
    }
    return hat;
}

item fit_pants(){
  if ( get_property("_pantsgivingFullness").to_int() < 2 ) return $item[pantsgiving];
  else if ( stat_gt(150,$stat[moxie]) ) return $item[jeans of loathing];
  else{
    if ( my_primestat() == $stat[mysticality]) return $item[the Archwizard's briefs];
    else if ( my_primestat() == $stat[moxie] ) return $item[leggings of the Spider Queen];
    else return $item[The Ghoul King's ghoulottes];
  }
}

item fit_shirt(){
  item out;
  foreach shirt in $items[sea salt scrubs, blessed rustproof +2 gray dragon scale mail]{
    if (can_equip(shirt)){
    out = shirt;
    break;
    }
  }
  return out;
}

item [slot] fit_acc(){
  item [slot] out;
  boolean b;
  out[$slot[acc3]] = $item[lucky gold ring];
  out[$slot[acc2]] = $item[Mr. Screege's spectacles];
  if ( get_property("_stinkyCheeseCount").to_int() < 100 ){
    if (!have_equipped($item[stinky cheese eye])) b = retrieve_item(1,$item[stinky cheese eye]);
    out[$slot[acc1]] = $item[stinky cheese eye];
  }
  else out[$slot[acc1]] = $item[time-twitching toolbelt];
  return out;
}

item fit_off(){
  if ( get_property("_stinkyCheeseCount").to_int() < 100 ) return $item[Kramco Sausage-o-Matic&trade;];
  else return $item[kol con 13 snowglobe];
}

item fit_back(){
  return $item[Buddy Bjorn];
  //if ( get_property("ghostLocation") != "" ) return $item[protonic accelerator pack];
  //else return $item[Buddy Bjorn];
}

item fit_weapon(){
  if (my_class() == $class[seal clubber]) return $item[brimstone bludgeon];
  return $item[fourth of may cosplay saber];
}

item [slot] outfit(){
  item [slot] out;
  item [slot] accs = fit_acc();
  out[$slot[hat]] = fit_hat();
  out[$slot[pants]] = fit_pants();
  out[$slot[shirt]] = fit_shirt();
  out[$slot[off-hand]] = fit_off();
  out[$slot[weapon]] = fit_weapon();
  out[$slot[back]] = fit_back();
  foreach key in accs{
    out[key] = accs[key];
  }
  return out;
}

void main(){
    boolean b;

    item [slot] clothes = outfit();
    foreach key in clothes{
      b = equip(key,clothes[key]);
    }

}
