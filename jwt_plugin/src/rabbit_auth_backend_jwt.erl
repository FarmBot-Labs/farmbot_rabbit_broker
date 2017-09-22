%% The contents of this file are subject to the Mozilla Public License
%% Version 1.1 (the "License"); you may not use this file except in
%% compliance with the License. You may obtain a copy of the License
%% at http://www.mozilla.org/MPL/
%%
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and
%% limitations under the License.
%%
%% The Original Code is RabbitMQ HTTP authentication.
%%
%% The Initial Developer of the Original Code is VMware, Inc.
%% Copyright (c) 2007-2017 Pivotal Software, Inc.  All rights reserved.
%%

-module(rabbit_auth_backend_jwt).

-include_lib("rabbit_common/include/rabbit.hrl").

-behaviour(rabbit_authn_backend).
-behaviour(rabbit_authz_backend).

-export([description/0]).

-export([user_login_authentication/2, user_login_authorization/1,
         check_vhost_access/3, check_resource_access/3, check_topic_access/4]).

%%--------------------------------------------------------------------

description() ->
    [{name, <<"JWT">>},
     {description, <<"JWT authentication / authorisation">>}].

%%--------------------------------------------------------------------

%% Decide if the user gave us a valid JWT.
% user_login_authentication(Username, AuthProps) ->
%   % Step 1: Validate that the JWT is is real.
%   % io:fwrite("authn: ~s ~w\n\n", [Username, AuthProps]),
%   {password, Jwt} = lists:keyfind(password, 1, AuthProps),
%
%   case rabbit_auth_backend_jwt_decoder:decode(Jwt) of
%     {ok, _Bot} -> {ok, #auth_user{username = Username, tags = [], impl = none}};
%     {error, reason} -> {refused, reason, []}
%   end.

user_login_authentication(Username, _AuthProps) -> {ok, #auth_user{username = Username, tags = [], impl = none}}.

user_login_authorization(Username) ->
  % io:fwrite("authz: ~s\n\n", [Username]),
  case user_login_authentication(Username, []) of
      {ok, #auth_user{impl = Impl}} -> {ok, Impl};
      Else                          -> Else
  end.

check_vhost_access(_AuthUser, Vhost, _) ->
  case Vhost of
    <<"/">> -> true;
    _   -> false
  end.

% check_resource_access(#auth_user{username = Username},
%                       #resource{virtual_host = _VHost, kind = Type, name = Name},
%                       Permission) ->
%   io:fwrite("resource access: user: ~s, type: ", [Username])

check_resource_access(AuthUser, Resource, Permission) ->
  io:fwrite("resource access: ~w ~w ~w\n\n", [AuthUser, Resource, Permission]),
  true.

check_topic_access(AuthUser, Resource, Permission, Context) ->
  io:fwrite("topic access: ~w ~w ~w ~w\n\n", [AuthUser, Resource, Permission, Context]),
  true.

%%--------------------------------------------------------------------
