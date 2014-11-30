
int x = 0;
int y = 0;
int rect_width = 100;
int rect_height = 100;


void setup()
{
size(640, 360);
background(0);
}


void draw()
{
  fill(200);
  rect(x, y, rect_width, rect_height);
  x += 1;
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
