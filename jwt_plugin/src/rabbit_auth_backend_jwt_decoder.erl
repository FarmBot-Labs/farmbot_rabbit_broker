-module(rabbit_auth_backend_jwt_decoder).

-export([decode/1]).
-export([find_alg/1]).

decode(JwtBin) ->
  %% check alg header

  case binary:split(JwtBin, <<".">>, [global]) of
    [HeaderBin, _, _] ->
      case find_alg(jsx:decode(base64:decode(HeaderBin))) of
        {ok, <<"RS256">>} ->
          {ok, RSAKey} = rabbit_auth_backend_jwt_pub_key_fetcher:fetch(),
          case jwt:decode(JwtBin, RSAKey) of
            {ok, Claims} -> {ok, maps:get(<<"bot">>, Claims)};
            Err -> Err
          end;
        {ok, _other} -> {error, "bad alg."};
        {error, Reason} -> {error, Reason}
      end;
    _ -> {error, "bad jwt."}
  end.

find_alg([{<<"alg">>, Alg} | _T]) ->
  {ok, Alg};

find_alg([_ | T]) ->
  find_alg(T);

find_alg([]) ->
  {error, "No alg."}.
