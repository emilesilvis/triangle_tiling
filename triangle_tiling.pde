int rows = 15;
int columns = 15;
float cellWidth;
float cellHeight;
float cellPadding = 6;
float margin = 20;
float deformOffset = 1.5;
float triangleSpacing = 3;
int[][] grid = new int[rows][columns];

void setup() {
  size(600, 600);
  pixelDensity(2);
  background(255);
  cellWidth = (width/columns) - (margin*2/columns);
  cellHeight = (height/rows) - (margin*2/rows);

  //populate grid with 1s
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = 1;
    }
  }

  //populate grid with odds
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      float r = random(1);
      if (r < 0.3 && grid[i][j] != 0 && i < (columns-1) && grid[i+1][j] == 1) { // sideways rect
        grid[i][j] = 2;
        grid[i+1][j] = 0;
      } else if (r < 0.6 && grid[i][j] != 0 && j < (rows-1) && grid[i][j+1] == 1) { // standing rect
        grid[i][j] = 3;
        grid[i][j + 1] = 0;
      } else if (r < 0.8 && grid[i][j] != 0 && i < (columns-1) && j < (rows-1) && grid[i+1][j] == 1 && grid[i][j+1] == 1 && grid[i + 1][j + 1] == 1) { // big square
        grid[i][j] = 4;
        grid[i+1][j] = 0;
        grid[i][j + 1] = 0;
        grid[i + 1][j + 1] = 0;
      } else { // small square
        // noop
      }
    }
  }

  translate(margin, margin);
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      float x = (i * cellWidth);
      float y = (j * cellHeight);

      float startX = x + cellPadding;
      float startY = y + cellPadding;
      float shortWidth = x + cellWidth;
      float shortHeight = y + cellHeight;
      float longWidth = x + cellWidth * 2;
      float longHeight = y + cellHeight * 2;

      if (grid[i][j] == 1) {
        drawTriangles(startX, startY, shortWidth, startY, shortWidth, shortHeight, startX, shortHeight);
      } else if (grid[i][j] == 2) {
        drawTriangles(startX, startY, longWidth, startY, longWidth, shortHeight, startX, shortHeight);
      } else if (grid[i][j] == 3) {
        drawTriangles(startX, startY, shortWidth, startY, shortWidth, longHeight, startX, longHeight);
      } else if (grid[i][j] == 4) {
        drawTriangles(startX, startY, longWidth, startY, longWidth, longHeight, startX, longHeight);
      }
    }
  }

  noLoop();
}

void drawTriangles(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float triangleOffset1 = random(triangleSpacing*4);
  float triangleOffset2 = random(triangleSpacing*4);

  if(random(1) < 0.5) {
    // fill 1
    filledTriangle(x1 + triangleSpacing + triangleOffset1 + random(-deformOffset, deformOffset), y1 + random(-deformOffset, deformOffset), x2 + random(-deformOffset, deformOffset), y2 + random(-deformOffset, deformOffset), x3 + random(-deformOffset, deformOffset), y3 + random(-deformOffset, deformOffset));
    // border 1
    emptyTriangle(x1 + triangleSpacing + triangleOffset1 + random(-deformOffset, deformOffset), y1 + random(-deformOffset, deformOffset), x2 + random(-deformOffset, deformOffset), y2 + random(-deformOffset, deformOffset), x3 + random(-deformOffset, deformOffset), y3 + random(-deformOffset, deformOffset));
    //fill 2
    filledTriangle(x4 + random(-deformOffset, deformOffset), y4 + random(-deformOffset, deformOffset), x3 - triangleSpacing - triangleOffset2 + random(-deformOffset, deformOffset), y3 + random(-deformOffset, deformOffset), x1 + random(-deformOffset, deformOffset), y1 + random(-deformOffset, deformOffset));
    //border 2
    emptyTriangle(x4 + random(-deformOffset, deformOffset), y4 + random(-deformOffset, deformOffset), x3 - triangleSpacing - triangleOffset2 + random(-deformOffset, deformOffset), y3 + random(-deformOffset, deformOffset), x1 + random(-deformOffset, deformOffset), y1 + random(-deformOffset, deformOffset));
  } else {
    //fill1 
    filledTriangle(x1 + random(-deformOffset, deformOffset), y1 + random(-deformOffset, deformOffset), x2 - triangleSpacing - triangleOffset2 + random(-deformOffset, deformOffset), y2 + random(-deformOffset, deformOffset), x4 + random(-deformOffset, deformOffset), y4 + random(-deformOffset, deformOffset));
    //border1
    emptyTriangle(x1 + random(-deformOffset, deformOffset), y1 + random(-deformOffset, deformOffset), x2 - triangleSpacing - triangleOffset2 + random(-deformOffset, deformOffset), y2 + random(-deformOffset, deformOffset), x4 + random(-deformOffset, deformOffset), y4 + random(-deformOffset, deformOffset));
    //fill2
    filledTriangle(x4 + triangleSpacing + triangleOffset1 + random(-deformOffset, deformOffset), y4 + random(-deformOffset, deformOffset), x3 + random(-deformOffset, deformOffset), y3 + random(-deformOffset, deformOffset), x2 + random(-deformOffset, deformOffset), y2 + random(-deformOffset, deformOffset));
    //border2
    emptyTriangle(x4 + triangleSpacing + triangleOffset1 + random(-deformOffset, deformOffset), y4 + random(-deformOffset, deformOffset), x3 + random(-deformOffset, deformOffset), y3 + random(-deformOffset, deformOffset), x2 + random(-deformOffset, deformOffset), y2 + random(-deformOffset, deformOffset));
  }
}

void filledTriangle(float x1, float y1, float x2, float y2, float x3, float y3) {
  noStroke();
  fill(randomColour());
  triangle(x1, y1, x2, y2, x3, y3);
}

void emptyTriangle(float x1, float y1, float x2, float y2, float x3, float y3) {
  noFill();
  stroke(80);
  strokeWeight(1.25);
  strokeJoin(ROUND);
  triangle(x1, y1, x2, y2, x3, y3);
}

color randomColour() {
  color[] colours = {
    color(#ffac81),
    color(#ff928b),
    color(#247ba0),
    color(#efe9ae),
    color(#cdeac0)
  };

  return colours[int(random(colours.length))];
}
