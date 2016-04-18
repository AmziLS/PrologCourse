% get_slot(FRAME_TYPE, FRAME_NAME, SLOT_NAME, VALUE)

get_slot(FRAME, NAME, SLOT, VAL) :-
   F =.. [FRAME,NAME,SLOTS],
   call(F),
   member(SLOT = VAL, SLOTS).

