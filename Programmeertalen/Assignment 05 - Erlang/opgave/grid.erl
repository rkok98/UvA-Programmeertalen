-module(grid).
-export([new/2, get_wall/3, add_wall/2, has_wall/2, show_hlines/2, show_vlines/2, print/1]).

% TODO: The other functions.
new(Width, Height) -> {Width, Height, []}.

get_wall(X, Y, Dir) ->
	case Dir of
		north -> {{X, Y - 1}, {X, Y}};
		east  -> {{X, Y}, {X + 1, Y}};
		south -> {{X, Y}, {X, Y + 1}};
		west  -> {{X - 1, Y}, {X, Y}};
		_	  -> no_dir
	end.

add_wall(Wall, Grid) ->
	{Width, Height, Walls} = Grid,
	
	case has_wall(Wall, Grid) of
		false -> {Width, Height, lists:sort([Wall | Walls])};
		true -> Grid
	end.

has_wall(Wall, Grid) -> 
	{_, _, Walls} = Grid,
	lists:member(Wall, Walls).

% TODO
show_hlines(Row, Grid) -> 
	{Width, Height, Walls} = Grid,
	%W = [W || {{_, Y}, {_, Y}} = W <- Walls, is_integer(Y), Y == Row],

	R = [draw_hline({{X, Row}, {X + 1, Row}}, Grid) || X <- lists:seq(1, Width)],

	"+" ++ lists:flatten(R) ++ "~n".


draw_hline(Wall, Grid) ->
	case has_wall(Wall, Grid) of
		true ->
			"--+";
		false ->
			"  +"
	end.

draw_vline(Wall, Grid) ->
	case has_wall(Wall, Grid) of
		true ->
			"  |";
		false ->
			"   "
	end.

% TODO
show_vlines(Row, Grid) ->
	{Width, Height, Walls} = Grid,
	R = [draw_vline({{X, Row}, {X, Row + 1}}, Grid) || X <- lists:seq(1, Width)],
	" " ++ lists:flatten(R) ++ "~n".

% Prints this grid in a structured format
% using the show_Xlines functions.
print(Grid) ->
	{_, H, _} = Grid,
	lists:map(fun(Row) ->
		io:fwrite(show_hlines(Row, Grid)),

		case Row < H of
			true ->
				io:fwrite(show_vlines(Row, Grid));
			false ->
				ok
		end
	end, lists:seq(0, H)),
	io:fwrite("~n"),
	ok.

% grid:print({5, 5, [{{1,2},{1,3}}, {{0,1},{1,1}}, {{1,1},{2,1}}, {{3,4},{4,4}}]}).