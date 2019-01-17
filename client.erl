-module(client).
-export([handle/1, hello/0]).

%   1st 
%   start() -> executor:rpc(client, "Hello").

%   1st 
%   handle(Val) -> io:format(Val).

%   2nd
hello() -> executor:rpc(client, hello).

%   2nd
handle(Request) ->
    if 
        Request =:= hello -> {"Hello"};
        true -> {"Bye"}
    end.