esPadre(juan, pedro).
esPadre(juan, maria).
esPadre(laura, pedro).
esPadre(laura, maria).
esPadre(pedro, luis).
esPadre(maria, ana).
esPadre(maria, isabel).
esPadre(carlos, isabel).
esPadre(ana, javier).
esPadre(javier, carolina).
esPadre(carolina, raul).
esPadre(luis, elena).
esPadre(luis, carlos).


esHermano(pedro, maria).
esHermano(ana, isabel).
esHermano(carlos, elena).

%Reglas de Abuelo, Tio y primo
esAbuelo(Abuelo, Nieto) :- 
    esPadre(Abuelo, Padre), esPadre(Padre, Nieto).
esTio(Tio, Sobrino) :-
    esHermano(Tio, Padre), esPadre(Padre, Sobrino).

esPrimo(PrimerPersona, SegundaPersona) :- 
    esPadre(PrimerPadre, PrimerPersona), 
    esPadre(SegundoPadre, SegundaPersona), 
    esHermano(PrimerPadre, SegundoPadre).
%Regla de descendencia
esDescendiente(X, Y) :- 
    esPadre(Y, X).                 
esDescendiente(X, Y) :- 
    esPadre(Y, Z), 
    esDescendiente(X, Z). 

arbol(Persona) :-
    findall(Hijo, esPadre(Persona, Hijo), Hijos),
    findall(Nieto, esAbuelo(Persona, Nieto), Nietos),
    findall(Sobrino, esTio(Persona, Sobrino), Sobrinos),
    findall(Primo, esPrimo(Persona, Primo), Primos),
    mostrarRelaciones(Hijos, Nietos, Sobrinos, Primos).
    
mostrarRelaciones([], [], [], []) :-
    write('No se encontraron relaciones familiares.'), nl.

mostrarRelaciones(Hijos, Nietos, Sobrinos, Primos) :-
    (Hijos \= [] -> write('Hijos: '), write(Hijos), nl; true),
    (Nietos \= [] -> write('Nietos: '), write(Nietos), nl; true),
    (Sobrinos \= [] -> write('Sobrinos: '), write(Sobrinos), nl; true),
    (Primos \= [] -> write('Primos: '), write(Primos), nl; true).
    
/*Ejercicio de colores*/
color(rojo, river).
color(rojo, sanLorenzo).
color(rojo, independiente).
color(rojo, estudiantes).
color(rojo, argentinos).
color(azul, sanLorenzo).
color(azul, boca).
color(azul, racing).
color(azul, rosarioCentral).
color(azul, atlanta).
color(amarillo, boca).
color(amarillo, rosarioCentral).
color(amarillo, atlanta).
color(amarillo, defensaYJusticia).
color(amarillo, aldosivi).
/*altura*/
mide_metros(juan, 1.75).
mide_metros(laura, 1.62).
mide_metros(pedro, 1.80).
mide_metros(maria, 1.55).
mide_metros(luis, 1.75).
mide_metros(carlos, 1.80).
mide_metros(elena, 1.69).
mide_metros(ana, 1.49).
mide_metros(javier, 1.70).
mide_metros(isabel, 1.65).
mide_metros(carolina, 1.50).
/*animales voladores*/
animalVolador(Animal):-
    animalConAlas(Animal),
    pesoAnimal(Animal, Peso),
    Peso<10.
animalConAlas(aguila).
animalConAlas(paloma).
animalConAlas(pinguino).
pesoAnimal(aguila, 4).
pesoAnimal(paloma, 1).
pesoAnimal(pinguino, 25).
/*operaciones*/
suma(X, Y, Z):-
    Z is X+Y.
multiplicacion(X, Y, Z):-
    Z is X*Y.
mayor(Num1, Num2):-
    Num1>Num2.
menorOIgual(Num1, Num2):-
    Num1=<Num2.
hipotenusa(Cateto1, Cateto2, Resultado):-
    Resultado is ((Cateto1*Cateto1+Cateto2*Cateto2)^(1/2)).
areaCirculo(Radio, Resultado):-
    Resultado is (3,14*Radio*Radio).
