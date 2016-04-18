:- module(spanish).

sentence(s(S,V,O)) --> subject(S), verb(V), object(O).

subject(sb(M,N)) --> modifier(M, G), noun(N, G).

object(ob(M,N)) --> modifier(M, G), noun(N, G).

modifier(m(the),m) --> [el].
modifier(m(the),f) --> [la].

noun(n(dog),m) --> [perro].
noun(n(cow),f) --> [vaca].

verb(v(chases)) --> [caza].
verb(v(eats)) --> [come].

:- end_module(spanish).