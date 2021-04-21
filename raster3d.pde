/*
AUTHOR: SAMUEL CHO (TSAO)
DESCRIPTION: raster an image to a rotating 3D grid
https://twitter.com/_samuelcho
https://samuelcho.de
*/

//Photo by Lobacheva Ina
PImage img;

//SQUARE GRID PARAMS
float gridSize = 8;
float g2 = gridSize * 0.5;
int numRows, numCols;


void setup(){
    img = loadImage("flower.jpg");
    img.loadPixels();
    size(1000,1000,P3D); 

    numRows = ceil(height / gridSize);
    numCols = ceil(width / gridSize);
}

void draw(){
    //STYLE
    background(255);
    noStroke();

    //ANIMATION PARAMS
    float rTheta = frameCount * 0.01;

    push(); //move transform origin
    translate(width*.5,0,-width*.15);
    rotateY(rTheta);
    for(int y = 0; y < numRows; y++){
        for(int x = 0; x < numCols; x++){
            //center of each circle
            float xPos = x*gridSize+g2;
            float yPos = y*gridSize+g2;

            //grep the color 
            int i  = floor(yPos * width + xPos);
            i = i % (img.width * img.height); //prevent Index Out of Bounds
            color c = img.pixels[i]; //can be optimized with bitshift
            fill(c);

            //scale based on hue
            float hue = hue(c);
            float scl = (255-hue) / 255;
            scl += 0.5; //oversized circles looks better in distance

            //translate based on brightness
            float b = brightness(c);
            push(); //compensate transformation
            translate(-width*.5,0,-(255-b));
                push();
                translate(xPos,yPos);
                rotateY(-rTheta); //circle always faces front
                ellipse(0,0, gridSize*scl,gridSize*scl);
                pop();
            pop();
        }
    }
    pop();
}
