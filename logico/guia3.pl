vende(Articulo, Precio).
vende(libro(Titulo, Autor, Genero, Editorial), Precio).
vende(cd(Titulo, Autor, Genero, CantDeDisco, CandDeCanc), Precio).
vende(pelicula(Titulo, Director, Genero), Precio).

tematica(Autor):-
    autor(_, Autor).
    forall(vende(Articulo, Precio), autor(Articulo, Autor)).

autor(libro(Titulo, Autor, Genero, Editorial), Autor):-
    vende(libro(Titulo, Autor, Genero, Editorial),Precio).
autor(cd(Titulo, Autor, Genero, CantDeDisco, CandDeCanc), Autor):-
    vende(cd(Titulo, Autor, Genero, CantDeDisco, CandDeCanc), Precio).


titulo(libro(Titulo, Autor, Genero, Editorial), Titulo):-
    vende(libro(Titulo, Autor, Genero, Editorial),Precio).
titulo(cd(Titulo, Autor, Genero, CantDeDisco, CandDeCanc), Titulo):-
    vende(cd(Titulo, Autor, Genero, CantDeDisco, CandDeCanc), Precio).
titulo(pelicula(Titulo, Director, Genero), Titulo):-
    vende(pelicula(Titulo, Director, Genero), Precio).
    

libroMasCaro(libro(Titulo, Autor, Genero, Editorial)):-
    vende(libro(Titulo, Autor, Genero, Editorial), Precio),
    forall(vende(libro(_, _, _, _), OtroPrecio), Precio=>OtroPrecio).
curiosidad(Articulo):-
    vende(Articulo,_),
    autor(Articulo,Autor),
    not((vende(Otro,_), autor(Otro, Autor), Otro\=Articulo)).
sePrestaAConfusion(Titulo):-
    titulo(UnArticulo, Titulo),
    titulo(OtroArticulo, Titulo),
    UnArticulo\=OtroArticulo.
mixto(Autor):-
    autor(libro(Titulo, Autor, Genero, Editorial), Autor),
    autor(cd(Titulo, Autor, Genero, CantDeDisco, CandDeCanc), Autor).

