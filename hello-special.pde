int screen_width = 800;
int screen_height = 800;

int orig_t = screen_width / 2;
int orig_x = screen_height / 2;

void setup()
{
  size(screen_width, screen_height);
  background(0);
}


void draw()
{
  fill(200);
  draw_doors(10, 1, .8, 0);
}

void keyPressed()
{
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

void draw_doors(float L,
                float d,
                float beta_ship,
                float beta_star) {
  float t2 = (d - L) / beta_ship;
  float x2 = d;

  float t2_star = t_star(t2, x2, beta_star);
  float x2_star = x_star(t2, x2, beta_star);

  stroke(255);
  line(0, 0, right_edge, -beta_star * right_edge);
  line(t2_star, x2_star, left_edge, beta_star * t2_star);

}
