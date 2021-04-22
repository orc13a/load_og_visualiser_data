Table US_StateAreaData;
float totalArea = 0;
float[] stateAngles = new float[52];
color[] stateColor = new color[52];
String[] stateNames = new String[52];
PVector vectorA;
PVector vectorB;


void setup(){
  US_StateAreaData = loadTable("https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-areas.csv", "header");
  size(800, 800);
  calTotalArea();
  calStateSize();
  getStateNames();
  //noStroke();
  background(random(255), random(255), random(255));
  pieChart(750, stateAngles);
  vectorA = new PVector(400, 400);
  //vectorB = new PVector(
}

void draw(){   
  line(400,0,vectorA.x, vectorA.y);
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
    fill(stateColor[i]);
    arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle + radians(data[i]));
    lastAngle += radians(data[i]);
  }
}

void calStateSize(){
  int stateNR = 0;
  for(TableRow state : US_StateAreaData.rows()){
    float area = state.getFloat("area (sq. mi)");
    stateAngles[stateNR] = (area/totalArea)*360;
    stateColor[stateNR] = color(random(255), random(255), random(255));
    stateNR++;
  }
}

void getStateNames(){
  int stateNR = 0;
  for(TableRow state : US_StateAreaData.rows()){
    String name = state.getString("state");
    stateNames[stateNR] = name;
    stateNR++;
  }
}

void placeNames(){
  
}
