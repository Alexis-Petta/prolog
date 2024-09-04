/*habitat(jirafa, sabana).
habitat(tigre, sabana).
habitat(tigre, bosque).
habitat(foca, costa).
habitat(foca, tundra).
animal(Animal):-
habitat(Animal, _).
acuatico(Animal):-
    habitat(Animal, mar).
terrestre(Animal):-
    animal(Animal),
    not(habitat(Animal, mar)).
templado(costa).
templado(sabana).
friolento(Animal):-
    animal(Animal),
    forall(habitat(Animal, Bioma), templado(Bioma)).*/


/*guia del video*/

% Definición de animales y biomas
animal(leon).
animal(cebra).
animal(jirafa).
animal(hiena).
animal(gacela).
animal(tiburon).
animal(foca).
animal(pinguino).
animal(oso_polar).
animal(orca).
% Biomas
bioma(sabana).
bioma(artico).
bioma(oceano).
% Relación entre animales y biomas
habita(leon, sabana).
habita(cebra, sabana).
habita(jirafa, sabana).
habita(hiena, sabana).
habita(gacela, sabana).
habita(tiburon, oceano).
habita(foca, oceano).
habita(pinguino, artico).
habita(oso_polar, artico).
habita(orca, oceano).
% Relaciones de depredación (quién se come a quién)
come(leon, cebra).
come(leon, gacela).
come(hiena, cebra).
come(hiena, gacela).
come(tiburon, foca).
come(orca, foca).
come(oso_polar, foca).
come(oso_polar, pinguino).
come(pinguino, pinguino).

%respuestas 
hostil(Animal, Bioma):-
    animal(Animal),
    habita(_, Bioma),
    forall(habita(Predador, Bioma),come(Predador, Animal)).
terrible(Animal, Bioma):-
    animal(Animal),
    habita(_, Bioma),
    forall(come(Predador, Animal), habita(Predador, Bioma)).
compatible(Animal, OtroAnimal):-
    animal(Animal), animal(OtroAnimal),
    not(come(OtroAnimal, Animal)),
    not(come(Animal, OtroAnimal)).
adaptable(Animal):-
    animal(Animal),
    forall(habita(_, Bioma), habita(Animal, Bioma)).
raro(Animal):-
    habita(Animal, Bioma), 
    not((habita(Animal, OtroBioma), OtroBioma \= Bioma)).
dominante(Animal):-
    habita(Animal,Bioma),
    forall((habita(OtroAnimal, Bioma), OtroAnimal\=Animal), come(Animal, OtroAnimal)).
