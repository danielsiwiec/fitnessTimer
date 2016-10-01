include props.mk

sources = `find source -name '*.mc'`
resources = `find resources -name '*.xml' | tr '\n' ':' | sed 's/.$$//'`
resources-vivo = `find resources-vivoactive_hr -name '*.xml' | tr '\n' ':' | sed 's/.$$//'`
SDK_HOME = /Users/dsiwiec/connectiq-sdk-mac-2.1.3
PRIVATE_KEY = /Users/dsiwiec/.ssh/id_rsa_garmin.der

build:
	$(SDK_HOME)/bin/monkeyc --warn --output bin/$(APPNAME).prg -m manifest.xml \
	-z $(resources):$(resources-vivo) -d $(DEVICE)_sim -u $(SDK_HOME)/bin/devices.xml \
	-p $(SDK_HOME)/bin/projectInfo.xml -y $(PRIVATE_KEY) $(sources)

run: build
	$(SDK_HOME)/bin/connectiq &&\
	sleep 3 &&\
	$(SDK_HOME)/bin/monkeydo bin/$(APPNAME).prg $(DEVICE)

deploy: build
	cp bin/$(APPNAME).prg /Volumes/GARMIN/GARMIN/APPS/

package:
	$(SDK_HOME)/bin/monkeyc --warn --output bin/$(APPNAME).iq -m manifest.xml \
	-z $(resources):$(resources-vivo) -u $(SDK_HOME)/bin/devices.xml \
	-p $(SDK_HOME)/bin/projectInfo.xml $(sources) -e -r -y $(PRIVATE_KEY)
