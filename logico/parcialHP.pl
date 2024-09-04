%Parte 1 - Sombrero Seleccionador
%Para determinar en qué casa queda una persona cuando ingresa a Hogwarts, el Sombrero Seleccionador tiene en cuenta el carácter de la persona, 
%lo que prefiere y en algunos casos su status de sangre.
%
%
%Tenemos que registrar en nuestra base de conocimientos qué características tienen los distintos magos que ingresaron a Hogwarts, el status de sangre que tiene cada mago y 
%en qué casa odiaría quedar. 
%Actualmente sabemos que:
%
%Harry es sangre mestiza, y se caracteriza por ser corajudo, amistoso, orgulloso e inteligente. Odiaría que el sombrero lo mande a Slytherin.
%Draco es sangre pura, y se caracteriza por ser inteligente y orgulloso, pero no es corajudo ni amistoso. Odiaría que el sombrero lo mande a Hufflepuff.
%Hermione es sangre impura, y se caracteriza por ser inteligente, orgullosa y responsable. No hay ninguna casa a la que odiaría ir.
%Además nos interesa saber cuáles son las características principales que el sombrero tiene en cuenta para elegir la casa más apropiada:
%
%Para Gryffindor, lo más importante es tener coraje.
%Para Slytherin, lo más importante es el orgullo y la inteligencia.
%Para Ravenclaw, lo más importante es la inteligencia y la responsabilidad.
%Para Hufflepuff, lo más importante es ser amistoso.
%
%Se pide:
%
%       DEFINICION DE MAGOS
mago(Mago):-
    sangre(Mago, _).
%Para Hufflepuff, lo más importante es ser amistoso
sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).
sangre(ron, pura).
sangre(luna, impura).
caracteristicas(harry, corajudo).
caracteristicas(harry,amistoso).
caracteristicas(harry,orgulloso).
caracteristicas(harry, inteligente).
caracteristicas(draco, inteligente).
caracteristicas(draco, orgulloso).
caracteristicas(draco, noCorajudo).
caracteristicas(draco, noAmistoso).
caracteristicas(hermione, inteligente).
caracteristicas(hermione, orgullosa).
caracteristicas(hermione, responsable).
noQuiereEntrar(harry, slytherin).
noQuiereEntrar(draco,hufflepuff).
%       DEFINICION DE CASAS: casa(Casa),
casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).
%       DEFINICION DE PREFERENCIA CASA: caracteristicaQueTieneEnCuenta(Casa, [Caracteristicas]).
caracteristicaQueTieneEnCuenta(gryffindor, corajudo).
caracteristicaQueTieneEnCuenta(slytherin, orgulloso).
caracteristicaQueTieneEnCuenta(slytherin, inteligente).
caracteristicaQueTieneEnCuenta(ravenclaw, inteligente).
caracteristicaQueTieneEnCuenta(ravenclaw, responsable).
caracteristicaQueTieneEnCuenta(hufflepuff, amistoso).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  PUNTO 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%1. Saber si una casa permite entrar a un mago, lo cual se cumple para cualquier mago y cualquier casa excepto en el caso de Slytherin, que no permite entrar a magos de sangre impura.

% Permitir la entrada a cualquier otra casa
permiteEntrar(Mago, Casa) :-
    mago(Mago),
    casa(Casa),
    Casa \= slytherin.
% Permitir la entrada a Slytherin solo si el mago no es de sangre impura
permiteEntrar(Mago, slytherin) :-
    sangre(Mago, Sangre),
    Sangre \= impura.

%2. Saber si un mago tiene el carácter apropiado para una casa, lo cual se cumple para cualquier mago si sus características incluyen todo lo que se busca para los integrantes de esa casa, 
%independientemente de si la casa le permite la entrada.
tieneCaracterApropiado(Mago, Casa):-
    casa(Casa),
    mago(Mago),
    forall(caracteristicaQueTieneEnCuenta(Casa, Caracteristicas), caracteristicas(Mago, Caracteristicas)).

%3. Determinar en qué casa podría quedar seleccionado un mago sabiendo que tiene que tener el carácter adecuado para la casa, 
%la casa permite su entrada y además el mago no odiaría que lo manden a esa casa. 
%Además Hermione puede quedar seleccionada en Gryffindor, porque al parecer encontró una forma de hackear al sombrero.

