-module(game_server).

-behaviour(gen_server).

-export([start_link/1, handle_call/3, handle_cast/2]).
-export([init/1, move/2]).

start_link({W, H, Players}) ->
    gen_server:start_link(game_server, {W, H, Players}, []).

% Abstraction to make a move.
move(Pid, Wall) ->
    gen_server:call(Pid, {move, Wall}).


% TODO: You need to inform the first player to move.
init({Width, Height, Players}) ->
    Grid = grid:new(Width, Height),
    hd(Players) ! {move, self(), Grid},
    {ok, {Grid, Players}}.

% TODO: add handle_call for move.
handle_call({move, Wall}, _From, {Grid, Players}) ->
    Score = 1,

    case length(grid:get_open_spots(Grid)) > 0 of
        true -> 
            Grid2 = grid:add_wall(Wall, Grid),
            {reply, {ok, Score}, {Grid2, Players}};
        false -> 
            hd(Players) ! finished
    end;

    % {reply, {ok, Score}, State};

    % 1. Muur aanmaken
    % 2. Zijn er nog plekken over?
    %   - Ja : OK
    
    %   - Nee: Finished
    

% Used for testing.
handle_call(state, _From, State) ->
    {reply, {ok, State}, State};
handle_call({setWalls, Walls}, _From, {{W, H, _}, Players}) ->
    {reply, ok, {{W, H, Walls}, Players}}.

% Required for gen_server behaviour.
% Normally you would implement this too,
% but not required for this assignment.
handle_cast(_, State) ->
    {reply, not_implemented, State}.
