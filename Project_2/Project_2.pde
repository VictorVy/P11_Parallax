PImage cherry;

color black = 0;
color blue = #2121ff;
color red = #fe0c0b;
color yellow = #ffff00;
color pink = #fab9b0;

PVector origin = new PVector(0, 0);
float rotation = 0;

int mtnResetCheck = 1000;

int mtn1Width = 175;
int mtn1Height = 250;

int mtn1Speed = 3;
float mtn1YSpeed = 0.5;
int mtn1YMin = 150;
int mtn1YMax = 200;
int mtn1Reset = -175;

int mtn1AX = mtn1Reset;
int mtn1BX = 100;
int mtn1CX = 400;
int mtn1DX = 700;
int mtn1AY = 175;
int mtn1BY = 175;
int mtn1CY = 175;
int mtn1DY = 175;

int mtn2Width = 200;
int mtn2Height = 200;

int mtn2Speed = 5;
float mtn2YSpeed = 0.25;
int mtn2YMin = 275;
int mtn2YMax = 300;
int mtn2Reset = -200;

int mtn2AX = mtn2Reset;
int mtn2BX = 200;
int mtn2CX = 600;
int mtn2AY = 275;
int mtn2BY = 275;
int mtn2CY = 275;

float pmX = 500;
int pmY = 405;
boolean pmOpen;
boolean pmRight;

int coinXReset = -10;
int coinX = coinXReset;
int coinY = pmY;
int coinCount;

float robotXOrigin = 0;
float robotYOrigin = 0;
float robotX = -90;
float robotY = 225;
boolean robotFlip;
boolean robotUp;

Mountain mountain1;
Mountain mountain2;

void setup()
{
  size(800, 600);
  
  cherry = loadImage("pacman cherry.png");
  cherry.resize(60, 60);
  
  mountain1 = new Mountain(mtn1Width, mtn1Height, mtn1Speed, mtn1YSpeed, mtn1Reset, mtnResetCheck, mtn1AY, mtn1BY, mtn1CY, mtn1DY, mtn1AX, mtn1BX, mtn1CX, mtn1DX);
  mountain2 = new Mountain(mtn2Width, mtn2Height, mtn2Speed, mtn2YSpeed, mtn2Reset, mtnResetCheck, mtn2AY, mtn2BY, mtn2CY, mtn2AX, mtn2BX, mtn2CX);
  
  pmOpen = true;
  pmRight = true;
  
  coinCount = 0;
  
  robotFlip = false;
}

void draw()
{
  background(black);
  
  robotDraw();
  
  mountain1.mtnDraw(mountain1.count);
  mountain1.mtnUpdate();
  mountain1.mtnBounce(mtn1YMin, mtn1YMax, mtn1YSpeed);
  mountain1.mtnReset();
  
  mountain2.mtnDraw(mountain2.count);
  mountain2.mtnUpdate();
  mountain2.mtnBounce(mtn2YMin, mtn2YMax, mtn2YSpeed);
  mountain2.mtnReset();
  
  ground();
  
  coinDraw();
  
  pmDraw();
}

class Mountain
{
  int mtnWidth;
  int mtnHeight;

  int mtnSpeed;
  float mtnYSpeed;
  int mtnReset;
  int mtnResetCheck;

  float mtnAY;
  float mtnBY;
  float mtnCY;
  float mtnDY;
  int mtnAX;
  int mtnBX;
  int mtnCX;
  int mtnDX;
  
  int count;
  
  boolean down;
  
  public Mountain(int mtnWidth, int mtnHeight, int mtnSpeed, float mtnYSpeed, int mtnReset, int mtnResetCheck, float mtnAY, float mtnBY, float mtnCY, float mtnDY, int mtnAX, int mtnBX, int mtnCX, int mtnDX)
  {
    this.mtnWidth = mtnWidth;
    this.mtnHeight = mtnHeight;
    this.mtnSpeed = mtnSpeed;
    this.mtnYSpeed = mtnYSpeed;
    this.mtnReset = mtnReset;
    this.mtnResetCheck = mtnResetCheck;
    
    this.mtnAY = mtnAY;
    this.mtnBY = mtnBY;
    this.mtnCY = mtnCY;
    this.mtnDY = mtnDY;
    this.mtnAX = mtnAX;
    this.mtnBX = mtnBX;
    this.mtnCX = mtnCX;
    this.mtnDX = mtnDX;
    
    count = 4;
    
    down = true;
  }
  public Mountain(int mtnWidth, int mtnHeight, int mtnSpeed, float mtnYSpeed, int mtnReset, int mtnResetCheck, int mtnAY, int mtnBY, int mtnCY, int mtnAX, int mtnBX, int mtnCX)
  {
    this.mtnWidth = mtnWidth;
    this.mtnHeight = mtnHeight;
    this.mtnSpeed = mtnSpeed;
    this.mtnYSpeed = mtnYSpeed;
    this.mtnReset = mtnReset;
    this.mtnResetCheck = mtnResetCheck;
    
    this.mtnAY = mtnAY;
    this.mtnBY = mtnBY;
    this.mtnCY = mtnCY;
    this.mtnAX = mtnAX;
    this.mtnBX = mtnBX;
    this.mtnCX = mtnCX;
    mtnDY = 0;
    mtnDX = 0;
    
    count = 3;
    
    down = true;
  }
  
