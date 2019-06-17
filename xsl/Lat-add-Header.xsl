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
    <xsl:variable name="return" select="'&#10;'"/>
    
    
    <xsl:template match="af:teiHeader">
        <teiHeader>
       <xsl:element name="fileDesc">
        <xsl:apply-templates select="af:fileDesc/af:titleStmt"/>
           <xsl:value-of select="$return"/>
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
                <p>This transcription includes all text in the Meier edition except for the words that are printed with the 
                music of each fugue. Those haven't been transcribed as they are identical to the Latin epigram, and are also
                transcribed as part of the musical notation. German has been transcribed as written, with inconsistent modernization
                of spelling. Wrapped verse lines are indicated using <egXML xmlns="http://www.tei-c.org/ns/Examples"><hi rend="sling=below"></hi></egXML> or <egXML xmlns="http://www.tei-c.org/ns/Examples"><hi rend="sling-above"></hi></egXML></p>
                <p>All line breaks are indicated using the <gi>lb</gi> element and are numbered within their containing <gi>div</gi> or <gi>ab</gi>. We use the <att>break</att> attribute to show hyphenation
                    where it appears in the text. Pagination as printed in encoding using <gi>fw</gi>. The <gi>pb</gi> element is used 
                    to provide the page number in a canonical form.</p>
                <p>Within the discourse section of each element, <gi>ab</gi> are used to group text that appears on each page. This is useful when
                aligning the transcription with page image from the book, but can be ignored otherwise.</p>
                <p>Latin abbreviations are encoded and expanded using the Epi<ref target="http://www.stoa.org/epidoc/gl/latest/trans-abbrevfully.html"></ref>doc conventions.</p>
                <p>All brevigraphs (et, per, pro, quod, qui) are encoded as abbreviations. Accented characters other than those accents used to mark abbreviations have been encoded as <gi>hi</gi> elements.</p>
                <p>Indentations, drop caps and italics are generally not marked when they follow a consistent typographic
                convention in the text. For ex. all epigrams are italicized, which is not explicity marked.</p>
                <p>Running headers and catchwords are encoded as <gi>fw</gi>.</p>
                <p>The use of "j" and "v" is retained as printed in the text and not regularized. Long s is silently transcribed as "s."</p>
               <p>The few mis-spellings and inverted or duplicated letters are marked using <gi>sic</gi> and <gi>corr</gi> element pairs, <gi>surplus</gi>, and <gi>hi</gi>.</p>
                <p>Personal names, work titles, places and organizational units are marked. Personal names are disambiguated using VIAF identifiers. Citations are supplied when possible.</p>
                <p>The set of letter forms used in the book seems to have been missing the lowercase italic letter u, so the uppercase letter is used in its place throughout.</p>
            </xsl:element>
            
            <xsl:element name="charDecl" xml:space="preserve">
                <glyph xml:id="brevi-pro">
                    <glyphName>LATIN SMALL LETTER P WITH FLOURISH</glyphName>
                    <desc>Brevigraph for "pro." Small descending tail to left of descender.</desc>
                    <mapping type="printed">ꝓ</mapping>
                    <mapping type="PUA">U+A753</mapping>
                    <mapping type="expanded">pro</mapping>
                    <mapping type="hi-rend">hook</mapping>
                </glyph>
                <glyph xml:id="brevi-per">
                    <glyphName>LATIN SMALL LETTER P WITH SQUIRREL TAIL</glyphName>
                    <desc>Brevigraph for "per." Small ascending tail to the left of descender.</desc>
                    <mapping type="printed">ꝕ</mapping>
                    <mapping type="PUA">U+A755</mapping>
                    <mapping type="expanded">per</mapping>
                    <mapping type="hi-rend">stroke</mapping>
                </glyph>
                 <glyph xml:id="brevi-qui">
                     <glyphName>LATIN SMALL LETTER Q WITH STROKE THROUGH DESCENDER</glyphName>
                    <desc>Brevigraph for "qui." Horizontal bar through descender.</desc>
                    <mapping type="printed">ꝗ</mapping>
                    <mapping type="PUA">U+A757</mapping>
                     <mapping type="expanded">qui</mapping>
                    <mapping type="hi-rend">bar</mapping>
                </glyph>
                 <glyph xml:id="brevi-quod">
                     <glyphName>LATIN SMALL LETTER Q WITH DIAGONAL STROKE</glyphName>
                    <desc>Brevigraph for "quod." Flourish ascending through descender from lower left to upper right.</desc>
                    <mapping type="printed">ꝙ</mapping>
                    <mapping type="PUA">U+A759</mapping>
                     <mapping type="expanded">quod</mapping>
                    <mapping type="hi-rend">stroke</mapping>
                </glyph>
                <glyph xml:id="brevi-que">
                     <glyphName>LATIN SMALL LETTER Q WITH DIAGONAL STROKE</glyphName>
                    <desc>Brevigraph for "quod." Flourish ascending through descender from lower left to upper right.</desc>
                    <mapping type="printed">q</mapping>
                     <mapping type="expanded">que</mapping>
                    <mapping type="hi-rend">acute-tail</mapping>
                </glyph>
                <glyph xml:id="brevi-ae">
                     <glyphName>LATIN SMALL LETTER E WITH OGONEK</glyphName>
                    <desc>Brevigraph for "ae." e with a right facing hook underneath.</desc>
                    <mapping type="printed">ę</mapping>
                    <mapping type="PUA">U+0119</mapping>
                     <mapping type="expanded">ae</mapping>
                    <mapping type="hi-rend">hook</mapping>
                </glyph>
                <glyph xml:id="versicle">
                     <glyphName>VERSICLE</glyphName>
                    <desc>Brevigraph for a verse marker. v with a vertical slash through it..</desc>
                    <mapping type="printed">℣</mapping>
                    <mapping type="PUA">U+2123</mapping>
                     <mapping type="expanded">v.</mapping>
                    <mapping type="hi-rend">stroke</mapping>
                </glyph>
            </xsl:element>
            
        </xsl:element>
        <xsl:apply-templates select="af:revisionDesc"/>
        </teiHeader>
    </xsl:template>
    
    <xsl:template match="af:fileDesc"/>
    
    <xsl:template match="af:titleStmt" >
            <xsl:element name="titleStmt" namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all" xml:space="preserve">
                    <title>Atalanta Fugiens (digital transcription). Emblem <xsl:value-of select="$af-name"/>.</title>
                <principal ref="http://viaf.org/viaf/32331303">Tara Nummedal</principal>
                <principal>Donna Bilak</principal>
                <respStmt>
                    <resp>Transcription and TEI Encoding</resp>
                    <persName>Scott DiGiulio</persName>
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
                    <p>Please acknowledge the Brown University Library and the Mellon Publication Initiative when re-using or re-publishing.</p>
                </licence>
            </availability>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="af:sourceDesc">
        <xsl:element name="sourceDesc" xml:space="preserve">
            <biblStruct type="book" xml:id="Maier1618">
                <monogr>
                    <title level="m">Atalanta fugiens, : hoc est, emblemata nova de secretis naturæ.
                        chymica, accomodata partim oculis &amp; intellectui, figuris cupro incisi,
                        adiectisque sententiis, epigrammatis &amp; notis, partim auribus &amp; recreationi
                        animi plus minus 50 rugis musicalibus trium vocum ...</title>
                    <title type="short">Atalanta fugiens,</title>
                    <author><forename>Michael</forename><surname>Maier</surname></author>
                    <imprint>
                        <pubPlace>Oppenheimii</pubPlace>
                        <publisher>Extypographia Hieronymi Galleri, sumptibus Joh. Theodori de Bry</publisher>
                        <date>1618</date>
                        <note type="url">https://repository.library.brown.edu/studio/item/bdr:698524/</note>
                    </imprint>
                    <extent>211, [5] p. (last leaf blank)</extent>
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



    
 