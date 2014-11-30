int screen_width = 800;
int screen_height = 800;

int x = -2;
int y = 0;
int rect_width = 100;
int rect_height = 100;
float L = 0.5;
float d = 1;
float beta_ship = 0.7;
float beta_star = 0.5;
float beta_step_size = 0.01;
float length_step_size = 0.2;


void setup()
{
size(800, 800, P3D);
background(0);
}


void draw()
{
  //fill(200);
  //rect(x, y, rect_width, rect_height);

  translate(400.0, 400.0);
  scale(200.0, -200.0);

  background(0);
  draw_ship(L, d, beta_ship, beta_star);
  draw_doors(L, d, beta_ship, beta_star);

  draw_grid();
}

void keyPressed()
{
  if (key == ']') {
    beta_star += beta_step_size;
  } else if (key == '[') {
    beta_star -= beta_step_size;
  } else if (key == 'j') {
    beta_ship += beta_step_size;
  } else if (key == 'k') {
    beta_ship -= beta_step_size;
  } else if (key == 'w') {
    d += length_step_size;
  } else if (key == 'q') {
    d -= length_step_size;
  } else if (key == 'x') {
    L += length_step_size;
  } else if (key == 'z') {
    L -= length_step_size;
  }
}

float gamma(float beta) {
  return 1 / sqrt(1 - beta * beta);
}

float t_star(float t, float x, float beta_star) {
  float gamma_star = gamma(beta_star);
  float lag = beta_star * x;
  return gamma_star * (t - lag);
}

float x_star(float t, float x, float beta) {
  return gamma(beta)*(x - beta*t);
}

void draw_doors(float L,
                float d,
                float beta_ship,
                float beta_star) {
  float t2 = (d - L) / beta_ship;
  float x2 = d;

  float t2_star = t_star(t2, x2, beta_star);
  float x2_star = x_star(t2, x2, beta_star);

  stroke(255);
  line(0, 0, 5, -beta_star * 5);
  line(t2_star, x2_star, -5, x2_star + beta_star * (t2_star + 5));
}

void draw_grid() {
  float i;

  stroke(128);
  strokeWeight(0.005);
  for (i = -0; i <= 0; i+=1) {
    line(i, -5, i, 5);
    line(-5, i, 5, i);
  }

  stroke(64);
  strokeWeight(0.005);
  for (i = -5; i <= 5; i+=1) {
    line(i, -5, i, 5);
    line(-5, i, 5, i);
  }

  stroke(16);
  strokeWeight(0.0025);
  for (i = -5; i <= 5; i+=0.5) {
    line(i, -5, i, 5);
    line(-5, i, 5, i);
  }
}

void draw_ship(float L, float d, float beta_ship, float beta_star) {
  float t2 = (d - L)/beta_ship;
  float x2 = d;

  float t2_star = t_star(t2, x2, beta_star);
  float x2_star = x_star(t2, x2, beta_star);

  float L_star = x_star(0, L, beta_star);
  //float L_star = L*gamma(beta_star);

  float t3 = 0;
  float x3 = L;

  float t3_star = t_star(t3, x3, beta_star);
  float x3_star = x_star(t3, x3, beta_star);

  //stroke(255);
  //line(0, 0, t3_star, x3_star);

  noStroke();
  fill(128, 0, 128);
  quad(0, 0, 0, L_star, t2_star, x2_star, t2_star, x2_star - L_star);

  stroke(255, 0, 0);
  strokeWeight(3);
  line(0, 0, t2_star, x2_star - L_star);

  stroke(0, 0, 255);
  strokeWeight(3);
  line(0, L_star, t2_star, x2_star);
}
