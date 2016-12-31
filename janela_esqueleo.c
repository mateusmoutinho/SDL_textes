/*
 Arion Denovaro
 Programa esqueleto de uma janela em SDL 1.2 e C,
 que calcula e regula o FPS
 31/12/2016
*/

#include <time.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <unistd.h>
#define ALT 480
#define LAR 640
#define DPI 32
#define FPS 30
#define TITULO "SDL FPS texte"


int main(int argc, char *argv[])
{
  atexit(SDL_Quit);
  SDL_bool gameloop = SDL_TRUE;
  SDL_Event evt;
  SDL_Surface *tela = NULL;
  Uint32 bpp;
  short unsigned inicio =0, fim =0, deltatm=0,fps=0;
  time_t antes=0, depois =0;


 //inciando a SDL
 if(SDL_Init(SDL_INIT_VIDEO| SDL_INIT_TIMER|SDL_INIT_AUDIO) == -1)
 {
   printf("Erro ao Inciar a SDL\n%s",SDL_GetError());
   exit(EXIT_FAILURE);
 }

 // **********testando o modo de video
  bpp=SDL_VideoModeOK(640, 480, 16, SDL_HWSURFACE|SDL_OPENGL);
  if(!bpp){
    printf("Mode not available.\n");
    exit(-1);
  }

 //*********inicializando o video
tela = SDL_SetVideoMode(LAR,ALT,bpp,SDL_SWSURFACE|SDL_DOUBLEBUF);
if(tela == NULL)
{
 printf("Imposivel de incializar o video \n%s",SDL_GetError());
 exit(EXIT_FAILURE);
}
SDL_WM_SetCaption(TITULO,NULL);
//-------LOAD-----------------
//-------LOAD-----------------

while(gameloop!=SDL_FALSE)
{
  antes =time(NULL);
 inicio = SDL_GetTicks();
 //-------INPUT-----------------
 if(SDL_PollEvent(&evt))
 {
   if(evt.type == SDL_QUIT || evt.key.keysym.sym == SDLK_ESCAPE)
   {gameloop = SDL_FALSE;}
 }
 //-------INPUT-----------------

 //------UPDATE-----------------


 //------UPDATE-----------------

 //-------DRAW-----------------

 SDL_FillRect(tela,NULL,0x0);
//--------
 //-------DRAW-----------------

 //-------FPS-------------------
  fim = SDL_GetTicks();
  deltatm = (fim - inicio);
  if(deltatm < FPS)
  {
    SDL_Delay(deltatm);
  }

  depois =  time(NULL);
  fps++;
  if((depois - antes) == 1)
  {
    printf("FPS %d \n",fps/FPS);
    printf("Delta tempo %d\n",deltatm);
    antes = 0;
    depois =0;
    fps = 0;
  }

 //-------FPS-------------------
}
  SDL_FreeSurface(tela);

 exit(EXIT_SUCCESS);
}
