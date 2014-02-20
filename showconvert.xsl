<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.tei-c.org/ns/Examples"
		xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
		xmlns:rng="http://relaxng.org/ns/structure/1.0"
		exclude-result-prefixes="#all"
		version="2.0">

  <!-- this stylesheet converts rng content models in P5 into pure TEI
     per durandConundrum paper LB oct 2012-->
  <xsl:import href="tofoxglove.xsl"/>

  <xsl:output indent="yes"/>

 <xsl:template match="comment()"/>

  <xsl:template match="/">
    <TEI xmlns="http://www.tei-c.org/ns/1.0">
      <teiHeader>
	<fileDesc>
	  <titleStmt>
        <title>Testing the Glove </title>
        <author>Sebastian Rahtz</author>
      </titleStmt>
      <publicationStmt><p/></publicationStmt>
      <sourceDesc>
        <p>Written from scratch.</p>
      </sourceDesc>
    </fileDesc>
  </teiHeader>
  <text>
    <body>
      <table>
	<xsl:apply-templates select="//content">
	  <xsl:sort select="ancestor::*[@ident]/@ident"/>
	</xsl:apply-templates>
      </table>
    </body>
  </text>
    </TEI>
</xsl:template>

    <xsl:template match="content">
      <row xmlns="http://www.tei-c.org/ns/1.0">
	<cell>
	  <xsl:value-of select="ancestor::*[@ident]/@ident"/>
	</cell>
	<cell>
	  <egXML xmlns="http://www.tei-c.org/ns/Examples">
	    <xsl:copy-of select="*"/>
	  </egXML>
	</cell>
	<cell>
      <egXML xmlns="http://www.tei-c.org/ns/Examples">
	<xsl:variable name="m">
	<model>
	<xsl:if test=".//rng:text">
	  <xsl:attribute name="allowText">true</xsl:attribute>
	</xsl:if>
	<xsl:apply-templates/>
      </model>
	</xsl:variable>
	<xsl:apply-templates select="$m/*" mode="noname"/>
      </egXML>
	</cell>
      </row>
    </xsl:template>


  <xsl:template match="*" mode="noname">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*|*|processing-instruction()|comment()|text()"  mode="noname"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="comment()|@*|processing-instruction()|text()"  mode="noname">
    <xsl:copy-of select="."/>
  </xsl:template>


</xsl:stylesheet>
