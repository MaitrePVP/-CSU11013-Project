int currentScreen = 0; // 0 = home, 1 = results, 2 = info, 3 = snake

Button startButton;
Button infoButton;
Button quitButton;
Button backButton;
Button snakeButton;

boolean clickedAlessandro = false;
boolean clickedMusa = false;
boolean clickedAlex = false;
boolean clickedElijas = false;
boolean snakeUnlocked = false;

PFont mainFont;

void setup() {
  size(1200, 800);
  smooth(8);

  mainFont = createFont("Arial", 20, true);
  textFont(mainFont);

  textAlign(CENTER, CENTER);
  rectMode(CORNER);

  startButton = new Button(width/2 - 150, 320, 300, 60, "Start Exploring");
  infoButton  = new Button(width/2 - 150, 410, 300, 60, "Group Info");
  quitButton  = new Button(width/2 - 150, 500, 300, 60, "Exit");
  backButton  = new Button(40, 40, 160, 50, "Back to Home");
  snakeButton = new Button(width/2 - 120, 590, 240, 55, "Play Snake");

  initSnakeGame();
}

void draw() {
  background(235, 242, 250);

  if (currentScreen == 0) {
    drawHomeScreen();
  } else if (currentScreen == 1) {
    drawResultsScreen();
  } else if (currentScreen == 2) {
    drawInfoScreen();
  } else if (currentScreen == 3) {
    drawSnakeScreen();
  }
}

void drawHomeScreen() {
  fill(30, 60, 100);
  noStroke();
  rect(0, 0, width, 120);

  fill(255);
  textSize(36);
  text("Flight Data Visualisation", width/2, 50);

  textSize(18);
  text("CSU11013 Group Project", width/2, 90);

  fill(255);
  stroke(180);
  strokeWeight(2);
  rect(width/2 - 350, 180, 700, 450, 20);

  fill(40);
  textSize(28);
  text("Welcome", width/2, 230);

  textSize(16);
  text("Use this application to explore and visualise flight data.", width/2, 270);
  text("Choose an option below to begin.", width/2, 300);

  startButton.display();
  infoButton.display();
  quitButton.display();

  fill(80);
  textSize(14);
  text("Created by Group 39", width/2, height - 30);
}

void drawResultsScreen() {
  background(245);

  fill(30, 60, 100);
  noStroke();
  rect(0, 0, width, 100);

  fill(255);
  textSize(32);
  text("Results Screen", width/2, 50);

  fill(255);
  stroke(180);
  strokeWeight(2);
  rect(80, 150, 250, 500, 20);
  rect(370, 150, 750, 500, 20);

  fill(40);
  textSize(22);
  text("Controls", 205, 190);

  textSize(16);
  text("Filters and buttons", 205, 230);
  text("will go here.", 205, 260);

  textSize(22);
  text("Visualisation Area", 745, 190);

  textSize(16);
  text("Graphs, tables, and flight data", 745, 230);
  text("will be displayed here.", 745, 260);

  backButton.display();
}

void drawInfoScreen() {
  background(245);

  fill(30, 60, 100);
  noStroke();
  rect(0, 0, width, 120);

  fill(255);
  textSize(34);
  text("Group Information", width/2, 60);

  fill(255);
  stroke(180);
  strokeWeight(2);
  rect(width/2 - 350, 170, 700, 470, 20);

  fill(40);
  textSize(28);
  text("Group 39", width/2, 230);

  textSize(22);
  text("Team Members", width/2, 290);

  drawMemberName("Alessandro Caradonna", width/2, 350, clickedAlessandro);
  drawMemberName("Musa Irfan", width/2, 390, clickedMusa);
  drawMemberName("Alex Grigorita", width/2, 430, clickedAlex);
  drawMemberName("Elijas Sohlstrom", width/2, 470, clickedElijas);

  textSize(16);
  fill(80);
  text("There is a secret on this page, try to find it!", width/2, 530);
  text("CSU11013 Group Project - Flight Data Visualisation", width/2, 560);

  if (snakeUnlocked) {
    fill(20, 120, 60);
    textSize(18);
    text("Secret unlocked.", width/2, 600);
    snakeButton.display();
  }

  backButton.display();
}

void drawMemberName(String name, float x, float y, boolean clicked) {
  if (clicked) {
    fill(20, 140, 60);
  } else {
    fill(40);
  }

  textSize(20);
  text(name, x, y);
}

void mousePressed() {
  if (currentScreen == 0) {
    if (startButton.isMouseOver()) {
      currentScreen = 1;
    } else if (infoButton.isMouseOver()) {
      currentScreen = 2;
    } else if (quitButton.isMouseOver()) {
      exit();
    }
  } else if (currentScreen == 1) {
    if (backButton.isMouseOver()) {
      currentScreen = 0;
    }
  } else if (currentScreen == 2) {
    if (backButton.isMouseOver()) {
      currentScreen = 0;
      return;
    }

    checkNameClicks();

    if (snakeUnlocked && snakeButton.isMouseOver()) {
      currentScreen = 3;
      resetSnakeGame();
    }
  } else if (currentScreen == 3) {
    if (backButton.isMouseOver()) {
      currentScreen = 0;
    }
  }

  updateSnakeUnlock();
}

void keyPressed() {
  if (currentScreen == 3) {
    handleSnakeInput();
  }
}

void checkNameClicks() {
  if (isMouseOverText(width/2, 350, 280, 30)) {
    clickedAlessandro = true;
  } else if (isMouseOverText(width/2, 390, 180, 30)) {
    clickedMusa = true;
  } else if (isMouseOverText(width/2, 430, 200, 30)) {
    clickedAlex = true;
  } else if (isMouseOverText(width/2, 470, 220, 30)) {
    clickedElijas = true;
  }
}

void updateSnakeUnlock() {
  if (clickedAlessandro && clickedMusa && clickedAlex && clickedElijas) {
    snakeUnlocked = true;
  }
}

boolean isMouseOverText(float centerX, float centerY, float boxW, float boxH) {
  return mouseX >= centerX - boxW/2 &&
         mouseX <= centerX + boxW/2 &&
         mouseY >= centerY - boxH/2 &&
         mouseY <= centerY + boxH/2;
}
