Table US_StateAreaData;
float totalArea = 0;
float[] stateAngles = new float[52];
color[] stateColor = new color[52];
String[] stateNames = new String[52];

boolean isLoading = true;
boolean pieChartCreated = false;

void setup() {
  // US_StateAreaData = loadTable("https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-areas.csv", "header");
  size(800, 800);
  
  textAlign(CENTER);
  
  noLoop();
  
  noStroke();
  // background(random(255), random(255), random(255));
  background(255);
  
  thread("loading");
  //thread("createPieChart");
  //loading();
  //createPieChart();
}

void draw() {
  //thread("loading");
  //thread("createPieChart");
  //loading();
  //createPieChart();
  
  if (isLoading == false) {
    createPieChart();
  }
}

void createPieChart() {
  //getData();
  
  calTotalArea();
  calStateSize();
  getStateNames();
  pieChart(500, stateAngles);
  placeNames();
  
  isLoading = false;
  pieChartCreated = true;
}

void getData() {
  US_StateAreaData = loadTable("https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-areas.csv", "header");
}

void calTotalArea() {
  for(TableRow state : US_StateAreaData.rows()) {
    float area = state.getFloat("area (sq. mi)");
    totalArea += area;
  }
}

void pieChart(float diameter, float[] data) {
  float lastAngle = 0;
  for(int i = 0; i < data.length; i++){
    fill(stateColor[i]);
    arc(width/2, ((height/2) - 145), diameter, diameter, lastAngle, lastAngle + radians(data[i]));
    lastAngle += radians(data[i]);
  }
}

void calStateSize() {
  int stateNR = 0;
  for(TableRow state : US_StateAreaData.rows()) {
    float area = state.getFloat("area (sq. mi)");
    stateAngles[stateNR] = (area/totalArea)*360;
    stateColor[stateNR] = color(random(255), random(255), random(255));
    stateNR++;
  }
}

void getStateNames() {
  int stateNR = 0;
  for(TableRow state : US_StateAreaData.rows()) {
    String name = state.getString("state");
    stateNames[stateNR] = name;
    stateNR++;
  }
}

void placeNames() {
  int colX = 80;
  int rowY = 530;
  
  textSize(14);
  
  for (int i = 0; i < stateNames.length; i++) {
    String name = stateNames[i];
    
    if (i % 9 == 0) {
      if (i != 0) {
        colX += 125;
      }
      rowY = 530;
    }
    
    if (i % 9 != 0) {
      rowY += 30;
    }
    
    fill(stateColor[i]);
    text(name, colX, rowY);
  }
}

void loading() {  
  if (isLoading == true) {
    fill(0);
    textSize(100);
    text("Loading...", (width / 2), (height / 2));
    
    getData();
  } 
}
