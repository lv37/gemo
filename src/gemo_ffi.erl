-module(gemo_ffi).
-export([apply_tuple/2, table_size/1, table_count/1]).

apply_tuple(Cb, Args) ->
	apply(Cb, tuple_to_list(Args)).

table_size(Table) ->
	erlang:max(ets:info(Table,memory) - 305, 0) * erlang:system_info(wordsize).

table_count(Table) ->
	ets:info(Table,size).
