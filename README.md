<h1>PINTURILLO</h1>
<p>
  Toma 2 jugadores:
  <ul>
    <li>Player1</li>
    <li>Player2</li>
  </ul>
</p>
<ins><h3>REGLAS:</h3></ins>

  Por turnos cada jugador dibujara la palabra que se le asigno y adivinara la palabra del otro jugador.
  Al terminar el tiempo o adivinar se intercambian los roles.
  La partida es al mejor de 3, en caso de empate se suma una ronda.

<h3><ins>PASOS</ins></h3>
 
  Imprime en pantalla un Menu que detalla las reglas.
  <br>
  <br>
  `Player1`:
  <ol>
      <li> Elije la categoria(animales u objetos).</li>
      <li> recibe palabra de esa categoria, se acepta la palabra he inicia un contador de 60segundos.</li>
      <li> se le habilita el raton para dibujar la palabra asignada.</li>
  </ol>
  
  `Player2`: 
  <ol>
      <li> Al inciar el contador se le habilita el teclado.</li>
      <li>tiene hasta su finalizacion para adivinar la palbara del otro jugdor.(intentos limitados por proc timer)</li>
  </ol>  
  Finaliza el timer
  <br>
  
  `Player1` pasa a adivinar y `Player2` pasa a dibujar la palabra dada.
  <br>
  Al finalizar se imprime en pantalla el ganador con su puntaje.

<h3><ins>DESARROLLO</ins></h3>
  <p>
  Printea menu
  Pide input de categoria en VAR categoria:
  <ol>
      <li> Animales</li>
      <li> Objetos</li>
  </ol>
  Recibe input en AL
  <br>
  Pasa AL a proc random:
  <ol>
      <li>Genera numero random</li>
      <li>Lo devuelve en al</li>
      <li>mov dl,al</li>
  </ol>                  
  Pasa AL a proc secpalabra
  <ol>
      <li>Toma dl</li>
      <li>AL = 1 -> "animales.txt"</li>
      <li>AL = 2 -> "objetos.txt"</li>
      <li>Abre dir</li>
      <li>Selecciona del .txt con input random() una palabra</li>
      <li>Devuelve palabra en VAR palabra</li>
  </ol>
  Printea cartel "Tu Palabra es :" VAR palabra
  <br>
  Printea cartel "Confirmar para Iniciar"(espeara 30seg)
  <ol>
      <li>No detecta input finaliza</li>
      <li>Sino continua e incia proc timer</li>
  </ol>
  proc timer:
  <ol>
      <li>tiene parametro default 60 segs</li>
      <li>Finalizar printea cartel "TIME OUT"</li>
  </ol>
  Llama a proc pincel:
  <ol>
      <li>permite al usuario pintar en pantalla</li>
      <li>opciones de botones para cambiar el color</li>
      <li>ejecucion paralela con proc timer, proc teclado</li>
      <li>endp pincel set con endp timer</li>
  </ol>
  Simultaneamente Llama a proc teclado:
  <ol>
      <li>permite al Player2 intentar adivinar la VAR palabra del Player1</li>
      <li>recibe en dx el offset de VAR palabra</li>
      <li>compara VAR palabra con VAR guess(ingreso de teclado de Player2)</li>
      <li>Si igual printea cartel "CORRECTO: Player2 la palabra era "VAR palabra</li>
      <li>guarda contador de rondas acertadas para display al final del programa</li>
  </ol>
  El proceso se repite 3 veces, cada vez el rol de Player1 y Player2 se intercambian.
  <br>
  <br>
  Al final de programa llama proc ganador:
  <ol>
      <li>ingresa contadores por p1:bx y p2:cx</li>
      <li>compara cual es mayor y devuelve en ax: 1 o 2</li>
      <li>print cartel "GANADOR es PLAYER_(dx)"</li>
  </ol>
  Finaliza el programa.
  <p>
                 

