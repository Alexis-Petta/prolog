%
%Festivales de... rock?
%
%
%En los últimos años volvieron a ponerse de moda los grandes festivales de rock y metal en la Argentina, pero con unos “ligeros” cambios en las agrupaciones que participan…
%Ante el descontento de ciertos fanáticos, los organizadores decidieron encomendar la tarea de selección de las distintas bandas a los rockeros de PdeP, quienes decidieron, 
%usando el paradigma lógico, modelar los distintos eventos.
%
% 
%
%Se cuenta con la siguiente base de conocimiento:

anioActual(2015).
%festival(nombre, lugar, bandas, precioBase).
%lugar(nombre, capacidad).
festival(lulapaluza, lugar(hipodromo,40000), [miranda, paulMasCarne, muse], 500).
festival(mostrosDelRock, lugar(granRex, 10000), [kiss, judasPriest, blackSabbath], 1000).
festival(personalFest, lugar(geba, 5000), [tanBionica, muse, pharrellWilliams], 300).
festival(cosquinRock, lugar(aerodromo, 2500), [erucaSativa, laRenga], 400).


%banda(nombre, año, nacionalidad, popularidad).
banda(paulMasCarne,1960, uk, 70).
banda(muse,1994, uk, 45).
banda(kiss,1973, us, 63).
banda(erucaSativa,2007, ar, 60).
banda(judasPriest,1969, uk, 91).
banda(tanBionica,2012, ar, 71).
banda(miranda,2001, ar, 38).
banda(laRenga,1988, ar, 70).
banda(blackSabbath,1968, uk, 96).
banda(pharrellWilliams,2014, us, 85).


% entradasVendidas(nombreDelFestival, tipoDeEntrada, cantidadVendida).
% tipos de entrada: campo, plateaNumerada(numero de fila), plateaGeneral(zona).

entradasVendidas(lulapaluza,campo, 600).
entradasVendidas(lulapaluza,plateaGeneral(zona1), 200).
entradasVendidas(lulapaluza,plateaGeneral(zona2), 300).

entradasVendidas(mostrosDelRock,campo,20000).
entradasVendidas(mostrosDelRock,plateaNumerada(1),40).
entradasVendidas(mostrosDelRock,plateaNumerada(2),0).
% … y asi para todas las filas
entradasVendidas(mostrosDelRock,plateaNumerada(10),25).
entradasVendidas(mostrosDelRock,plateaGeneral(zona1),300).
entradasVendidas(mostrosDelRock,plateaGeneral(zona2),500).

plusZona(hipodromo, zona1, 55).
plusZona(hipodromo, zona2, 20).
plusZona(granRex, zona1, 45).
plusZona(granRex, zona2, 30).
plusZona(aerodromo, zona1, 25).

%Se pide desarrollar los siguientes predicados de modo que sean totalmente inversibles.

%1)  estaDeModa/1. Se cumple para las bandas recientes (que surgieron en los últimos 5 años) que tienen una popularidad mayor a 70.
%?- estaDeModa(Banda).
%Banda = tanBionica ;
%Banda = pharrellWilliams.

estaDeModa(Banda):-
    banda(Banda, Ano, _, Popularidad),
    Popularidad>70,
    anioActual(AnoActual),
    AnoActual-Ano<5.

%2) esCareta/1. Se cumple para todo festival que cumpla alguna de las siguientes condiciones:
%
%que participen al menos 2 bandas que estén de moda.
%que no tenga entradas razonables (ver punto 3).
%si toca Miranda.
%?- esCareta(Festival).
%Festival = personalFest ;
%Festival = ...

esCareta(Festival):-
    festival(Festival, _, Bandas, _),
    member(miranda, Bandas).
esCareta(Festival):-
    festival(Festival, _, Bandas, _),    
    findall(Bandas, (estaDeModa(BandaDeModa), member(BandaDeModa, Bandas)),ListaDeModaDelFestival),
    length(ListaDeModaDelFestival, Cantidad),
    Cantidad>=2.
esCareta(Festival):-
    not(entradaRazonable(Festival, _)).
%
%3) entradaRazonable/2. Relaciona un festival con una entrada del mismo si se cumple:
%
%para la platea general, si el plus de la zona es menos del 10% del precio de la entrada.
%para campo, el precio de la entrada es menor a la popularidad total del festival. La popularidad total es la suma de la popularidad de todas las bandas que participan.
%para la platea numerada, si ninguna de las bandas que tocan está de moda, el precio no puede superar los $750; de lo contrario, el precio deberá ser menor a la capacidad del estadio /
%la popularidad total del festival.
%Los precios de las distintas entradas se calculan de la siguiente forma:
%
%precio de campo: Es el precio base del festival.
%precio de platea numerada: Precio base + 200 / número de fila.
%precio de platea general: El precio base + plus de la zona.
%?- entradaRazonable(Festival,Entrada).
%
%Festival=lulapaluza,
%
%Entrada=plateaGeneral(zona2);
%
%Festival=...
%
entradaRazonable(Festival, plateaGeneral(Zona)):-
    festival(Festival, lugar(Lugar,_), _, PrecioBase),
    plusZona(Lugar, Zona, PlusZona),
    ((PrecioBase+PlusZona)*0.1)>PlusZona.
