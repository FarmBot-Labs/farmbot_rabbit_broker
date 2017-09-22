-module(rabbit_auth_backend_jwt_decoder).

-export([decode/1]).

decode(JwtBin) ->
  %% check alg header
  [HeaderBin, _, _] = binary:split(JwtBin, <<".">>, [global]),
  #{<<"typ">> := _Type, <<"alg">> := Alg} = maps:from_list(jsx:decode(base64:decode(HeaderBin))),
  case Alg of
    %% If it is the correct alg, move on.
    <<"RS256">> ->
      {ok, RSAKey} = rabbit_auth_backend_jwt_pub_key_fetcher:fetch(),
      case jwt:decode(JwtBin, RSAKey) of
        {ok, Claims} -> {ok, maps:get(<<"bot">>, Claims)};
        Err -> Err
      end;
  %% Error if it isn't.
    _other -> {error, "bad alg."}
  end.
