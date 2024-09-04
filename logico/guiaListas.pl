%Ejercicio 1: Verificar si un elemento está en una lista
member(Valor, Lista).
%Ejercicio 2: Encontrar la longitud de una lista
lenght(Lista, Longitud).
%Ejercicio 3: Concatenar dos listas
append(ListaOriginal, ListaAConcatenar).
%Ejercicio 4: Invertir una lista
reverse(ListaAInvertir, ListaInversa).
%Ejercicio 5: Eliminar un elemento de una lista
select(ElementoAEliminar, ListaOriginal, ListaNueva).
%Ejercicio 6: Encontrar el último elemento de una lista
ultimoElemento([X], X).
ultimoElemento([_|T], UltimoElemento) :-
    ultimoElemento(T, UltimoElemento).
%Ejercicio 7: Dividir una lista en cabeza y cola
dividirLista([H|T], H, [T]).
%Ejercicio 8: Duplicar los elementos de una lista
duplicarLista(ListaOriginal, ListaFinal):-
    append(ListaOriginal,ListaOriginal, ListaFinal).
%Ejercicio 9: Sumar los elementos de una lista de números
sum_list(Lista, Resultado).
%Ejercicio 10: Verificar si una lista es un palíndromo
palindromo(Lista):-
    reverse(Lista, ListaInversa),
    Lista=ListaInversa.

ordenado([]).               % Una lista vacía está ordenada.
ordenado([_]).              % Una lista con un solo elemento está ordenada.
ordenado([X, Y | Resto]) :- % Para listas con al menos dos elementos:
    X =< Y,                 % El primer elemento debe ser menor o igual al segundo.
    ordenado([Y | Resto]).  % Luego, verificar si el resto de la lista está ordenado.