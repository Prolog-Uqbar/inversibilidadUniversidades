% Válido, pero muy trivial
argentinaCampeon.

% HECHOS
universidadPublica(utn).
universidadPublica(unahur).
universidadPublica(uba).

universidad(uade).
universidad(uca).
universidad(utn).
universidad(unahur).
universidad(uba).

universidadPrivada(U):-universidad(U),not(universidadPublica(U)).
% HECHOS. RELACIONES.
trabaja(tito, utn,   250000).
trabaja(dani, utn,   990000).
trabaja(tito, acme, 2000000).
trabaja(dani, uba,   500000).
trabaja(lalo, inti,  800000).
trabaja(pelu, bit,  5000000).
trabaja(lola, acme,  200000).

empleo(inti, publico).
empleo(acme, privado).
empleo(garrahan, publico).
empleo(bit, privado).

% REGLAS. "Y" 
universitario(Persona):-
    trabaja(Persona,Trabajo,_),
    universidadPublica(Trabajo).

docenteEn(Persona,Universidad):-
    universidadPublica(Universidad),
    trabaja(Persona,Universidad,_).

% REGLAS. "O"
esPublico(Trabajo):-empleo(Trabajo,publico).
esPublico(Trabajo):-universidadPublica(Trabajo).

trabajadorEstatal(Persona):-
    trabaja(Persona,Trabajo,_),
    esPublico(Trabajo).


%% INVERSIBILIDAD 
sabe(rambo, sobrevivir).
sabe(rambo, escaparse ).
sabe(mcgiver, _).
%sabe(_, silbar).

multiEmpleo(Persona):-
    trabaja(Persona,Trabajo1,_),
    trabaja(Persona,Trabajo2,_),
    Trabajo1 \= Trabajo2.

companieros(Persona1,Persona2):-
    trabaja(Persona1,Trabajo,_),
    trabaja(Persona2,Trabajo,_),
    Persona1 \= Persona2.
    
% ARITMETICA

mayor(3,2).
mayor(4,2).

ganaBien(Persona):-
    trabaja(Persona,_,Sueldo),
    Sueldo >= 1000000.

ganaBienEnLaUniversidad(Persona):-
    trabaja(Persona,Trabajo,Sueldo),
    universidadPublica(Trabajo),
    Sueldo >= 1000000.

pareceQueGanaBienEnLaUniversidad(Persona):-
    ganaBien(Persona),
    universitario(Persona).
    
muchaDiferenciaSueldo(Persona,Diferencia):-
    trabaja(Persona,_,SueldoMayor),
    trabaja(Persona,_,SueldoMenor),
    Diferencia is SueldoMayor - SueldoMenor,
    Diferencia > SueldoMenor.

% NEGACION
universidadSinTrabajadores(Universidad):-
    universidadPublica(Universidad),
    not(trabaja(_,Universidad,_)).

sueldoReferencia(1000000).

seGanaMalEn(Trabajo):-
    trabaja(_,Trabajo,Sueldo),
    sueldoReferencia(Referencia),
    Sueldo < Referencia.

seGanaBienEn(Trabajo):-
    trabaja(_,Trabajo,Sueldo),
    sueldoReferencia(Referencia),
    Sueldo >= Referencia.
    
seguroSeGanaBienEn(Trabajo):-
    seGanaBienEn(Trabajo),
    not(seGanaMalEn(Trabajo)).

trabajaFueraUniversidad(Persona):-
    trabaja(Persona,Trabajo,_),
    not(universidadPublica(Trabajo)).

soloDocente2(Persona):-
    trabaja(Persona,_,_),
    not(trabajaFueraUniversidad(Persona)).

% CUANTIFICACION
soloDocente(Persona):-
    trabaja(Persona,_,_),
    forall(trabaja(Persona,Trabajo,_), universidadPublica(Trabajo)).

todosGananBienEn(Trabajo):-
    trabaja(_,Trabajo,_),
    sueldoReferencia(Referencia),
    forall(trabaja(_,Trabajo,Sueldo), Sueldo > Referencia).

nn:-
    trabaja(Persona,Trabajo,_),
    sueldoReferencia(Referencia),
    forall(trabaja(Persona,Trabajo,Sueldo), Sueldo > Referencia).


mayorSueldo(Persona,Trabajo,Sueldo):-
    trabaja(Persona,Trabajo,Sueldo),
    forall( trabaja(_,_,OtroSueldo) ,  Sueldo >= OtroSueldo ).

mayorSueldo2(Persona,Trabajo,Sueldo):-
    trabaja(Persona,Trabajo,Sueldo),
    not(( trabaja(_,_,OtroSueldo) , Sueldo < OtroSueldo )).
    