-module(example_server_connection_sup).
-beheviour(supervisor).

-export([start_link/1, init/1]).

start_link(Port) when is_integer(Port) ->
	Id_server_connection_sup = list_to_atom("example_server_connection_sup_" ++ integer_to_list(Port)),
	supervisor:start_link({local, Id_server_connection_sup}, ?MODULE, Port).

init(Port) when is_integer(Port) ->
	_Id_server_connection_gen = list_to_atom("example_server_connection_" ++ integer_to_list(Port)),
	{ok, {{simple_one_for_one, 0, 1},
		[{connection, {example_server_connection, start_link, [Port]},
			temporary, 2000, worker, [example_server_connection]}]}}.
