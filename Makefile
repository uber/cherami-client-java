all: test

.PHONY: test
test:
	mvn test

.PHONY: install_ci
install_ci:
	mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V

.PHONY: test_ci
test_ci:
	mvn verify -B -Dorg.eclipse.jetty.LEVEL=WARN

.PHONY: cover_ci
cover_ci:
	mvn clean -DTRAVIS_JOB_ID=$(TRAVIS_JOB_ID) cobertura:cobertura coveralls:report -Dorg.eclipse.jetty.LEVEL=WARN

.PHONY: release
release:
	@echo "please make sure you are using java 7."
	@read -p "Press any key to continue, or press Control+C to cancel. " x;
	mvn -Dbuild=release release:clean release:prepare
	mvn -Dbuild=release release:perform

.PHONY: package
package:
	mvn package

.PHONY: update_idl
update_idl:
	mvn antrun:run@update-idl

.PHONY: clean
clean:
	mvn clean
