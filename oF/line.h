#import "ofMain.h"
#define PtCOUNT 100
#define PtNUM 30

class Lines{
private:
    float size;
    float friction;
    ofColor col;

    ofPoint positions[PtCOUNT][PtNUM];

    vector<ofPoint> velocities;
    vector<ofPoint> frictions;
    vector<ofPoint> eases;




public:
    void init(){
        size = 0.3;
        friction = 0.99;
        col.set(0x0075ff);


        for(int i = 0; i < PtNUM; i++){
            ofPoint pos, lastPosition, velocity, friction, ease;
            pos.set(0, 0);
            lastPosition.set(0, 0);
            velocity.set(0, 0);
            friction.set(ofRandom(10, 40), ofRandom(10, 40));
            ease.set(ofRandom(.2, .4), ofRandom(.2, .4));


//            lastPositions.push_back(lastPosition);
//            positons.push_back(pos);
//            lastlastPositions.push_back(pos);

            velocities.push_back(velocity);
            frictions.push_back(friction);
            eases.push_back(ease);
        }



    }

    void update(ofPoint mousePoint){
        for(int i = 0; i < PtNUM; i++){
            for(int j = 0; j < PtCOUNT - 1; j++){
                positions[j][i].set(positions[j+1][i].x, positions[j+1][i].y);
            }


            positions[PtCOUNT - 1][i].set( positions[PtCOUNT - 1][i].x + velocities[i].x, positions[PtCOUNT - 1][i].y + velocities[i].y);
            float velocity_x, velocity_y;

            velocities[i].x += (((mousePoint.x - positions[PtCOUNT - 1][i].x) * eases[i].x) - velocities[i].x) / frictions[i].x;
            velocities[i].y += (((mousePoint.y - positions[PtCOUNT - 1][i].y) * eases[i].y) - velocities[i].y) / frictions[i].y;

            velocities[i] *= friction;
        }
    }

    void draw(){
        for(int i = 0; i < PtNUM; i++){

            for(int j = 0; j < PtCOUNT - 1; j++){
                int alpha = int( 255 * (j + 1) / PtCOUNT * 0.9 );
                ofSetColor(255, 255, 255, alpha);
                ofLine(positions[j][i].x, positions[j][i].y, positions[j + 1][i].x, positions[j + 1][i].y);
            }





        }
    }

};