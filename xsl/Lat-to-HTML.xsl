<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:af="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs xd"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p>Stylesheet to convert the Latin Atalanta transcription to HTML. This is the
            facsimile view.</xd:p>
            <xd:p><xd:b>Created on:</xd:b> Aug 18, 2018</xd:p>
            <xd:p><xd:b>Author:</xd:b> elli</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
<!-- line break in output file; improves human readability of xml output -->
<!-- <xsl:strip-space elements="*"/> -->
    <xsl:variable name="newline"><xsl:text> 
</xsl:text></xsl:variable>
    <xsl:param name="orig_ligature">æ œ qae&gt; qi qa qtur qge qsp qck qo qος</xsl:param>
    <xsl:param name="norm_ligature">ae oe ae&gt; i a tur ge sp ck o  ος</xsl:param>
    
    <xsl:output method="xml" encoding="UTF-8" indent="no"/>
    
    <xsl:template match="/">
        
        <html>
            <head>
                <title>Atalanta Fugiens (Maier Edition. transcription) Facsimile Copy. Emblem <xsl:value-of select="substring(af:div[@type='emblem/@n'],2)"/></title>
                <link rel="stylesheet" type="text/css" href="atalantaProof-color.css"  />
            </head>
            
            <body>
               <xsl:apply-templates/>
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template match="af:teiHeader"/>
    
    <xsl:template match="af:text">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="af:body">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!--    Major Divisions and Notes -->
    
    <xsl:template match="af:div[@type='emblem']">
        <h2 class="pageTitle">Atalanta Fugiens: Emblem <xsl:value-of select="substring(@n,2)"/></h2>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="af:div[@type='fugue' or @type='epigram' or @type='discourse' or @type='image']">
        <div class="{@type} {@xml:lang}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="af:div[@type='discourse-p1' or @type='discourse-p2']">
        <h3 class="title"><xsl:value-of select="preceding::af:fw[@type='header'][1]"/></h3>
        <div class="{@type}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="af:fw"/>
    <!-- formwork contents are handled by the divs that follow them -->
       
    <xsl:template match="af:note">
        <xsl:if test="@place='margin'">
            <span class="note-mark">*</span>
            <div class="margin-note"><span class="note-mark"><xsl:text>*</xsl:text></span><xsl:apply-templates/>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="af:head">
        <xsl:choose>
            <xsl:when test="parent::af:div[@type='epigram']">
                <h3 class="title">
                    <xsl:apply-templates/>
                </h3>
            </xsl:when>
            <xsl:when test="parent::af:div[@type='fugue'] or parent::af:div[@type='image']">
                <h3 class="title"><xsl:value-of select="preceding::af:fw[@type='header'][1]"/></h3>
                <h1 class="title">
                    <xsl:apply-templates/>
                </h1>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!--    Milestones and reference markers -->     
    <xsl:template match="af:milestone">
        <span class="milestone atalanta-fugiens"><xsl:value-of select="@n"/></span>
    </xsl:template>
    
    <xsl:template match="af:pb">
        <span class="pb atalanta-fugiens"><xsl:value-of select="@n"/></span>
    </xsl:template>
    
    <xsl:template match="af:lb">
        <xsl:if test="@break='no'">
            <xsl:text>-</xsl:text>
        </xsl:if>
        <br />
    </xsl:template>
    
    <!-- <xsl:template match="text()[following-sibling::node()[1][self::af:lb[@break eq 'no']]]">
         <xsl:value-of select="substring-before(.,' ')"/>
    </xsl:template>-->
    
    <xsl:template match="text()[following-sibling::node()[1][self::af:lb[@break eq 'no']]]">
        <xsl:value-of select="substring( normalize-space( concat('␠',.)), 2 )"/>
    </xsl:template>
    
    <!--    Epigrams and other verse -->   
    
    <xsl:template match="af:lg">
        <xsl:choose>
            <xsl:when test="parent::af:div[@type='epigram']">
                <div class="verse-epigram">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="verse-discourse">
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:l">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!--    Word and Phrase level markup -->     
    
    <xsl:template match="af:choice | af:reg">  <!-- choice/orig/reg -->
        <span class="{name()}"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="af:orig">      
        <xsl:choose>
            <xsl:when test="parent::af:choice"><span class="orig"><xsl:apply-templates/><xsl:text> </xsl:text></span></xsl:when>
            <xsl:otherwise><span class="orig-solo"><xsl:apply-templates/></span></xsl:otherwise>
        </xsl:choose>      
    </xsl:template>
       
    <xsl:template match="af:unclear | af:supplied | af:add ">
       <span class="{name()}">
           <xsl:apply-templates/>
       </span>
   </xsl:template>
    
    <xsl:template match="af:hi[@rend='italics']">
        <span class="italics"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='superscript']">
        <span class="superscript"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="af:pc">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="af:g">
        <span class="original">&amp;</span><span class="regularized">et</span>
    </xsl:template>
    
    <xsl:template match="af:expan">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="af:abbr">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="af:ex">
        <span class="regularized"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="af:am">
        <span class="original"><xsl:apply-templates/></span>
    </xsl:template>
 
    <xsl:template match="af:hi[@rend='ligature']">
        <span class="regularized"><xsl:value-of select="."/></span><span class="original"><xsl:value-of select="subsequence(tokenize(($orig_ligature),' '),index-of(tokenize($norm_ligature,' '),{.}),1)"/></span>      
    </xsl:template>
   
</xsl:stylesheet>
