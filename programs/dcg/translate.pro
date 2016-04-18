:- consult(english).
:- consult(spanish).

translate(LANG_IN, LANG_OUT, SENTENCE, TRANSLATION) :-
  call( LANG_IN:sentence(MEANING, SENTENCE, []) ),
  call( LANG_OUT:sentence(MEANING, TRANSLATION, []) ).