podriaQuedarSeleccionado(Mago, Casa):-
    permiteEntrar(Mago, Casa),
    tieneCaracterApropiado(Mago, Casa),
    not(noQuiereEntrar(Mago, Casa)).
podriaQuedarSeleccionado(hermione, gryffindor).

%4. Definir un predicado cadenaDeAmistades/1 que se cumple para una lista de magos si todos ellos se caracterizan por ser amistosos y cada uno podría estar en la misma casa que el siguiente. 
%No hace falta que sea inversible, se consultará de forma individual.

%cadenaDeAmistades(Mago):-    
%    podriaQuedarSeleccionado(Mago, Casa),
%    findall(Magos, caracteristicas(Magos, amistoso), Amistosos),
%    findall(Magos, podriaQuedarSeleccionado(Magos, Casa), Entran),
%    member(Magos, Amistosos),
%    member(Magos, Entran),
%    Magos\=Mago.

cadenaDeAmistades(Magos):-
    sonAmistosos(Magos),
    cadenaDeCasas(Magos).

sonAmistosos(Magos):-
    forall(member(Mago, Magos), amistoso(Mago)).

amistoso(Mago):-
    caracteristicas(Mago, amistoso).

cadenaDeCasas([PrimerMago, SegundoMago|Cola]):-
    podriaQuedarSeleccionado(PrimerMago, Casa),
    podriaQuedarSeleccionado(SegundoMago, Casa),
    cadenaDeCasas(SegundoMago|Cola).
cadenaDeCasas([_]).
cadenaDeCasas([]).

% Parte 2 - La copa de las casas
% A lo largo del año los alumnos pueden ganar o perder puntos para su casa en base a las buenas y malas acciones realizadas, y cuando termina el año se anuncia el ganador de la copa.
% Sobre las acciones que impactan al puntaje actualmente tenemos la siguiente información:
% 
% Malas acciones: son andar de noche fuera de la cama (que resta 50 puntos) o ir a lugares prohibidos. La cantidad de puntos que se resta por ir a un lugar prohibido se indicará para cada lugar. 
% Ir a un lugar que no está prohibido no afecta al puntaje.
% Buenas acciones: son reconocidas por los profesores y prefectos individualmente y el puntaje se indicará para cada acción premiada.
% Necesitamos registrar las distintas acciones que hicieron los alumnos de Hogwarts durante el año. Sabemos que:
% 
% Harry anduvo fuera de cama.
% Hermione fue al tercer piso y a la sección restringida de la biblioteca.
% Harry fue al bosque y al tercer piso.
% Draco fue a las mazmorras.
% A Ron le dieron 50 puntos por su buena acción de ganar una partida de ajedrez mágico.
% A Hermione le dieron 50 puntos por usar su intelecto para salvar a sus amigos de una muerte horrible.
% A Harry le dieron 60 puntos por ganarle a Voldemort.
% 
% También sabemos que los siguientes lugares están prohibidos:
% 
% El bosque, que resta 50 puntos.
% La sección restringida de la biblioteca, que resta 10 puntos.
% El tercer piso, que resta 75 puntos.
% 
% También sabemos en qué casa quedó seleccionado efectivamente cada alumno mediante el predicado esDe/2 que relaciona a la persona con su casa, por ejemplo:
% 
esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).
% 
% 
% 1 - Se pide incorporar a la base de conocimiento la información sobre las acciones realizadas y agregar la siguiente lógica a nuestro programa:
cambioPuntaje(accion(harry, salirDeLaCama), -50).
cambioPuntaje(accion(harry, visitoBosque), -50).
cambioPuntaje(accion(harry, visitoTercerPiso), -75).
cambioPuntaje(accion(harry, vencioAVoldemort), 60).
cambioPuntaje(accion(hermione, visitoTercerPiso), -75).
cambioPuntaje(accion(hermione, visitoLaBibliotecaRestringida), -10).
cambioPuntaje(accion(hermione, salvoASusAmigos), 50).
cambioPuntaje(accion(ron, ganoPartidaDeAjedrez), 50).
cambioPuntaje(pregunta(hermione, bezoarUbicacion, 20, snape), 10).
cambioPuntaje(pregunta(hermione, levitarPluma, 25, flitwick), 25).
% a - Saber si un mago es buen alumno, que se cumple si hizo alguna acción y ninguna de las cosas que hizo se considera una mala acción (que son aquellas que provocan un puntaje negativo).
% b - Saber si una acción es recurrente, que se cumple si más de un mago hizo esa misma acción.
% 
esBuenAlumno(Mago):-
    cambioPuntaje(accion(Mago, _), _),
    forall(cambioPuntaje(accion(Mago, _), Puntaje), Puntaje>0).

