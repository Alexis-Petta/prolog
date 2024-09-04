% Se cumple para los jugadores.
jugador(rojo).
jugador(azul).
jugador(amarillo).
jugador(verde).
jugador(naranja).
jugador(violeta).
% Relaciona un país con el continente en el que está ubicado,
ubicadoEn(argentina, america).
ubicadoEn(brasil, america).
ubicadoEn(uruguay, america).
ubicadoEn(chile, america).
ubicadoEn(bolivia, america).
ubicadoEn(paraguay, america).
ubicadoEn(a, america).
ubicadoEn(b, america).
ubicadoEn(c, america).
ubicadoEn(espana, europa).
ubicadoEn(portugal, europa).
ubicadoEn(francia, europa).
ubicadoEn(alemana, europa).
ubicadoEn(nigeria, africa).
ubicadoEn(madagascar, africa).
ubicadoEn(caboVerde, africa).
ubicadoEn(mali, africa).
ubicadoEn(argelia, africa).

ubicadoEn(australia, oceania).
ubicadoEn(nuevaZelanda, oceania).
ubicadoEn(islasFishi, oceania).

ubicadoEn(japon, asia).
ubicadoEn(china, asia).
ubicadoEn(corea, asia).
ubicadoEn(mongolia, asia).
ubicadoEn(india, asia).
ubicadoEn(tailandia, asia).
% Relaciona dos jugadores si son aliados.
aliados(naranja, amarillo).
aliados(amarillo, naranja).

aliados(naranja, rojo).
aliados(rojo, naranja).

aliados(verde, azul).
aliados(azul, verde).

aliados(verde, amarillo).
aliados(amarillo, verde).

aliados(violeta, azul).
aliados(azul, violeta).

aliados(violeta, rojo).
aliados(rojo, violeta).

% Relaciona un jugador con un país en el que tiene ejércitos.
% Jugadores y sus países asignados
ocupa(rojo, argentina).
ocupa(rojo, brasil).
ocupa(rojo, espana).
ocupa(rojo, nigeria).

ocupa(azul, chile).
ocupa(azul, uruguay).
ocupa(azul, portugal).
ocupa(azul, madagascar).

ocupa(amarillo, bolivia).
ocupa(amarillo, paraguay).
ocupa(amarillo, francia).
ocupa(amarillo, mali).

ocupa(verde, alemania).
ocupa(verde, argelia).
ocupa(verde, australia).
ocupa(verde, nuevaZelanda).
ocupa(verde, a).

ocupa(naranja, islasFishi).
ocupa(naranja, japon).
ocupa(naranja, china).
ocupa(naranja, corea).
ocupa(naranja, b).

ocupa(violeta, mongolia).
ocupa(violeta, india).
ocupa(violeta, tailandia).
ocupa(violeta, caboVerde).
ocupa(violeta, c).

% Relaciona dos países si son limítrofes.
% Países limítrofes en América
limitrofe(argentina, brasil).
limitrofe(argentina, chile).
limitrofe(argentina, uruguay).
limitrofe(argentina, bolivia).
limitrofe(argentina, paraguay).
limitrofe(brasil, uruguay).
limitrofe(brasil, paraguay).
limitrofe(brasil, bolivia).
limitrofe(brasil, chile).  % No es un límite terrestre, pero se podría considerar en algunos contextos.
limitrofe(uruguay, brasil).
limitrofe(uruguay, argentina).
limitrofe(chile, argentina).
limitrofe(chile, bolivia).
limitrofe(bolivia, paraguay).
limitrofe(bolivia, brasil).
limitrofe(bolivia, chile).
limitrofe(paraguay, argentina).
limitrofe(paraguay, brasil).
limitrofe(paraguay, bolivia).
% Países limítrofes en Europa
limitrofe(espana, portugal).
limitrofe(espana, francia).
limitrofe(francia, espana).
limitrofe(francia, alemana).
% Países limítrofes en África
limitrofe(nigeria, mali).
limitrofe(nigeria, argelia).  % Realmente, Nigeria no es limítrofe con Argelia, pero se podría considerar una relación especial.
limitrofe(madagascar, caboVerde).  % No es un límite terrestre, pero se podría considerar una relación marítima.
limitrofe(mali, argelia).
limitrofe(argelia, mali).
limitrofe(argelia, nigeria).
% Países limítrofes en Asia
limitrofe(china, india).
limitrofe(china, mongolia).
limitrofe(china, japon).  % No es un límite terrestre, pero se podría considerar en algunos contextos.
limitrofe(china, corea).
limitrofe(india, china).
limitrofe(india, tailandia).
limitrofe(japon, corea).  % No es un límite terrestre, pero se podría considerar en algunos contextos.
limitrofe(mongolia, china).
limitrofe(corea, japon).
% Países limítrofes en Oceanía
limitrofe(australia, nuevaZelanda).  % No es un límite terrestre, pero se podría considerar en algunos contextos.
limitrofe(australia, islasFishi).  % Relación marítima.
limitrofe(nuevaZelanda, australia).
limitrofe(islasFishi, australia).

