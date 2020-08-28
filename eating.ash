int space(){
  return min(4, fullness_limit() - my_fullness());
}

item best_food(){
  item filler;
  switch( space() ){
    case 4:
      filler = $item[browser cookie];
      break;

    case 3:
      foreach yum in $items[insanely spicy bean burrito, insanely spicy enchanted bean burrito, insanely spicy jumping bean burrito, pumpkin pie]{
        if ( retrieve_item(1,yum) ){
          filler = yum;
          }
      }
      break;

    case 2:
      foreach yum in $items[hamburger, extra-flat panini, breakfast miracle]{
        if ( retrieve_item(1,yum) ){
          filler = yum;
          }
      }
      break;

    case 1:
      foreach yum in $items[actual tapas, tasty tart, sweet party mix]{
        if ( retrieve_item(1,yum) ){
          filler = yum;
          }
      }
      break;

    default:
      filler = $item[none];
  }
  return filler;
}

void main(){
  boolean d;
  item nomnom;
  foreach key in $items[time-spinner, milk of magnesium, pirate fork]{
    d = retrieve_item(1,key);
  }
  d = use(1,$item[milk of magnesium]);
  d = eat(1,$item[spaghetti breakfast]);
  d = eat(1,$item[pirate fork]);
  d = eat(1,$item[browser cookie]);
  repeat{
    nomnom = best_food();
    if ( contains_text(get_property("_timeSpinnerFoodAvailable"),nomnom.to_int().to_string()) ){
      d = cli_execute("timespinner eat "+nomnom.to_string());
    }
    else{
      d = eat(1,nomnom);
    }
  } until( space() == 0 || nomnom == $item[none]);
}
