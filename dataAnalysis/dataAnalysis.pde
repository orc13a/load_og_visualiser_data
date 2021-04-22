Table US_StateAreaData;
float totalArea = 0;
float[] stateAngles = new float[52];

void setup(){
  US_StateAreaData = loadTable("https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-areas.csv", "header");
  size(800, 800);
  calTotalArea();
  calStateSize();
  noStroke();
  noLoop();
}

void draw(){
  background(100,50,50);
   pieChart(750, stateAngles);
}

void calTotalArea(){
  for(TableRow state : US_StateAreaData.rows()){
    float area = state.getFloat("area (sq. mi)");
    totalArea += area;
  }
}

void pieChart(float diameter, float[] data){
  float lastAngle = 0;
  for(int i = 0; i < data.length; i++){
    float gray = map(i, 0, data.length, 0, 255);
    fill(gray);
    arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle + radians(data[i]));
    lastAngle += radians(data[i]);
  }
}

void calStateSize(){
  int stateNR = 0;
  for(TableRow state : US_StateAreaData.rows()){
    float area = state.getFloat("area (sq. mi)");
    stateAngles[stateNR] = (area/totalArea)*360;
    stateNR++;
  }
}
