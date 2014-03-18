-RELEASE_DIR := out/release/
-COVERAGE_DIR := out/test/
-RELEASE_COPY := lib
-COVERAGE_COPY := lib tests


-BIN_MOCHA := ./node_modules/.bin/mocha
-BIN_COFFEE := ./node_modules/coffee-script/bin/coffee
-BIN_ISTANBUL := ./node_modules/.bin/istanbul

-TESTS := $(shell find tests -type f -name test-*)
-JS_TESTS := $(patsubst %.coffee, %.js, $(-TESTS))

-COFFEE_LIB := $(shell find lib -type f -name '*.coffee')
-COFFEE_TEST := $(shell find tests -type f -name 'test-*.coffee')

-COFFEE_RELEASE := $(addprefix $(-RELEASE_DIR),$(-COFFEE_LIB) )

-COFFEE_COVERAGE := $(-COFFEE_LIB)
-COFFEE_COVERAGE += $(-COFFEE_TEST)
-COFFEE_COVERAGE := $(addprefix $(-COVERAGE_DIR),$(-COFFEE_COVERAGE) )

-COVERAGE_FILE := coverage.html
-COVERAGE_TESTS := $(addprefix $(-COVERAGE_DIR),$(-TESTS))
-COVERAGE_TESTS := $(-COVERAGE_TESTS:.coffee=.js)

default: dev


dev: clean
	@$(-BIN_MOCHA) \
		--colors \
		--compilers coffee:coffee-script \
		--reporter list \
		--growl \
		$(-TESTS)

test: clean
	@$(-BIN_MOCHA) \
		--compilers coffee:coffee-script \
		--reporter tap \
		$(-TESTS)

release: dev
	@echo 'copy files'
	@mkdir -p $(-RELEASE_DIR)
	@cp -r $(-RELEASE_COPY) $(-RELEASE_DIR)

	@echo "compile coffee-script files"
	@$(-BIN_COFFEE) -cb $(-COFFEE_RELEASE)
	@rm -f $(-COFFEE_RELEASE)

	@echo "all codes in \"$(-RELEASE_DIR)\""


test-cov: clean
	@echo 'copy files'
	@mkdir -p $(-COVERAGE_DIR)
	@cp -r $(-COVERAGE_COPY) $(-COVERAGE_DIR)

	@echo "compile coffee-script files"
	@$(-BIN_COFFEE) -cb $(-COFFEE_COVERAGE)
	@rm -f $(-COFFEE_COVERAGE)

	@echo "generate coverage files"
	@echo $(-JS_TESTS)
	# @cd out/test && \
	#   $(-BIN_ISTANBUL) cover ./node_modules/.bin/_mocha -- -u exports -R tap $(-JS_TESTS) && \
	#   $(-BIN_ISTANBUL) report html

.-PHONY: default

clean:
	@echo 'clean'
	@-rm -fr out
	@-rm -f coverage.html


