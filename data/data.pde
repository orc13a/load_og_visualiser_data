Table US_StateAreaData;
float totalArea = 0;

void setup(){
  US_StateAreaData = loadTable("https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-areas.csv", "header");
  
  calTotalArea();
}

void draw(){
}

void calTotalArea(){
  for(TableRow state : US_StateAreaData.rows()){
    float area = state.getFloat("area (sq. mi)");
    totalArea += area;
  }
}
