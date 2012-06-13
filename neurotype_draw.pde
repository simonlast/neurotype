//coop painter
/* @pjs pauseOnBlur="true"; globalKeyEvents="true"; */
color bkg = color(255);

ArrayList<PVector> brush;
float rad = 25;
color col = color(100,100,100);
float[] controlRad = {300,150};
int numColors = 5;

interface JavaScript {
       void sendStroke(float[] t, float[] x, float[] y);
     }
  
   void bindJavascript(JavaScript js) {
      javascript = js;
    }
  
   JavaScript javascript;


void setup(){
   size(350,350);
   background(255);
   noFill();
   noLoop();
   smooth();
   strokeWeight(rad);
   stroke(col);
    brush = new ArrayList<PVector>();
   
}

void draw(){
 drawBrush();
}

void keyPressed(){
 if(key == 'r'){
  brush = new ArrayList<PVector>();
  background(255);
  redraw();
 } 
}

void mousePressed(){
  background(bkg);
      brush.add(new PVector(mouseX,mouseY));
      loop();
}

void mouseDragged(){
  brush.add(new PVector(mouseX,mouseY));
}

void mouseReleased(){
  sendStroke();
    background(bkg);
  drawBrush();
  redraw();
  brush = new ArrayList<PVector>();
  noLoop();

}

void sendStroke(){
   //if(javascript != null){
    float[] x = new float[brush.size()];
    float[] y = new float[brush.size()];
    float[] t = new float[brush.size()];
    for(int i=0; i<brush.size(); i++){
      x[i] = (brush.get(i).x - width/2)/(width);
      y[i] = (brush.get(i).y - width/2)/(width);
      t[i] = (i* 1.0/(brush.size()));
    }
    
    println(x);
    println(y);
    println(t);
    
    //javascript.sendStroke(red(col), green(col), blue(col), rad, x, y);
  // }
}


void drawBrush(){
  beginShape();
  stroke(col);
  strokeWeight(rad);
  noFill();
  for(PVector p : brush){
    curveVertex(p.x, p.y);
  }
  endShape();
  
}


