Table US_StateAreaData; // Den tabel som holder data'en
float totalArea = 0; // Det totale areal af alle arealerne
float[] stateAngles = new float[52]; // Holder alle staterme vinkler til cirkeldiagrammet (inder vinkle af den stats "pie peace")
color[] stateColor = new color[52]; // Holder alle staternes farver (test og digram)
String[] stateNames = new String[52]; // Holder alle staters navne

boolean isLoading = false; // State på om der indhentes data og dannet et diagram
boolean dataLoaded = false; // State på om data'en er blevet hentet

void setup() {
  // US_StateAreaData = loadTable("https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-areas.csv", "header");
  size(800, 800);
  
  textAlign(CENTER);
  
  //noLoop();
  smooth(8);
  
  noStroke();
  background(255);
  
  thread("loading"); // Starter med at klade loading();
  thread("getData"); // Efter kalder vi getData(); som henter data'en
}

void draw() {
  clear();
  background(255);
  
  // Så længde er hentes data og dannes diagram
  if (isLoading == true) {
    fill(0);
    textSize(100);
    text("Loading...", (width / 2), (height / 2));
  }
  
  // Når data'en er hentet kan vi oprette diagrammet
  if (dataLoaded == true && isLoading == true) {
    createPieChart();
  }
  
  // Når loading er falsk er data'en hentet og diagrammet dannet
  if (isLoading == false) {
    fill(0);
    text("Hver stats areal del af de sammlede areal", 150, 25);
    displayPieChart();
  }
}

// Sammlet funktion som kalder alle de nødevendige funktioner til at generere data til diagrammet
void createPieChart() {
  calTotalArea();
  calStateSize();
  getStateNames();
  
  isLoading = false; // Sætter det til false, da nu er det ikke mere der skal hentes eller dannes
}

// Sammlet funktion der viser diagrammet og navne under diagrammet
void displayPieChart() {
  pieChart(500, stateAngles);
  placeNames();
}

// Henter data'en
void getData() {
  US_StateAreaData = loadTable("https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-areas.csv", "header");
  dataLoaded = true; // Når data'en er blevet hentet ovenover vil vi sætte denne til true. Efter data'en nu er hentet
}

// Tager hver areal og udregnet det totale areal
void calTotalArea() {
  for(TableRow state : US_StateAreaData.rows()) {
    float area = state.getFloat("area (sq. mi)");
    totalArea += area;
  }
}

// Danner diagrammet ud fra de vinkler som "calStateSize" har udrenget og gemt i "stateAngels"
void pieChart(float diameter, float[] data) {
  float lastAngle = 0;
  for(int i = 0; i < data.length; i++){
    fill(stateColor[i]);
    arc(width/2, ((height/2) - 145), diameter, diameter, lastAngle, lastAngle + radians(data[i]));
    lastAngle += radians(data[i]);
  }
}

// Finder en stats inder vinkel i diagrammet
void calStateSize() {
  int stateNR = 0;
  for(TableRow state : US_StateAreaData.rows()) {
    float area = state.getFloat("area (sq. mi)");
    stateAngles[stateNR] = (area/totalArea) * 360;
    stateColor[stateNR] = color(random(255), random(255), random(255));
    stateNR++;
  }
}

// Indsætter hver states navn i arrayen
void getStateNames() {
  int stateNR = 0;
  for(TableRow state : US_StateAreaData.rows()) {
    String name = state.getString("state");
    stateNames[stateNR] = name;
    stateNR++;
  }
}

// Placere navne på alle stater under diagrammet og giver teksten den samme farve som staten har i diagrammet
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

// Denne funktioner angiver start status på "isLoading"
void loading() {
  isLoading = true;
}
