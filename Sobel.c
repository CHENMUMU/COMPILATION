const int height = 128; 
const int width = 128; 
int main() {
	int i, j;
	int gx, gy;
	int image[height][width]; // Image originale en niveaux de gris. 
	int sobel[height][width]; // Image transformée. 
	stencil gx{1,2}={{-1, 0, 1},{-2, 0, 2},{-1, 0, 1}}; 
	stencil gy{1,2}={{ 1, 2, 1},{ 0, 0, 0},{-1,-2,-1}};
	
  	// Filtre Sobel
	for (i = 1; i < height - 1; i++) { 
		for (j = 1; j < width - 1; j++) {
      			sobel[i][j] = sqrt((pow(gx $ image[i][j], 2) +
                          			pow(gy $ image[i][j], 2)) / 4.);
		} 
	}
	return 0; 
}