  void mtnDraw(int count) //draws mountains
  {
    stroke(blue);
    strokeWeight(4);
    fill(black);
    
    rect(mtnAX, mtnAY, mtnWidth, mtnHeight);
    rect(mtnBX, mtnBY, mtnWidth, mtnHeight);
    rect(mtnCX, mtnCY, mtnWidth, mtnHeight);
    
    if(count == 4)
    {
      rect(mtnDX, mtnDY, mtnWidth, mtnHeight);
    }
  }
  
  void mtnUpdate() //updates mountains' x
  {
    mtnAX += mtnSpeed;
    mtnBX += mtnSpeed;
    mtnCX += mtnSpeed;
    mtnDX += mtnSpeed;
  }
  
  void mtnBounce(int min, int max, float speed) //makes mountains bounce
  {
    if(count == 4)
    {
      if(down)
      {
        mtnAY += speed;
        mtnBY -= speed;
        mtnCY += speed;
        mtnDY -= speed;
      }
      else if(!down)
      {
        mtnAY -= speed;
        mtnBY += speed;
        mtnCY -= speed;
        mtnDY += speed;
      }
    }
    else if(count == 3)
    {
      if(down)
      {
        mtnAY += speed;
        mtnBY += speed;
        mtnCY += speed;
        mtnDY += speed;
      }
      else if(!down)
      {
        mtnAY -= speed;
        mtnBY -= speed;
        mtnCY -= speed;
        mtnDY -= speed;
      }
    }
    
    if(mtnAY >= max)
    {
        down = false;
    }
      else if(mtnAY <= min)
    {
        down = true;
    }
  }
  
  void mtnReset() //resets mountains' x
  {
    if(mtnAX >= mtnResetCheck)
    {
      mtnAX = mtnReset;
    }
    if(mtnBX >= mtnResetCheck)
    {
      mtnBX = mtnReset;
    }
    if(mtnCX >= mtnResetCheck)
    {
      mtnCX = mtnReset;
    }
    if(mtnDX >= mtnResetCheck)
    {
      mtnDX = mtnReset;
    }
  }
}

void robotDraw()
{
    pushMatrix();
    translate(robotX, robotY);
    rotate(rotation);
    robot();
    popMatrix();
  
  if(robotFlip)
  {
    rotation -= 0.065;
    
    robotX -= 10;
    
    if(robotUp)
    {
      robotY -= 4.5;
    }
    else if(!robotUp)
    {
      robotY += 4.5;
    }
    
    if(robotY <= 10)
    {
      robotUp = false;
    }
  }
  else
  {
    robotX++;
    robotY = 225;
    rotation = 0;
  }
  
  if(robotX >= 890)
  {
    robotFlip = true;
    robotUp = true;
  }
  else if(robotX <= -90)
  {
    robotFlip = false;
  }
}

