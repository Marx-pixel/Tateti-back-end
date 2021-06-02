# README

### Iniciar partida

```POST /boards/player_start```

Body

``` { } ```

Respuesta exitosa
``` 
{"id": "id del jugador que realizó el POST",
"nombre": "X u O",
"board": "número del tablero que le fue asignado al jugador",
"squares": "arreglo con el estado del tablero"}
```

Respuesta de error

400
``` 
{message: [{
  path: '/players',
  message: player.error.full_messages
  }]}
  ```
### Realizar un movimiento

Realizar un movimiento tiene dos posibilidades, como en los tateti de madera con fichas móviles:

1- Los jugadores están colocando sus fichas

2- Los jugadores están moviendo sus fichas

En ambos casos el body de la petición y la respuesta son iguales. La diferencia es que "u", la variable que indica qué ficha se desea mover, es ignorada por el servidor en el primer caso. Esto gracias a que el servidor lleva la cuenta de la cantidad de turnos en la partida; cuando llega al 7 significa que las 6 fichas ya han sido colocadas, por lo que la petición entra por un if y se tiene en cuenta "u".

``` POST /boards/game ```

Body

```
{"id": "id del jugador"
"board": "id del tablero"
"u": "casilla seleccionada",
"y": "casilla donde se pone o desplaza la ficha"}
```

Respuesta exitosa

```
{"squares": "estado del tablero"
"xTurn": "booleano que indica si es el turno de X o no"
"winner": "booleano que indica si existe un ganador"
"turnNumber": "indica el número del turno"}
```

Respuesta de error

403

```
{ "mesg": "No es tu turno"}
```
410

```
{ "mesg": "El jugador no existe"}
```

### Consultar por el estado de la partida

``` POST /boards/time_passes ```

Body

```
{"board": "número del tablero"}
```

Respuesta exitosa

```
{"squares": "estado del tablero"
"xTurn": "booleano que indica si es el turno de X o no"
"winner": "booleano que indica si existe un ganador"
"turnNumber": "indica el número del turno"}
```

Respuesta de error

410

```
{"mesg": "El tablero no existe"}
```
### Abandonar partida

También es usado por el jugador perdedor para salir de la pantalla de juego, por una cuestión de que el que elimina el tablero es el ganador con "Terminar juego"

``` DESTROY /boards/leave ```

Body

```
{"id": "id del jugador",
"board": "id del tablero"}
```

Respuesta

``` { } ```

### Terminar juego

``` DELETE /boards/game_over ```

Body

```
{"id": "id del jugador",
"board": "id del tablero"}
```

Respuesta

``` { } ```
