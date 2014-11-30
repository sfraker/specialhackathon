
int x = -2;
int y = 0;
int rect_width = 100;
int rect_height = 100;


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

  draw_ship(0.5, 1, 0.5, 0);

  draw_grid();
}

void keyPressed()
{
  if (key == 'h') {
    //rect_width -= 10;
    rect_width = (rect_width - 10);
  } else if (key == 'l') {
    //rect_width += 10;
    rect_width = (rect_width + 10);
  } else if (key == 'j') {
    y += 10;
  } else if (key == 'k') {
    y -= 10;
  }
}

float gamma(float beta) {
  return 1 / sqrt(1 - beta * beta);
}

float t_star(float t, float x, float beta_star) {
  float gamma_star = gamma(beta_star);
  float lag = beta_star * x / t;
  return gamma_star * (t - lag);
}

float x_star(float t, float x, float beta) {
  return gamma(beta)*(x - beta*t);
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

  float L_star = L/gamma(beta_star);

  float beta_ship_star = (x2_star - L_star)/t2_star;

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
