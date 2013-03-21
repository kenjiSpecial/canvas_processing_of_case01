Line myLine;

int width;
int height;

void setup(){
	width = 1024;
	height = 768;

	size( width, height);
	myLine = new Line(width, height);
}

void draw(){
	background(0, 0, 0);
	myLine.update(mouseX, mouseY);
	myLine.draw();
}


