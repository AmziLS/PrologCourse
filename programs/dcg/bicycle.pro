% Bill of materials for making a bicycle.
% A bill of materials is really a grammar.
% ?- bike(X,[]).
% X = [frame, crank, pedal, pedal, chain,
%       spokes, rim, hub, spokes, rim, hub] 
% yes
% 
% ?- wheel(X,[]).
% X = [spokes, rim, hub] 
% yes

bike --> frame, drivechain, wheel, wheel.

wheel --> spokes, rim, hub.

drivechain --> crank, pedal, pedal, chain.

spokes --> [spokes].
crank --> [crank].
pedal --> [pedal].
chain --> [chain].
rim --> [rim].
hub --> [hub].
frame --> [frame].