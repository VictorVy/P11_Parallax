color black = 0;
color blue = #0032dc;

int mtn1AX = -200;
int mtn1AY = 175;

void setup()
{
  size(800, 600);
}

void draw()
{
  background(black);
  
  mountain.a1();
  ground();
  
  update1();
  
  reset1();
}

void update1()
{
  mtn1AX += 2;
}

void reset1()
{
  if(mtn1AX >= 1000)
  {
    mtn1AX = -200;
  }
}

void ground()
{
  stroke(blue);
  strokeWeight(8);
  fill(black);
  
  line(0, height * 2/3, width, height * 2/3);
  
  noStroke();
  
  rect(0, height * 2/3, width, 200);
}

class mountain
{
  public mountain()
  {
    stroke(blue);
    strokeWeight(4);
    noFill();
  }
  
  void a1()
  {
    rect(mtn1AX, mtn1AY, 175, 225);
  }
}
