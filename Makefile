default: schema.stamp

default:
	teitorelaxng --odd pureodd.odd pureodd.rng
	trang pureodd.rng pureodd.rnc
	saxon -o:pureodd-examples.odd -s:pureodd.odd -xsl:odd2exodd.xsl 
	teitorelaxng --odd pureodd-examples.odd pureodd-examples.rng
	saxon -o:P5-new.xml -s:P5.xml -xsl:convert.xsl

showconvert:
	saxon P5.xml showconvert.xsl | xmllint --format - > showconverted.xml
	teitohtml --css=tei.css showconverted.xml  

testrng:
	rm -f Schema/*
	saxon P5-new.xml pureoddtorelaxng.xsl outputDir=Schema
	jing test.rng testall.xml

testdtd:
	rm -f DTD/*
	saxon P5-new.xml pureoddtodtd.xsl outputDir=DTD
	xmllint --noout --valid testall-withdtd.xml

testodd:
	teitorelaxng --localsource=`pwd`/P5-new.xml pureodd-test.odd pureodd-test.rng
	trang pureodd-test.rng pureodd-test.rnc
	-jing -c pureodd-test.rnc pureodd-test.xml
	teitodtd --localsource=`pwd`/P5-new.xml pureodd-test.odd pureodd-test.dtd
	-xmllint --noout --dtdvalid pureodd-test.dtd pureodd-test.xml
	trang pureodd-test.rng pureodd-test.xsd
	jing pureodd-test.xsd pureodd-test.xml

testall:
	teitorelaxng --localsource=`pwd`/P5-new.xml pureodd-all.odd pureodd-all.rng
	-jing pureodd-all.rng pureodd-test.xml
	trang pureodd-all.rng pureodd-all.rnc
	teitodtd --localsource=`pwd`/P5-new.xml pureodd-all.odd pureodd-all.dtd
	-xmllint --noout --dtdvalid pureodd-all.dtd pureodd-test.xml
