%Integrantes
integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).
%Nivel
nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).
%Instrumentos
instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   CONSIGNAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Saber si un grupo tiene una buena base, que sucede si hay algún integrante de ese grupo que toque un instrumento rítmico y alguien más que toque un instrumento armónico.
buenaBase(Grupo):-
    integrante(Grupo, TocaRitmico, InstrumentoRitmico),
    integrante(Grupo, TocaArmonico, InstrumentoArmonico),
    TocaRitmico \= TocaArmonico,
    instrumento(InstrumentoRitmico, ritmico),
    instrumento(InstrumentoArmonico, armonico).

%Saber si una persona se destaca en un grupo, que se cumple si el nivel con el que toca un instrumento en el grupo en cuestión es al menos dos puntos más del nivel con el que tocan 
%sus instrumentos todos los demás integrantes. Con los datos actuales, sophie se destacaría en sophieTrio y nadie en vientosDelEste.

destaca(Persona, Grupo):-
    nivelConElQueToca(Persona, Grupo, Nivel),
    forall((nivelConElQueToca(OtraPersona, Grupo, NivelMenor), Persona\=OtraPersona), Nivel>=NivelMenor+2).

nivelConElQueToca(Persona, Grupo, Nivel):-
    integrante(Grupo, Persona, Instrumento),
    nivelQueTiene(Persona, Instrumento, Nivel).

/*
Incorporar a la base de conocimientos la información sobre los distintos grupos que se están armando mediante un predicado grupo/2 que relacione a un grupo con el tipo de grupo en cuestión.
En principio cada grupo puede ser una big band o requerir una formación particular (para las cuales se indicará a su vez cuáles son los instrumentos que requiere para estar completo).
El grupo vientosDelEste es una big band.
El grupo sophieTrio tiene una formación de contrabajo, guitarra y violín.
El grupo jazzmin también tiene una formación particular, en este caso de batería, bajo, trompeta, piano y guitarra.
Sabemos que habrán otros tipos de grupos a considerar más adelante, por lo que la solución propuesta para los requerimientos posteriores debería poder extenderse fácilmente en estos términos.
*/

grupo(vientosDelEste, bigBand).
grupo(sophieTrio, formacion([contrabajo, guitarra, violin])).
grupo(jazzmin, formacion([bateria, bajo, trompeta, piano, guitarra])).