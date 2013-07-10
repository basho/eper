VSN := $(shell erl -eval 'io:format("~s~n", [erlang:system_info(otp_release)]), init:stop().' | grep 'R' | sed -e 's,R\(..\)B.*,\1,')
NEW_HASH := $(shell expr $(VSN) \>= 16)

all: deps compile

compile:
ifeq ($(NEW_HASH),1)
	@./rebar compile -Dnew_hash escriptize
else
	@./rebar compile escriptize
endif

deps:
	@./rebar get-deps

clean:
	@./rebar clean

distclean: clean
	@./rebar delete-deps
