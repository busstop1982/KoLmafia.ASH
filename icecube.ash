void main(int turns){
if (turns>=my_adventures()){
abort("not enough adv");
}
boolean d;
d = cli_execute("ccs iceCubes");
while ( have_effect($effect[Expert vacationer]) < turns && item_amount($item[exotic travel brochure])>0 ){
  use(1,$item[exotic travel brochure]);
}
for (int i=0;i<turns;i++){
d = cli_execute("familiars.ash");
adv1(455.to_location(),-1,"");
}
}
