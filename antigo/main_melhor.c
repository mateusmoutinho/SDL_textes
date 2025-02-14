/*
tentativa de calcular o FPS de um jogo
*/

#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>

#define ALT 320
#define LAR 240
#define DPI 32
#define FPS 30

int main(int argc, char *argv[])
{

  SDL_Surface *tela=NULL;
  SDL_Event eve;
  SDL_bool gameloop= SDL_TRUE;
  atexit(SDL_Quit);

  int  quadrosMS = 1000/FPS, inicio=0,atraso=0, fim=0;

  // inciando a SDL

   if(SDL_Init(SDL_INIT_VIDEO| SDL_INIT_AUDIO| SDL_INIT_TIMER) ==-1)
    {
      printf("Erro ao inciar a SDL %s\n",SDL_GetError());
      return(EXIT_FAILURE);
      exit(EXIT_FAILURE);
    }
   else
   {
     SDL_Init(SDL_INIT_VIDEO| SDL_INIT_AUDIO| SDL_INIT_TIMER);
     printf("\n SDL iniciada\n");
   }

   //inciando o video
   tela = SDL_SetVideoMode(ALT,LAR,DPI,SDL_SWSURFACE|SDL_DOUBLEBUF);
  if(tela == NULL)
  {
    printf("Erro ao inciar a SDL %s\n",SDL_GetError());
    return(EXIT_FAILURE);
    exit(EXIT_FAILURE);
  }

  SDL_WM_SetCaption("Regluar o FPS",NULL);
  //---------LOAD---------------



  while(gameloop != SDL_FALSE)
  {
    inicio = SDL_GetTicks();
    if(SDL_PollEvent(&eve))
    {
       if(eve.type == SDL_QUIT || eve.key.keysym.sym == SDLK_ESCAPE)
       {gameloop =SDL_FALSE;}
    }

    //---------INPUT------------


    //--------UPDATE-----------------


    //-------DRAW---------------------
     SDL_FillRect(tela,NULL,0x0);


    //-------------------------
    SDL_Flip(tela);
 //------FPS----------------------
  fim = SDL_GetTicks();
  atraso = quadrosMS -(fim - inicio);

    SDL_Delay(atraso);
  }


  exit(EXIT_SUCCESS);

}
