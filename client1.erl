-module(client1).
-export([handle/1, hello/0]).

%   3rd
hello() -> executor:rpc(client, hello).

%   3rd
handle(Request) ->
    if 
        Request =:= hello -> {"Hola Amigo"};
        true -> {"adios"}
    end.
