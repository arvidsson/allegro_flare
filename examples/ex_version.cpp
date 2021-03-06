



#include <allegro_flare/allegro_flare.h>




class ExVersionProject : public Screen
{
public:
   ExVersionProject() : Screen()
   {}
   void primary_timer_func() override
   {
      std::string allegro_version = std::string("Allegro ") + Framework::get_allegro_version();
      std::string allegro_flare_version = std::string("AllegroFlare ") + Framework::get_version();

      BitmapObject(Framework::bitmap("allegro_flare_logo-04.png"))
         .position(display->center(), display->middle()-30)
         .align(0.5, 1.0)
         .scale(1.4)
         .draw();

      TextObject(allegro_flare_version)
         .font(Framework::font("DroidSans.ttf 80"))
         .color(color::black)
         .position(display->center(), display->middle()+70)
         .align(0.5, 1.0)
         .draw();

      TextObject(allegro_version)
         .font(Framework::font("DroidSans.ttf 30"))
         .color(color::black)
         .position(display->center(), display->middle()+70)
         .align(0.5, 0.0)
         .draw();
   }
   std::string get_screen_dimentions_text()
   {
      int width = al_get_display_width(display->al_display);
      int height = al_get_display_height(display->al_display);
      std::stringstream ss;
      ss << width << " x " << height;
      return ss.str();
   }
};




int main(int c, char **v)
{
   ExVersionProject project = ExVersionProject();
   Framework::run_loop();
   return 0;
}




