-module(executor).
-export([start/2, rpc/2, swap_code/2]).

%   1st
%rpc(Mod, Val) -> Mod:handle(Val).

%   2nd / 3rd
start(Name, Mod) ->
    register(Name, spawn(fun() -> loop(Name, Mod) end)).

%   2nd / 3rd
rpc(Name, Request) ->
    Name ! {self(), Request},
    receive
        {Name, Response} -> Response
    end.

%   2nd / 3rd
loop(Name, Mod) ->
    receive
        {From, {swap_code, Request}} ->
            From ! {Name, ack},
            loop(Name, Request);
        {From, Request} ->
            {Response} = Mod:handle(Request),
            From ! {Name, Response},
            loop(Name, Mod)
    end.

%   3rd
swap_code(Name, Mod) -> rpc(Name, {swap_code, Mod}).