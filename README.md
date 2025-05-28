Pinturillo
Toma 2 jugadores(players).
REGLAS:

  Por turnos cada jugador dibujara la palabra que se le asigno y adivinara la palabra del otro jugador.
  Al terminar el tiempo o adivinar se intercambian los roles.
  La partida es al mejor de 3, en caso de empate se suma una ronda.

PASOS
 
  Imprime en pantalla un Menu que detalla las reglas.
  Player1 elije la categoria(animales u objetos).
  Player1 recibe palabra de esa categoria, se acepta la palabra he inicia un contador de 60segundos.
  Player1 se le habilita el raton para dibujar la palabra asignada.
  Player2 se le habilita el teclado para ingresar palabra proporcionada al Player1.
  Player2 dispone de intentos ilimitados pero estos reducen su puntaje final.
  
  Player1 pasa a adivinar y Player2 pasa a dibujar la palabra dada.
  Al finalizar se imprime en pantalla el ganador con su puntaje.

DESARROLLO

  Printea menu
  Pide input de categoria en VAR categoria:
                                        1)Animales
                                        2)Objetos
  Recibe input en AL
  Pasa AL a proc random:
                - Genera numero random
                - lo devuelve en al
                - mov dl,al
  Pasa AL a proc secpalabra
                - Toma dl
                - AL = 1 -> "animales.txt"
                - AL = 2 -> "objetos.txt"
                - Abre dir
                - Selecciona del .txt con input random() una plabra
                - Devuelve palabra en VAR palabra
  
  Printea cartel "Tu Palabra es :" VAR palabra
  Printea cartel "Confirmar para Iniciar"(espeara 30seg)
                                          - No detecta input finaliza
                                          - Sino continua e incia proc timer
  proc timer:
        - tiene parametro default 60 segs
        - Finalizar printea cartel "TIME OUT"
  
  Llama a proc pincel:
              - permite al usuario pintar en pantalla
              - opciones de botones para cambiar el color
              - ejecucion paralela con proc timer, proc teclado
              - endp pincel set con endp timer
  
  Simultaneamente Llama a proc teclado:
                 - permite al Player2 intentar adivinar la VAR palabra del Player1
                 - recibe en dx el offset de VAR palabra
                 - compara VAR palabra con VAR guess(ingreso de teclado de Player2)
                 - Si igual printea cartel "CORRECTO: Player2 la palabra era "VAR palabra
                 - guarda contador de rondas acertadas para display al final del programa
  El proceso se repite 3 veces, cada vez el rol de Player1 y Player2 se intercambian.
  Al final de programa llama proc ganador:
                                - ingresa contadores por p1:bx y p2:cx
                                - compara cual es mayor y devuelve en dx: 1 o 2
                                - print cartel "GANADOR es PLAYER_(dx)"
  Finaliza el programa.
                 

