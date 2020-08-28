boolean testing = true;

int rand(int lowerBound, int upperBound)
{
    return (lowerBound + random(upperBound - lowerBound + 1));
}

string mark_the_spot(string page){
    string output;
    string [int,int] foo = group_string(page,"(\\d+),(\\d+)");
    output = foo[0][1];
    output += ",";
    output += foo[0][2];

    return output;
}

boolean combBeach(boolean onlyFree)
{
    string page = visit_url("main.php?comb=1", false);
    string beach_page;
    if(onlyFree && !contains_text(page, "free walks down the beach")) {
        visit_url("choice.php?whichchoice=1388&option=5");
        return false;
    }
    string the_spot;
    int beach = rand(1,10000);
    int row = rand(5,10); //high tide: 5-10; low: 4-10
    int col = rand(0,8);
    beach_page = visit_url("choice.php?whichchoice=1388&option=1&minutes=" + beach);
    if (contains_text(beach_page,"whale")){
        abort("Whale!");
    }
    if (contains_text(beach_page,"with a twinkle")){
        print_html("twinkle!");
        int stop = index_of(beach_page,"rough sand with a twinkle");
        the_spot = mark_the_spot(substring(beach_page,stop-40,stop));
    }
    else {
        the_spot = row + "," + ((beach * 10) - col);
    }
    visit_url("choice.php?whichchoice=1388&option=4&coords=" + the_spot);
    visit_url("choice.php?whichchoice=1388&option=5");

    return true;
}

void main(int advToSpend)
{
    if(item_amount($item[Beach Comb]) == 0) {
        abort("You don't have a beach comb!");
    }

    //burn through all free turns
    while(combBeach(true)) {}

    int i = 0;

    while(i < advToSpend) {
        if(my_adventures() == 0) {
            abort("You don't have any more turns!");
        }

        combBeach(false);
        i += 1;
    }
    print_html("Done combing.");
}
