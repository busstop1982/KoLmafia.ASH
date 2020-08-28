void main(){
int meaties = my_meat();
boolean [item, int] stuff;
matcher m = create_matcher("class\=\"ircm\"\>(.+?)\<\/b\>", visit_url("inventory.php?which=f5&pwd") );
while (m.find()){
    stuff [m.group(1).to_item(), m.group(1).to_item().item_amount()] = m.group(1).to_item().usable;
}
    foreach key, num in stuff{
        if (stuff[key,num]) use(num, key);
        else {
            autosell(num, key);
            print("Sold "+num+" "+key.to_string());
        }
    }
int newmeat=my_meat()-meaties;
print("Made "+newmeat+" meat selling stuffs.");
}