esAccionReccurente(Accion):-
    cambioPuntaje(accion(_, Accion),_),
    findall(Accion, cambioPuntaje(accion(_, Accion), _), ListaDeAcciones),
    length(ListaDeAcciones, TotalDeRepeticiones),
    TotalDeRepeticiones>1.
    
% 2 - Saber cuál es el puntaje total de una casa, que es la suma de los puntos obtenidos por sus miembros.

puntajeTotalCasa(Casa, PuntajeFinal):-
    casa(Casa),
    findall(PuntajeAcciones, (esDe(Mago, Casa), cambioPuntaje(accion(Mago, _), PuntajeAcciones)), ListaDePuntajesAcciones),
    findall(PuntajePreguntas, (esDe(Mago, Casa), cambioPuntaje(pregunta(Mago, _, _, _), PuntajePreguntas)), ListaDePuntajesPreguntas),
    sum_list(ListaDePuntajesAcciones, PuntajeFinalAcciones),
    sum_list(ListaDePuntajesPreguntas, PuntajeFinalPreguntas),
    PuntajeFinal is PuntajeFinalAcciones + PuntajeFinalPreguntas.

% 3 - Saber cuál es la casa ganadora de la copa, que se verifica para aquella casa que haya obtenido una cantidad mayor de puntos que todas las otras.
casaGanadora(Casa):-
    casa(Casa),
    forall(casa(OtrasCasas), superoALaOtraCasa(Casa, OtrasCasas)).

superoALaOtraCasa(CasaGanadora, CasaPerdedora):-
    puntajeTotalCasa(CasaGanadora, PuntajeFinalCasaGanadora), 
    puntajeTotalCasa(CasaPerdedora, PuntajeFinalCasaPerdedora), 
    PuntajeFinalCasaGanadora>=PuntajeFinalCasaPerdedora.
% 4 - Queremos agregar la posibilidad de ganar puntos por responder preguntas en clase. La información que nos interesa de las respuestas en clase son: cuál fue la pregunta, 
% cuál es la dificultad de la pregunta y qué profesor la hizo.
% Por ejemplo, sabemos que Hermione respondió a la pregunta de dónde se encuentra un Bezoar, de dificultad 20, realizada por el profesor Snape, y cómo hacer levitar una pluma,
%  de dificultad 25, realizada por el profesor Flitwick.
% 
% Modificar lo que sea necesario para que este agregado funcione con lo desarrollado hasta ahora, teniendo en cuenta que los puntos que se otorgan equivalen a la dificultad de la pregunta,
% a menos que la haya hecho Snape, que da la mitad de puntos en relación a la dificultad de la pregunta.

% Modelado de pregunta:
% cambioPuntaje(pregunta(Mago, Pregunta, Dificultad, Profesor), Puntaje)


%profesor(pregunta(_, _, _, Profesor), Profesor):-
%    cambioPuntaje(pregunta(_, _, _, Profesor), _).
%
%dificultad(pregunta(_, _, Dificultad, _), Dificultad):-
%    cambioPuntaje(pregunta(_, _, Dificultad, _), _).
%
%valorDeLaPregunta(Pregunta, Puntaje):-
%    profesor(Pregunta, Profesor),
%    Profesor\=snape,
%    dificultad(Pregunta, Puntaje).
%valorDeLaPregunta(Pregunta, Puntaje):-
%    profesor(Pregunta, snape),
%    dificultad(Pregunta, X),
%    Puntaje is X*0,5.