/*Se pide modelar los siguientes predicados, de forma tal que sean completamente inversibles:
tienePresenciaEn/2: Relaciona un jugador con un continente del cual ocupa, al menos, un país.*/

tienePresenciaEn(Jugador, Continente):-
    ocupa(Jugador, Pais),
    ubicadoEn(Pais, Continente).
/*
puedenAtacarse/2: Relaciona dos jugadores si uno ocupa al menos un país limítrofe a algún país ocupado por el otro.
*/
puedenAtacarse(JugadorA, JugadorB):-
    ocupa(JugadorA, PaisA),
    ocupa(JugadorB, PaisB), 
    limitrofe(PaisA, PaisB),
    JugadorA \= JugadorB.

/*
sinTensiones/2: Relaciona dos jugadores que, o bien no pueden atacarse, o son aliados.
*/
sinTensiones(JugadorA, JugadorB):-
    aliados(JugadorA, JugadorB).
sinTensiones(JugadorA, JugadorB):-
    jugador(JugadorA), jugador(JugadorB),
    not(puedenAtacarse(JugadorA, JugadorB)).
/*
perdió/1: Se cumple para un jugador que no ocupa ningún país.
*/

perdio(Jugador):-
    jugador(Jugador),
    not(ocupa(Jugador, _)).
/*
controla/2: Relaciona un jugador con un continente si ocupa todos los países del mismo.
*/

controla(Jugador, Continente):-
    jugador(Jugador),
    ubicadoEn(_, Continente),
    forall(ubicadoEn(Pais,Continente), ocupa(Jugador, Pais)).

/*
reñido/1: Se cumple para los continentes donde todos los jugadores ocupan algún país.
*/

renido(Continente):-
    ubicadoEn(_, Continente),
    forall(jugador(Jugador), (ocupa(Jugador, Pais), ubicadoEn(Pais, Continente))).

/*
atrincherado/1: Se cumple para los jugadores que ocupan países en un único continente.
*/

atrincherado(Jugador):-
    jugador(Jugador),
    ubicadoEn(_, Continente),
    forall(ocupa(Jugador, Pais), ubicadoEn(Pais, Continente)).

/*
puedeConquistar/2: Relaciona un jugador con un continente si no lo controla, pero todos los países del continente que le falta ocupar son limítrofes a alguno que sí ocupa
y pertenecen a alguien que no es su aliado.*/

puedeConquistar(Jugador, Continente):-
    jugador(Jugador), ubicadoEn(_, Continente),
    not(controla(Jugador, Continente)),
    forall((ubicadoEn(Pais, Continente), (not(ocupa(Jugador, Pais)))), puedeAtacar(Jugador, Pais)).

puedeAtacar(Jugador, PaisAtacado):-
    ocupa(Jugador, PaisDondeAtaca), 
    ocupa(JugadorB, PaisAtacado),
    not(ocupa(Jugador, PaisAtacado)),
    not(aliados(Jugador, JugadorB)),
    limitrofe(PaisDondeAtaca, PaisAtacado).