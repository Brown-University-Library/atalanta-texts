<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:af="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs xd af"
    version="2.0">
    
    <xsl:output method="xml" encoding="UTF-8"/> 
    
    <xsl:variable name="af-name" select="replace(/af:TEI/af:text/af:body/af:div[@type='emblem']/@n, '^e','')"/>
    
    
    <xsl:template match="af:teiHeader">
       <xsl:element name="teiHeader" xml:space="preserve">
       <xsl:element name="fileDesc">
           
        <xsl:apply-templates select="af:fileDesc/af:titleStmt"/>
           
        <xsl:element name="editionStmt" inherit-namespaces="yes">
            <xsl:element name="edition">Transcription and Encoding completed <date>2019-05-20</date></xsl:element>
        </xsl:element>
           
           <xsl:apply-templates select="af:fileDesc/af:publicationStmt"/>
           
           <xsl:apply-templates select="af:fileDesc/af:sourceDesc"/>
        </xsl:element>
            
        <xsl:element name="encodingDesc" xml:space="preserve">
            <projectDesc><p>This text has been transcribed and encoded using the TEI for Tara Nummedal and Donna Bilak’s <title>Furnace and Fugue: A Digital Edition of Michael Maier’s Atalanta fugiens (1618) with Scholarly Commentary</title>, part of Brown University’s Digital Publications Initiative, funded by the Andrew W. Mellon Foundation.</p>
            </projectDesc>
            <xsl:element name="editorialDecl" xml:space="preserve">
                <p>This transcription includes all text in the Beinecke library Mellon MS. 88 (English Translation of Michael Meier's Atalanta Fugiens).</p>
                <p>All line breaks are indicated using the <gi>lb</gi> element. Hyphenation is marked with the <att>break</att> attribute.
                    This manuscript has hyphens filling out lines at the right margin, as well as at the end of a page. These are marked as punctuation using
                     the <gi>pc</gi> element. Pagination as printed is encoded using <gi>fw</gi>. <gi>pb</gi> elements 
                     provide the page number in a canonical form. Page breaks in the original Meier printed text are also inserted and have been marked with a <gi>milestone</gi> element 
                    <egXML xmlns="http://www.tei-c.org/ns/Examples"><milestone unit="page" ed="Meier" n="037"/></egXML></p>
                <p>Within the discourse section of each element, <gi>ab</gi> are used to group text that appears on each page of the equivalent Meier edition. This is useful when
                formatting a side-by-side edition, but can be ignored otherwise.</p>
                <p>Archaic spellings have been modernized throughout, using <gi>orig</gi>/<gi>reg</gi> pairs.</p>
                <p>Strikeouts and additions have been marked using <gi>subst</gi>, <gi>add</gi> and <gi>del</gi> elements.</p>
                <p>This manuscript has underlining in a variety of hands. Underlining is indicated and an attempt has been made to 
                disambiguate hands. Underlining is marked using the <gi>seg</gi> element, for example, <egXML xmlns="http://www.tei-c.org/ns/Examples"><seg rend="underline" hand="2"></seg></egXML></p>
               <p>In the Author's Epigram, text is marked with vertical bars along the left margin, this is marked as a note. In the Preface to the Reader, a long margin note is grouped using a long brace which is encoded
                    using a <att>rend</att> attribute on the note.</p>
                <p>Margin notes contain some alchemical symbols, which are itemized in the Character Declaration below.</p>
            </xsl:element>
            
            <xsl:element name="charDecl" xml:space="preserve">
                <glyph xml:id="antimony">
                    <glyphName>EARTH</glyphName>
                    <desc>circle with a cross on the top of it</desc>
                    <mapping type="printed">♁</mapping>
                    <mapping type="PUA">U+2641</mapping>
                </glyph>
                <glyph xml:id="iron">
                    <glyphName>MALE SIGN</glyphName>
                    <desc>circle with an arrow pointing diagonally up</desc>
                    <mapping type="printed">♂</mapping>
                    <mapping type="PUA">U+2642</mapping>
                </glyph>
                 <glyph xml:id="sulphur">
                     <glyphName>ALCHEMICAL SYMBOL FOR SULPHUR</glyphName>
                    <desc>downward triangle with cross on top</desc>
                    <mapping type="printed">🜍</mapping>
                    <mapping type="PUA">U+1F70D</mapping>
                </glyph>
            </xsl:element>
            
        </xsl:element>
        <xsl:apply-templates select="af:revisionDesc"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="af:fileDesc"/>
    
    <xsl:template match="af:titleStmt" >
            <xsl:element name="titleStmt" namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all" xml:space="preserve">
                    <title>Atalanta Fugiens (digital transcription). Emblem <xsl:value-of select="$af-name"/>.</title>
                <principal ref="http://viaf.org/viaf/32331303">Tara Nummedal</principal>
                <principal>Donna Bilak</principal>
                <respStmt>
                    <resp>Transcription and TEI Encoding</resp>
                    <persName>George Elliot</persName>
                </respStmt>
                <respStmt>
                    <resp>Editorial Oversight and Proofreading</resp>
                    <persName>Donna Bilak</persName>
                </respStmt>
                <respStmt>
                    <resp>TEI encoding oversight</resp>
                    <persName ref="https://orcid.org/0000-0002-0215-4324">Elli Mylonas</persName>
                </respStmt>
            </xsl:element>
    </xsl:template>
    
    <xsl:template match="af:publicationStmt">
        <xsl:element name="publicationStmt"  namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all" xml:space="preserve">
            <authority>Brown University</authority>
            <availability status="free">
                <licence>This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
                    <ref target="http://creativecommons.org/licenses/by-nc/4.0/">Distributed under a Creative Commons licence Attribution-BY-NC 4.0</ref>
                </licence>
            </availability>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="af:sourceDesc">
        <xsl:element name="sourceDesc" xml:space="preserve">
                 <biblStruct type="manuscript"> <!-- make this an msDesc -->
                    <monogr>
                        <title level="m">Atalanta running, that is, new chymicall emblems relating
                            to the secrets of nature</title>
                        <author><forename>Michael</forename><surname>Maier</surname></author>
                        <idno type="Beinecke">Mellon MS. 88</idno>
                        <imprint>
                            <pubPlace>England (?)</pubPlace>
                            <date>[1618 or after]</date>
                            <note type="url">https://brbl-dl.library.yale.edu/vufind/Record/4262893</note>
                        </imprint>
                        <extent>86 pp.</extent>
                    </monogr>
                </biblStruct>
        </xsl:element>
    </xsl:template>
  

    <xsl:template match="af:revisionDesc">
        <xsl:element name="revisionDesc">
            <xsl:apply-templates exclude-result-prefixes="#all"/>
            <change when="2019-05-26" who="EM">Added teiHeader details</change>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="@*|node()" >
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>



    
 