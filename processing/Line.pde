public class Line
{
	
	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------

	int ptCOUNT;
	int ptNUM;

	int lineNums;
	float size;
	float friction;

	float[][] position_x;
	float[][] position_y;

	float[] velocity_x;
	float[] velocity_y;

	float[] friction_x;
	float[] friction_y;

	float[] ease_x;
	float[] ease_y;



	
	public Line (int wid, int hig) {
		ptCOUNT = 30;
		ptNUM = 40;


		friction = .8;

		position_x = new float[ptCOUNT][ptNUM];
		position_y = new float[ptCOUNT][ptNUM];

		velocity_x = new float[ptNUM];
		velocity_y = new float[ptNUM];

		friction_x = new float[ptNUM];
		friction_y = new float[ptNUM];

		ease_x = new float[ptNUM];
		ease_y = new float[ptNUM];


		for (int i = 0; i<ptNUM; i++){
			for (int j = 0; j<ptCOUNT; j++){
				position_x[j][i] = 0;
				position_y[j][i] = 0;
			}

			velocity_x[i] = 0;
			velocity_y[i] = 0;

			friction_x[i] = random(10, 40);
			friction_y[i] = random(10, 40);

			ease_x[i] = random( 2, 10);;
			ease_y[i] = random( 2, 10);;
		}

	}

	void update(float mouseX, float mouseY){
		// float mouseX, mouseY;
		// mouseX = random(1024 * 0.1, 1024* 0.9);
		// mouseY = random(768 * 0.1, 768* 0.9);

		for (int i = 0; i<ptNUM; i++){
			for (int j = 0; j<ptCOUNT - 1; j++){
				// if( i + 1 < ptNUM){
				// 	position_x[j][i] = position_x[j][i +1];
				// 	position_y[j][i] = position_y[j][i +1];
				// }else{
				// 	position_x[j][i] = position_x[j][0];
				// 	position_y[j][i] = position_y[j][0];
				// }

				// if(j == 0){
				// 	position_x[j][i] = random(1024 * 0.1, 1024* 0.9);
				// 	position_y[j][i] = random(1024 * 0.1, 1024* 0.9);
				// }else{
				// 	if(i + 1 < ptNUM){
				// 		position_x[j][i] = position_x[j ][i+1];
				// 		position_y[j][i] = position_y[j ][i+1];
				// 	}else{
				// 		position_x[j][i] = position_x[j ][0];
				// 		position_y[j][i] = position_y[j ][0];
				// 	}
				// }

				position_x[j][i] = position_x[j + 1][i];
				position_y[j][i] = position_y[j + 1][i];

			}

			position_x[ptCOUNT - 1][i] += velocity_x[i];
			position_y[ptCOUNT - 1][i] += velocity_y[i];

			velocity_x[i] += (((mouseX - position_x[ptCOUNT - 1][i]) * ease_x[i]) - velocity_x[i]) / friction_x[i];
			velocity_y[i] += (((mouseY - position_y[ptCOUNT - 1][i]) * ease_y[i]) - velocity_y[i]) / friction_y[i];

			velocity_x[i] *= friction;
			velocity_y[i] *= friction;
		}


	}


	void draw(){
		for (int i = 0; i<ptNUM-1; i++){
			for (int j = 0; j<ptCOUNT -2 ; j++){
				int colAlpha  = (int)(255 *  (j + 1) /ptCOUNT   * .8);
				stroke(255, colAlpha);
				noFill();

				float pt01_x = position_x[j][i];
				float pt01_y = position_y[j][i];

				float pt02_x = position_x[j+1][i];
				float pt02_y = position_y[j+1][i];

				float pt03_x = position_x[j+2][i];
				float pt03_y = position_y[j+2][i];

				float between01_x = (pt01_x + pt02_x)/2;
				float between01_y = (pt01_y + pt02_y)/2;

				float between02_x = (pt02_x + pt03_x)/2;
				float between02_y = (pt02_y + pt03_y)/2;

				bezier(between01_x, between01_y, pt02_x, pt02_y, pt02_x, pt02_y, between02_x, between02_y);

				// line(position_x[j][i], position_y[j][i], position_x[j+1][i], position_y[j+1][i]);
			}
		}
	}
}