 class Stick
{
  float x;
  float y = height/2;
  
  Stick(boolean left)
  {
    if(left)
    {
      x = 20;
    }
    else
    {
      x = width -20;
    }
  }
 
  
  void show()
  {
    fill(255);
    rectMode(CENTER);
    rect(x,y,30,120);
  }
  
  void move(float step)
  {
    y -= step;
    y = constrain(y,60,height-60);
  }
}



class Ball
{
  float x = width/2;
  float y = height/2;
  float xspeed = 6;
  float yspeed = 8;
  int leftscore = 0;
  int rightscore = 0;
  
   void HitsLeft(Stick s)
   {
    if (y - 12 < s.y + 60 && y + 12 > s.y - 60 && x - 12 < s.x + 15) 
    {
      if (x > s.x) 
      {
        float diff = y - (s.y - 60);
        float rad = radians(45);
        float angle = map(diff, 0, 120, -rad, rad);
        xspeed = 5 * cos(angle);
        yspeed = 5 * sin(angle);
        x = s.x + 15 + 12;
        
      }
    }
  }
  
  void HitsRight(Stick s) 
  {
    if (y - 12 < s.y + 60 && y + 12 > s.y - 60 && x + 12 > s.x - 15) 
    {
      if (x < s.x) 
      {
        xspeed *= -1;
        float diff = y - (s.y - 60);
        float angle = map(diff, 0, 120, radians(225), radians(135));
        xspeed = 5 * cos(angle);
        yspeed = 5 * sin(angle);
        x = s.x - 15 - 12;
      }
    }
  }
 
   
  
  
  void edges()
  {
    if(y < 12 || y > height-12)
    {
      yspeed *= -1;
    }
    
     if(x < 12 || x > width-12)
    {
      x = width/2;
      y= height/2;
    }
    
  if (x - 12 > width) 
  {
      leftscore++;
  }

  if (x + 12 < 0) 
  {
      rightscore++;
  }

  }
  
  void update()
  {
    x += xspeed;
    y += yspeed;
  }
  
  void show()
  {
    fill(255);
    ellipse(x,y,24,24);
  }
}



Ball b;
Stick r;
Stick l;
int leftscore = 0;
int rightscore = 0;
int stage = 1;
PImage menu;
PImage bg;
PFont title;


void setup()
{
  stage = 1;
  size(1024,600);
  menu = loadImage("pongy.jpg");
  image(menu, 0, 0, 1024, 600);
  title = createFont("font",1000,true);
  b = new Ball();
  l = new Stick(true);
  r = new Stick(false);
}


void draw()
{
  if(stage == 1)
  {
    textAlign(CENTER);
    textSize(80); 
    text("PONG GAME",380,300);
    textSize(50); 
    text("PRESS SPACE TO PLAY GAME",380,400);
    //minim = new Minim(this);
    
    //menusound = minim.loadFile("1.mp3");
    //menusound.play();
    if(key == ' ')
    {
      stage = 2;
      
    }
    
  }
  
  if(stage == 2)
  {
  
    bg = loadImage("bg.jpg");
    background(0);
  
    b.HitsLeft(l);
    b.HitsRight(r);
  
    l.show();
    r.show();
  
    fill(255);
    textSize(32);
    text(leftscore, 32, 40);
    text(rightscore, width-64, 40);
  
    b.update();
    b.edges();
    b.show();
  }
  
}

void keyPressed()
{
  if(key == 'a')
  {
    l.move(30);
  }
  
  if(key == 'y')
  {
    l.move(-30);
  }
  
  if(key == 'k')
  {
    r.move(30);
  }
  
  if(key == 'm')
  {
    r.move(-30);
  }
}
