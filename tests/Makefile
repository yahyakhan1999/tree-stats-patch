entries = no-arg L-option

all:
	@echo "***** tests are launched ******"
	@for entry in $(entries); do bash $${entry}/test.sh; done
	@echo "***** tests were finished ******"

clean:
	@for entry in $(entries); do rm -f $${entry}/out; done