void robot()
{
  fill(#e0e0e0);
  arc(robotXOrigin, robotYOrigin, 100, 100, PI, PI * 2); //head
  
  fill(#fefefe);
  rect(robotXOrigin - 50, robotYOrigin, 100, 125, 0, 0, 2, 2); //body
  
  fill(#e0e0e0);
  rect (robotXOrigin - 60, robotYOrigin + 5, 15, 25); //shoulder joints
  rect (robotXOrigin + 45, robotYOrigin + 5, 15, 25);
  
  fill(#4066C1);
  rect(robotXOrigin - 82.5, robotYOrigin + 20, 10, 15);
  
  fill(#fefefe);
  rect(robotXOrigin - 77.5, robotYOrigin - 5, 22.5, 50, 4, 2, 0, 4); //shoulders
  rect(robotXOrigin + 55, robotYOrigin - 5, 22.5, 50, 2, 4, 4, 0);
  
  fill(#d4d2d3);
  rect(robotXOrigin - 72, robotYOrigin + 45, 17, 75); //arms
  rect(robotXOrigin + 55, robotYOrigin + 45, 17, 75);
  
  fill(#e6e1e2);
  quad(robotXOrigin + 45, robotYOrigin + 125, robotXOrigin - 40, robotYOrigin + 125, robotXOrigin - 30, robotYOrigin + 140, robotXOrigin + 30, robotYOrigin + 140); //bottom
  
  fill(#fefefe);
  rect(robotXOrigin - 77.5, robotYOrigin + 115, 22.5, 30, 4, 0, 0, 0); //ankles
  rect(robotXOrigin + 55, robotYOrigin + 115, 22.5, 30, 0, 4, 0, 0);
  
  fill(#e6e1e2);
  quad(robotXOrigin - 77.5, robotYOrigin + 145, robotXOrigin - 55, robotYOrigin + 145, robotXOrigin - 48, robotYOrigin + 175, robotXOrigin - 85, robotYOrigin + 175); //feet
  quad(robotXOrigin + 55, robotYOrigin + 145, robotXOrigin + 77.5, robotYOrigin + 145, robotXOrigin + 85, robotYOrigin + 175, robotXOrigin + 48, robotYOrigin + 175);
  
  //details
  stroke(#333333); //gap
  strokeWeight(2.4);
  line(robotXOrigin - 50, robotYOrigin, robotXOrigin + 50, robotYOrigin);
  
  noStroke(); //head
  fill(#4066C1);
  ellipse(robotXOrigin, robotYOrigin - 25, 35, 35);
  fill(#333333);
  ellipse(robotXOrigin, robotYOrigin - 25, 20, 20);
  fill(#fefefe);
  ellipse(robotXOrigin + 4, robotYOrigin - 28, 5, 5);
  
  stroke(#4066C1); //body
  strokeWeight(8);
  line(robotXOrigin - 20, robotYOrigin + 13, robotXOrigin + 20, robotYOrigin + 13);
  strokeWeight(6);
  line(robotXOrigin - 20, robotYOrigin + 22, robotXOrigin - 10, robotYOrigin + 22);
  line(robotXOrigin, robotYOrigin + 22, robotXOrigin + 20, robotYOrigin + 22);
  line(robotXOrigin - 20, robotYOrigin + 31, robotXOrigin, robotYOrigin + 31);
  line(robotXOrigin + 10, robotYOrigin + 31, robotXOrigin + 20, robotYOrigin + 31);
  fill(#4066C1);
  rect(robotXOrigin - 21, robotYOrigin + 40, 20, 30, 4);
  stroke(#d4d2d3);
  strokeWeight(2);
  noFill();
  rect(robotXOrigin - 40, robotYOrigin + 82.5, 80, 30, 2);
  
  noStroke(); //ankles
  fill(#4066C1);
  rect(robotXOrigin - 62.5, robotYOrigin + 130, 7.5, 15);
  rect(robotXOrigin + 55, robotYOrigin + 130, 7.5, 15);
}

void ground() //draws ground
{
  stroke(blue);
  strokeWeight(8);
  fill(black);
  
  line(0, height * 2/3, width, height * 2/3);
  
  noStroke();
  
  rect(0, height * 2/3, width, 200);
}

void pmDraw() //handles pacman
{
  pacman();
  
  if(pmRight)
  {
    pmX += 0.25;
  }
  else
  {
    pmX -= 0.8;
  }
}

void pacman() //draws pacman
{
  if(frameCount % 20 == 0)
  {
    pmOpen = !pmOpen;
  }
  
  noStroke();
  fill(yellow);
  
  if(pmOpen)
  {
    arc(pmX, pmY, 75, 75, -QUARTER_PI * 3, QUARTER_PI * 3, PIE);
    
    noStroke();
    fill(black);
    ellipse(pmX, pmY - 20, 10, 10);
  }
  else
  {
    circle(pmX, pmY, 75);
    stroke(black);
    strokeWeight(1.5);
    line(pmX - 37.5, pmY, pmX - 3, pmY);
    
    noStroke();
    fill(black);
    ellipse(pmX - 1, pmY - 18, 10, 10);
  }  
}

void coinDraw() //handles coin
{
  coin();
  
  coinX += 5;
  
  if(coinX >= pmX)
  {
    coinX = coinXReset;
    
    if(coinCount % 4 == 0)
    {
      pmRight = false;
    }
    else
    {
      pmRight = true;
    }
    
    coinCount += 1;
  } 
}

void coin() //draws coin
{
  noStroke();
  fill(pink);
  
  if(coinCount % 4 == 0)
  {
    image(cherry, coinX - 30, coinY - 25);
  }
  else
  {
    circle(coinX, coinY, 20);
  }
}
