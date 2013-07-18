all: deps compile

compile:
	@./rebar compile escriptize

deps:
	@./rebar get-deps

clean:
	@./rebar clean

distclean: clean
	@./rebar delete-deps