entradaRazonable(Festival, campo):-
    festival(Festival, _, Bandas, PrecioBase),
    findall(Popularidad, (banda(Nombre,_, _, Popularidad), member(Nombre, Bandas)), TodasLasPopularidades),
    sum_list(TodasLasPopularidades, TotalPopularidad),
    TotalPopularidad>PrecioBase.
entradaRazonable(Festival, plateaNumerada(N)):-
    between(1, 10, N),
    festival(Festival, _, Bandas, PrecioBase),
    forall(member(Nombre, Bandas), not(estaDeModa(Nombre))),
    Precio is (PrecioBase + 200) / N,
    Precio < 750.

entradaRazonable(Festival, plateaNumerada(N)):-
    between(1, 10, N),
    festival(Festival, lugar(_, Capacidad), Bandas, PrecioBase),
    findall(Popularidad, (banda(Nombre,_, _, Popularidad), member(Nombre, Bandas)), TodasLasPopularidades),
    sum_list(TodasLasPopularidades, TotalPopularidad),
    Precio is (PrecioBase + 200) / N,
    Precio < (Capacidad / TotalPopularidad).

%campo(festival(Nombre, _, _, PrecioBase), PrecioBase).
%plateaNumerada(festival(Nombre, _, _, PrecioBase), PrecioBase+200/NumDeFila).
%plateaGeneral(festival(Nombre, _, _, PrecioBase), PrecioBase+PlusZona).


%4) nacanpop/1. Se cumple para un festival si todas las bandas que participan del mismo son nacionales y alguna de
%sus entradas disponibles es razonable.
%
%?- nacandpop(Festival).
%Festival =cosquinRock.
%

nacandpop(Festival):-
    festival(Festival, _, Bandas, _),
    forall(member(Nombre, Bandas), banda(Nombre, _, ar, _)),
    entradaRazonable(Festival, _).


%5) recaudacion/2. Relaciona un festival con su recaudación, que se calcula como la suma del precio de todas las entradas vendidas 
%(multiplicar el valor de una entrada por la cantidad vendida de la misma).
%?- recaudacion(Festival,Total).
%Festival = lulapaluza,
%Total = 567000 ;

% Predicado principal que relaciona un festival con su recaudación total.
recaudacion(Festival, RecaudacionTotal) :-
    festival(Festival, _, _, PrecioBase),
    findall(RecaudacionParcial, 
            (entradasVendidas(Festival, Entrada, Cantidad),
             precioEntrada(Festival, Entrada, PrecioBase, PrecioEntrada),
             RecaudacionParcial is PrecioEntrada * Cantidad),
            RecaudacionesParciales),
    sum_list(RecaudacionesParciales, RecaudacionTotal).

% Predicado auxiliar que calcula el precio de una entrada en función del tipo.
precioEntrada(_, campo, PrecioBase, PrecioBase).
precioEntrada(Festival, plateaGeneral(Zona), PrecioBase, PrecioEntrada) :-
    festival(Festival, lugar(Lugar, _), _, _),
    plusZona(Lugar, Zona, Plus),
    PrecioEntrada is PrecioBase + Plus.
precioEntrada(_, plateaNumerada(Fila), PrecioBase, PrecioEntrada) :-
    PrecioEntrada is PrecioBase + 200 / Fila.
% entradasVendidas(nombreDelFestival, tipoDeEntrada, cantidadVendida).
% tipos de entrada: campo, plateaNumerada(numero de fila), plateaGeneral(zona).

%precio de campo: Es el precio base del festival.
%precio de platea numerada: Precio base + 200 / número de fila.
%precio de platea general: El precio base + plus de la zona.

%Festival = mostrosDelRock,
%
%Total = 20879500 ...
%
%
%6) estaBienPlaneado/1. Se cumple si las bandas que participan van creciendo en popularidad, y la banda que cierra el festival (es decir, la última) es legendaria.
%Una banda es legendaria cuando surgió antes de 1980, es internacional y tiene una popularidad mayor a la de todas las bandas de moda.
%
%?- estaBienPlaneado(Festival).
%Festival=mostrosDelRock.

estaBienPlaneado(Festival):-
    festival(Festival, _, Banda, _),
    estaEnOrden(Banda),
    ultimoElemento(Banda, Cierre),
    legendaria(Cierre).

estaEnOrden(Banda):-
    findall(Popularidad, (member(Nombre, Banda), banda(Nombre, _, _, Popularidad)), ListaDePopularidades),
    ordenado(ListaDePopularidades).

legendaria(Banda):-
    banda(Banda, Ano, Nacion, Popularidad),
    Ano<1980,
    Nacion\=ar,
    findall(Pop, (estaDeModa(BandaDeModa), banda(BandaDeModa, _, _, Pop)), PopularidadesDeModa),
    max_list(PopularidadesDeModa, MaxPopularidadDeModa),
    Popularidad > MaxPopularidadDeModa.

ordenado([]).               
ordenado([_]).              
ordenado([X, Y | Resto]) :- 
    X =< Y,                 
    ordenado([Y | Resto]).  
    
ultimoElemento([X], X). 
ultimoElemento([_|T], UltimoElemento) :-
    ultimoElemento(T, UltimoElemento).