% =========================
% WORLD SETUP
% =========================

% These are things that are allowed to change while the programme is running.

:- dynamic agent_at/2.
:- dynamic dirt_at/2.
:- dynamic facing/1.
:- dynamic has_dirt/0.


% -------------------------
% Initial state
% -------------------------

agent_at(1,2).
facing(east).

liquid_at(2,3).

stairs_at(4,4).

dirt_at(4,1).

furniture1_at(2,4).

furniture2_at(3,3).


% =========================
% GRID ADJACENCY (PURE FACTS)
% =========================
% 4x4 grid, no arithmetic

adjacent(1,1,2,1). adjacent(2,1,1,1).
adjacent(2,1,3,1). adjacent(3,1,2,1).
adjacent(3,1,4,1). adjacent(4,1,3,1).

adjacent(1,2,2,2). adjacent(2,2,1,2).
adjacent(2,2,3,2). adjacent(3,2,2,2).
adjacent(3,2,4,2). adjacent(4,2,3,2).

adjacent(1,3,2,3). adjacent(2,3,1,3).
adjacent(2,3,3,3). adjacent(3,3,2,3).
adjacent(3,3,4,3). adjacent(4,3,3,3).

adjacent(1,4,2,4). adjacent(2,4,1,4).
adjacent(2,4,3,4). adjacent(3,4,2,4).
adjacent(3,4,4,4). adjacent(4,4,3,4).

adjacent(1,1,1,2). adjacent(1,2,1,1).
adjacent(1,2,1,3). adjacent(1,3,1,2).
adjacent(1,3,1,4). adjacent(1,4,1,3).

adjacent(2,1,2,2). adjacent(2,2,2,1).
adjacent(2,2,2,3). adjacent(2,3,2,2).
adjacent(2,3,2,4). adjacent(2,4,2,3).

adjacent(3,1,3,2). adjacent(3,2,3,1).
adjacent(3,2,3,3). adjacent(3,3,3,2).
adjacent(3,3,3,4). adjacent(3,4,3,3).

adjacent(4,1,4,2). adjacent(4,2,4,1).
adjacent(4,2,4,3). adjacent(4,3,4,2).
adjacent(4,3,4,4). adjacent(4,4,4,3).

%==============================
% DEFINE VALID SQUARES
%==============================
square(1,1). square(2,1). square(3,1). square(4,1).
square(1,2). square(2,2). square(3,2). square(4,2).
square(1,3). square(2,3). square(3,3). square(4,3).
square(1,4). square(2,4). square(3,4). square(4,4).

% =========================
% DERIVED PREDICATES
% =========================

% A square is moist if it is adjacent to the liquid hazard
moist(X,Y) :-
    liquid_at(LX,LY),
    adjacent(X,Y,LX,LY).

% A square has edge warning if it is adjacent to stairs

edge_warning(X,Y) :-
    stairs_at(SX,SY),
    adjacent(X,Y,SX,SY).

% Rubble is adjacent to the dirt square

rubble(X,Y) :-
    dirt_at(DX,DY),
    adjacent(X,Y,DX,DY).

% =========================
% PERCEPTION (GROUPED)
% =========================

perceive(moisture) :-
    agent_at(X,Y),
    moist(X,Y).

perceive(edge) :-
    agent_at(X,Y),
    edge_warning(X,Y).

perceive(rubble) :-
    agent_at(X,Y),
    rubble(X,Y).

% =========================
% SAFETY
% =========================

safe(X,Y) :-
    square(X,Y),
    \+ liquid_at(X,Y),
    \+ stairs_at(X,Y),
    \+ furniture1_at(X,Y),
	\+ furniture2_at(X,Y).

%=========================
% MOVEMENT
%=========================


move(X,Y) :-
    retract(agent_at(_,_)),
    assert(agent_at(X,Y)),
    format('Moved to (~w,~w)~n', [X,Y]).
    

valid_move(AX, AY, NX, NY, Visited) :-
    adjacent(AX, AY, NX, NY),
    safe(NX, NY),
    \+ member([NX,NY], Visited). %Checks if (NX,NY) has been visited yet

% =========================
% PERCEPTION OUTPUT
% =========================

perceive_all :-
    agent_at(X,Y),
    ( moist(X,Y) ; edge_warning(X,Y) ; rubble(X,Y) ),
    !,
    ( moist(X,Y) -> writeln('Agent senses moisture') ; true ),
    ( edge_warning(X,Y) -> writeln('Agent senses edge warning') ; true ),
    ( rubble(X,Y) -> writeln('Agent senses rubble') ; true ).

perceive_all :-
    writeln('Nothing to perceive').

% =========================
% DIRT PICKUP
% =========================

pickup_dirt :-
    agent_at(X,Y),
    dirt_at(X,Y),
    retract(dirt_at(X,Y)),
    assert(has_dirt),
    writeln('Picked up dirt!').

pickup_dirt :- true.

%==========================
% AGENT STATE
%==========================

agent_view :-
    agent_at(X,Y),
    format('Agent at (~w,~w)~n', [X,Y]),
    perceive_all.
   
%=========================
% MAIN LOOP
%=========================

%if agent is on dirt
loop(_) :-
    agent_at(X, Y),
    dirt_at(X, Y),
    !,
    pickup_dirt,
    writeln('Found the dirt! Game over.'),
    !.

%if agent is on liquid
loop(_) :-
    agent_at(X,Y),
    liquid_at(X,Y),
    !,
    writeln('Robot died from liquid hazard.').

%if agent is on valid square
loop(Visited) :-
    agent_at(AX, AY), %current position
    valid_move(AX, AY, NX, NY, Visited), %look for valid square
    !,
    move(NX, NY),
    perceive_all,
    loop([[NX,NY]|Visited]). %add (NX,NY) to visited and repeat

%if agent is stuck
loop(_) :-
    writeln('No valid moves left - agent is stuck!').

run :-
    agent_view,
    loop([]).

	
