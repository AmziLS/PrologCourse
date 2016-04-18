% Use DCG to create a parse tree
%
% ?- sentence( S, [the, cat, chases, the, mouse], [] ).
% ?- noun(N, L1, L2).
% ?- subject(S, L1, L2).

sentence( sentence(S,V,O) ) -->
  subject(S),
  verb(V),
  object(O).
  
subject( subject(M,N) ) -->
  modifier(M),
  noun(N).
  
object( object(M,N) ) -->
  modifier(M),
  noun(N).

modifier( mod(the) ) --> [the].

noun( noun(cat) ) --> [cat].
noun( noun(mouse) ) --> [mouse].
noun( noun('polar bear') ) --> [polar, bear].

verb( verb(chases) ) --> [chases].
verb( verb(eats) ) --> [eats].
