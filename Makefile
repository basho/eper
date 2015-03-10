REBAR = ./rebar

.PHONY: all compile test clean eunit xref release release_minor release_major

all: compile

compile:
	@$(REBAR) compile escriptize

clean:
	@find . -name "*~" -exec rm {} \;
	@$(REBAR) clean

test: compile eunit xref

eunit:
	@$(REBAR) eunit

xref: all
	@$(REBAR) xref

~/.dialyzer_plt:
	- dialyzer --output_plt ~/.dialyzer_plt --build_plt \
           --apps erts kernel stdlib crypto public_key inets eunit xmerl

docs:
	@./rebar doc skip_deps=true

dialyzer: ~/.dialyzer_plt
	dialyzer --plt ~/.dialyzer_plt -Wrace_conditions --src src

release_major: xref eunit
	./bin/release.sh major

release_minor: xref eunit
	./bin/release.sh minor

release: xref eunit
	./bin/release.sh patch
