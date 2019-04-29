<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:af="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs xd"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p>
                Stylesheet to convert the Latin Atalanta transcription to HTML. This is the
            facsimile view.</xd:p>
            <xd:p><xd:b>Created on:</xd:b> Aug 18, 2018</xd:p>
            <xd:p><xd:b>Author:</xd:b> elli</xd:p>
            <xd:p>Important to note that in order for html to work properly, text that should only appear in 
            the facsimile view is enclosed in span elements with class="original" and text that should only appear
            in the normalized, reading view is enclosed in span elements with class="regularized"
            
            </xd:p>
        </xd:desc>
    </xd:doc>
    
<!-- line break in output file; improves human readability of xml output -->
<!-- <xsl:strip-space elements="*"/> -->
    <xsl:variable name="newline"><xsl:text> 
</xsl:text></xsl:variable>
    
    <xsl:output method="xml" encoding="UTF-8" indent="no"/>
    
    <xsl:template match="/">
        
        <html>
            <head>
                <title>Atalanta Fugiens (Maier Edition. transcription) Facsimile Copy. Emblem <xsl:value-of select="substring(af:div[@type='emblem/@n'],2)"/></title>
                <link rel="stylesheet" type="text/css" href="atalantaProof-Lat.css"  />
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

    <xsl:template match="af:div[@type='fugue' or @type='epigram' or @type='discourse' or @type='image'or @type='preface']">
        <div class="{@type} {@xml:lang}" lang="{@xml:lang}">
            <xsl:choose>
                <xsl:when test="@type='fugue' or @type='image'">
                    <span class="pb atalanta-fugiens"><xsl:value-of select="preceding::af:pb[1]/@n"/></span>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="af:div[@type='discourse-p1' or @type='discourse-p2']">
        <div class="{@type}">
            <span class="pb atalanta-fugiens"><xsl:value-of select="preceding::af:pb[1]/@n"/></span>
            <xsl:choose>
                <xsl:when test="@type='discourse-p1'"><h3 class="title"><xsl:apply-templates select="preceding::af:fw[@type='header'][1]" mode="titles"/></h3></xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </div>
        <xsl:choose>
            <xsl:when test="@type='discourse-p1'">
                <br class="discourse-pagebreak" />
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:div[@type='page']">
        <xsl:choose>
            <xsl:when test="child::af:ab[@rend='italics']">
                <div class="{@type} italic"><xsl:apply-templates/></div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:fw" mode="titles">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="af:fw"/>
    <!-- formwork contents are handled by the divs that follow them -->
       
    <xsl:template match="af:note">
            <div class="margin-note"><span class="note-mark"><xsl:text>*</xsl:text></span><xsl:apply-templates/>
            </div>
    </xsl:template>
    
    <xsl:template match="af:head">
        <xsl:choose>
            <xsl:when test="parent::af:div[@type='epigram']">
                <h3 class="title" lang="la">
                    <xsl:apply-templates/>
                </h3>
            </xsl:when>
            <xsl:when test="parent::af:div[@type='fugue'] or parent::af:div[@type='image']">
                <h3 class="title" lang="la"><xsl:apply-templates select="preceding::af:fw[@type='header'][1]" mode="titles"/></h3>
                <h1 class="title" lang="{parent::af:div/@xml:lang}">
                    <xsl:apply-templates/>
                </h1>
            </xsl:when>
            <xsl:when test="parent::af:div[@type='preface']">
                <h1><xsl:apply-templates/></h1>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:ab">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="af:ab[parent::af:div[@type='discourse-p1'] or parent::af:div[@type='discourse-p2']]">
        <div class="ab"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="af:seg[@rend='smaller']">
        <span class="smaller"><xsl:apply-templates/></span>
    </xsl:template>
    
    <!--    Milestones and reference markers -->     
    <!--<xsl:template match="af:milestone">
        <span class="milestone atalanta-fugiens"><xsl:value-of select="@n"/></span>
    </xsl:template>-->
    
   <!-- <xsl:template match="af:pb">
        <span class="pb atalanta-fugiens"><xsl:value-of select="@n"/></span>
    </xsl:template>-->
    
    <!--xsl:template match="af:lb" mode="#all">
        <xsl:choose>
            <xsl:when test="@break='no'"><xsl:text>-</xsl:text><br /></xsl:when>
            <xsl:otherwise><br/></xsl:otherwise>
        </xsl:choose>
    </xsl:template -->
    
    <xsl:template match="af:lb" mode="#all">
        <br/>
    </xsl:template>
    
    <xsl:template match="text()[ancestor::af:ab][preceding::af:lb[1]][following::af:lb[1][@break eq 'no']]" mode="#all">
        <xsl:value-of select="replace(., '&#x0D;?&#x0a;', '-')"/>
    </xsl:template>
    
   <!-- <xsl:template match="text()[following-sibling::node()[1][self::af:lb[@break eq 'no']]]" mode="#all">
        <xsl:value-of select="substring( normalize-space( concat('␠',.)), 2 )"/>
    </xsl:template>
    
    <xsl:template match="text()[following-sibling::node()[1][self::af:lb[@break eq 'no']]]">
         <xsl:value-of select="substring-before(.,' ')"/>
    </xsl:template>-->
    
    
    <!--    Epigrams and other verse -->   
    
    <xsl:template match="af:lg">
        <xsl:choose>
             <xsl:when test="parent::af:div[@type='epigram'] and @rend='italic'">
                <div class="verse-epigram-italic">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="parent::af:div[@type='epigram']">
                <div class="verse-epigram" lang="{parent::af:div[@type='epigram']/@xml:lang}">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@rend='no-space'">
                        <div class="verse-discourse no-space">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="verse-discourse">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:l">
        <xsl:choose>
            <xsl:when test="ancestor::af:div[@type='epigram']">
                <xsl:choose>
                    <xsl:when test="number(preceding-sibling::af:lb[1]/@n) mod 2 = 0">
                        <span class="v-line-indent"><xsl:apply-templates/></span>  
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="v-line"><xsl:apply-templates/></span>  
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="ancestor::af:div[@type='discourse-p1'] or ancestor::af:div[@type='discourse-p2']">
                <span class="v-line-discourse"><xsl:apply-templates/></span>
            </xsl:when>
        </xsl:choose>
        
       
    </xsl:template>
    
    
    <!--    Word and Phrase level markup -->  
    
    <xsl:template match="af:choice">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="af:reg | af:corr">  <!-- choice/orig/reg -->
        <span class="regularized"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="af:orig | af:sic">      
        <xsl:choose>
            <xsl:when test="parent::af:choice"><span class="original"><xsl:apply-templates/></span></xsl:when>
            <xsl:otherwise><span class="orig-solo"><xsl:apply-templates/></span></xsl:otherwise>
        </xsl:choose>      
    </xsl:template>
    
    <xsl:template match="af:surplus ">
        <span class="original">
            <xsl:text>{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="af:supplied ">
        <span class="original">
            <xsl:text>&lt;</xsl:text><xsl:apply-templates/><xsl:text>&gt;</xsl:text>
        </span>
        <span class="regularized">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
       
    <xsl:template match="af:unclear"> . <!-- should we keep unlcear indication in regularized?  -->
           <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
   </xsl:template>
    
    <xsl:template match="af:hi[@rend='superscript']">
        <span class="superscript"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="af:pc">
       <xsl:choose>
           <xsl:when test=".[parent::af:hi][1]"/> <!-- hide marks for german verse wraps -->
           <xsl:otherwise>
               <xsl:apply-templates/>
           </xsl:otherwise>
       </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:g">
        <span class="original">&amp;</span><span class="regularized">et</span>
    </xsl:template>
    
    <!-- abbreviations -->
    
    <xsl:template match="af:expan">
        <xsl:apply-templates mode="abbrev"/><span class="regularized"><xsl:apply-templates mode="expand"/></span>
    </xsl:template>
    
    <xsl:template match="af:abbr">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="af:ex" mode="expand">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="af:ex" mode="abbrev"/>

    <xsl:template match="af:am" mode="abbrev">
        <span class="original"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="af:am" mode="expand"/> <!-- this handles the case where <am> appears inside <num>, 
        and should just be rendered as is.  -->
    
    <xsl:template match="af:am" >
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="af:g" mode="abbrev">
        <xsl:text>&amp;</xsl:text>
    </xsl:template>
    <!-- end abbreviations -->
    
    
    <xsl:template match="af:quote">
        <xsl:choose>
            <xsl:when test="@rend='italic' or @rend='smallCaps'" >
                <span class="{@rend}"><xsl:apply-templates/></span>
            </xsl:when>
            <xsl:when test="@rend='italic indent'" >
                <span class="{@rend}"><xsl:apply-templates/></span>
            </xsl:when>
            <!-- deal with indent -->
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
     
    <xsl:template match="af:hi[@rend='italic'] | af:hi[@rend='gothic'] | af:hi[@rend='latin'] | af:hi[@rend='smallCaps']">
        <span class="{@rend}"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='raised']">
        <span class="original"><span class="{@rend}"><xsl:apply-templates/></span></span><span class="regularized"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='smallCaps latin']">
        <span class="smallCaps-latin"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="af:foreign">
        <xsl:choose>
            <xsl:when test="@rend='la'">
                <span class="latin"><xsl:apply-templates/></span>
            </xsl:when>
            <xsl:when test="@rend='de'">
                <span class="gothic"><xsl:apply-templates/></span>
            </xsl:when>
        </xsl:choose>
       
    </xsl:template>
    
    <!-- 
      This is a very brute force way of handling characters with punctuation and diacritical marks.
      ideally these should be in the header as glyphs or as something in a taxonomy. But this works for now.
    -->
    
    <xsl:template match="af:hi[@rend='ligature']">
        <xsl:choose>
            <xsl:when test=". = 'ae'">
                <span class="original">æ</span><span class="regularized"><xsl:apply-templates/></span>
            </xsl:when>
            <xsl:when test=". = 'oe'">
                <span class="original">œ</span><span class="regularized"><xsl:apply-templates/></span>
            </xsl:when>
            <xsl:when test=".= 'Ae'">
                <span class="original">Æ</span><span class="regularized"><xsl:apply-templates/></span>
            </xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>    
        </xsl:choose>
    </xsl:template>
    
    <!-- Kludgy way to handle these substitutions before I put them into the header. Need to handle 3 modes: in mode="abbrev"
         the charager is shown with the punctuation. In empty mode, again, shown with punctuation but this occurs outside 
         an abbreviation. Third mode=expand" should just apply templates and not show the punctuation/abbreviation mark.- there seem to be no 
         punctuation marks in expansions of abbreviations 
   
    -->
    
    <xsl:template match="af:hi[@rend='grave']">
                <xsl:choose>
                    <xsl:when test=".='a'">à</xsl:when>
                    <xsl:when test=".='e'">è</xsl:when>
                    <xsl:when test=".='i'">ì</xsl:when>
                    <xsl:when test=".='o'">ò</xsl:when>
                    <xsl:when test=".='u'">ù</xsl:when>
                </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='grave']"  mode="abbrev">
        <xsl:choose>
            <xsl:when test=".='a'">à</xsl:when>
            <xsl:when test=".='e'">è</xsl:when>
            <xsl:when test=".='i'">ì</xsl:when>
            <xsl:when test=".='o'">ò</xsl:when>
            <xsl:when test=".='u'">ù</xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='acute']">
        <xsl:choose>
            <xsl:when test=".='a'">á</xsl:when>
            <xsl:when test=".='e'">é</xsl:when>
            <xsl:when test=".='i'">í</xsl:when>
            <xsl:when test=".='o'">ó</xsl:when>
            <xsl:when test=".='u'">ú</xsl:when>
            <xsl:when test=".='q'">q&#x301;</xsl:when>
            <xsl:when test=".='m'">m&#x301;</xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='acute']" mode="abbrev">
        <xsl:choose>
            <xsl:when test=".='a'">á</xsl:when>
            <xsl:when test=".='e'">é</xsl:when>
            <xsl:when test=".='i'">í</xsl:when>
            <xsl:when test=".='o'">ó</xsl:when>
            <xsl:when test=".='u'">ú</xsl:when>
            <xsl:when test=".='q'">q&#x301;</xsl:when>
            <xsl:when test=".='m'">m&#x301;</xsl:when>
        </xsl:choose>
    </xsl:template>
     
    <xsl:template match="af:hi[@rend='circumflex']">
        <xsl:choose>
            <xsl:when test=".='a'">â</xsl:when>
            <xsl:when test=".='e'">ê</xsl:when>
            <xsl:when test=".='i'">î</xsl:when>
            <xsl:when test=".='o'">ô</xsl:when>
            <xsl:when test=".='u'">û</xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='circumflex']" mode="abbrev">
        <xsl:choose>
            <xsl:when test=".='a'">â</xsl:when>
            <xsl:when test=".='e'">ê</xsl:when>
            <xsl:when test=".='i'">î</xsl:when>
            <xsl:when test=".='o'">ô</xsl:when>
            <xsl:when test=".='u'">û</xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='tilde']">
        <xsl:choose>
            <xsl:when test=".='a'">ã</xsl:when>
            <xsl:when test=".='e'">ẽ</xsl:when>
            <xsl:when test=".='o'">õ</xsl:when>
            <xsl:when test=".='u'">ũ</xsl:when>
            <xsl:when test=".='m'">m&#x303;</xsl:when>
            <xsl:when test=".='n'">ñ</xsl:when>
            <xsl:when test=".='p'">p&#x303;</xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='tilde']" mode="abbrev">
        <xsl:choose>
            <xsl:when test=".='a'">ã</xsl:when>
            <xsl:when test=".='e'">ẽ</xsl:when>
            <xsl:when test=".='o'">õ</xsl:when>
            <xsl:when test=".='u'">ũ</xsl:when>
            <xsl:when test=".='m'">m&#x303;</xsl:when>
            <xsl:when test=".='n'">ñ</xsl:when>
            <xsl:when test=".='p'">p&#x303;</xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='stroke']">
        <xsl:choose>
            <xsl:when test=".='p'">ꝑ</xsl:when>
            <xsl:when test=".='q'">ꝙ</xsl:when>
            <xsl:when test=".='v'">℣</xsl:when>  <!-- versicle -->
        </xsl:choose>
    </xsl:template>
  
    <xsl:template match="af:hi[@rend='stroke']" mode="abbrev">
        <xsl:choose>
            <xsl:when test=".='p'">ꝑ</xsl:when>
            <xsl:when test=".='q'">ꝙ</xsl:when><!-- &#xA759 -->
            <xsl:when test=".='v'">℣</xsl:when>  <!-- versicle -->
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='hook']">
        <xsl:choose>
            <xsl:when test=".='p'">Ꝓ</xsl:when>
            <xsl:when test=".='e'">ę</xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='hook']" mode="abbrev">
        <xsl:choose>
            <xsl:when test=".='p'">Ꝓ</xsl:when>
            <xsl:when test=".='e'">ę</xsl:when>
        </xsl:choose>
    </xsl:template>
    
 <!-- these only occur on one letter -->
    <xsl:template match="af:hi[@rend='supraline']" mode="abbrev">
        <xsl:text>ē</xsl:text>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='bar']" mode="abbrev">
        <xsl:text>ɋ</xsl:text><!-- &#xA757 -->
    </xsl:template>
    
    
    <xsl:template match="af:hi[@rend='acute stroke']" mode="abbrev">
        <xsl:text>ɋ&#x301;</xsl:text>
    </xsl:template>
    
    <xsl:template match="af:hi[@rend='invert']"> 
        <xsl:text>n</xsl:text>
    </xsl:template>  <!--  -->
    
    <xsl:template match="af:hi[@rend='sling-below'] | af:hi[@rend='sling-above']"> <!-- This should probably be a span. -->
        <xsl:apply-templates/>
    </xsl:template>  <!-- this should probably be a sic corr -->
    
    
    
    <!-- at some point, check these- either used for indexing or might need formating in some cases. Put into encodingDesc -->
    
    <xsl:template match="af:persName | af:placeName | af:orgName | af:num | 
        af:title | af:name | af:date">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="af:figure | af:span"/>
    
  
    <!-- Catch all to see what we aren't hadnling -->
    
   <!-- <xsl:template match='*'>
        QQQ-element: <xsl:value-of select="name()"/>
            <xsl:apply-templates></xsl:apply-templates>
    </xsl:template> -->
    
   
</xsl:stylesheet>
