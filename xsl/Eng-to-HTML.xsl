<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:af="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Mar 31, 2017</xd:p>
            <xd:p><xd:b>Author:</xd:b> elli</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>

    <!-- line break in output file; improves human readability of xml output -->
    <!-- <xsl:strip-space elements="*"/> -->
    <xsl:variable name="newline">
        <xsl:text> 
</xsl:text>
    </xsl:variable>

    <xsl:output method="xml" encoding="UTF-8" indent="no"/>

    <xsl:template match="/">

        <html>
            <head>
                <title>Atalanta Fugiens (Beinecke Ms. transcription) Facsimile Copy. Emblem
                        <xsl:value-of select="af:div[@type='emblem/@n']"/></title>
                <link rel="stylesheet" type="text/css" href="atalantaProof-Eng.css"/>
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

    <xsl:template match="af:div[@type='emblem']">
        <h2 class="pageTitle">Atalanta Fugiens: Emblem <xsl:value-of select="@n"/></h2>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="af:div[@type='dedication' or @type='preface' or @type='titlePage']">       
        <div class="{@type}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="af:div[@type='title']">
        <div class="{@type}">
            <span class="pb beinecke"><xsl:value-of select="preceding::af:pb[1]/@n"/> </span>
            <span class="pb atalanta-fugiens"><xsl:value-of select="af:milestone[@ed='Meier1618']/@n"/></span>
            <h3><xsl:apply-templates select="af:head[1]"/></h3>
            <h1><xsl:apply-templates select="af:head[2]"/></h1>
        </div>
    </xsl:template>
    
    <xsl:template match="af:div[@type='epigram']">
        <div class="{@type}">
            <h3><xsl:apply-templates select="af:head"/></h3>
            <xsl:apply-templates select="af:lg"/>
        </div>
    </xsl:template>
    
    
    <xsl:template match="af:div[@type='discourse']">
        <div class="{@type}">
            <xsl:apply-templates select="af:div[@type='discourse-p1']"/>
            <br class="discourse-pagebreak" />
            <xsl:apply-templates select="af:div[@type='discourse-p2']"/>
        </div>
    </xsl:template>
    
    <!-- what do we do differently in discourse-p1 and -2 -->
    <xsl:template match="af:div[@type='discourse-p1'] | af:div[@type='discourse-p2']">
        <div class="{@type}">  
            <span class="pb beinecke"><xsl:value-of select="preceding::af:pb[1]/@n"/> </span>
            <span class="pb atalanta-fugiens"><xsl:value-of select="preceding::af:milestone[@ed='Meier1618'][1]/@n"/></span>
            <h3><xsl:apply-templates select="preceding::af:head[1]"/></h3>
            <div class="ab">
               <xsl:apply-templates select="af:ab"/>
            </div>
        </div>
    </xsl:template>   

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
        <br/><span class="v-line"><xsl:apply-templates/></span>
    </xsl:template>
    
    <!--  <xsl:template match="af:pb"> maybe show it in discourse-p2 inline
        <span class="pb"><xsl:value-of select="@n"/></span>
    </xsl:template>-->
    
    <xsl:template match="text()[following-sibling::node()[1][self::af:lb[@break eq 'no']]]">
        <xsl:value-of select="substring( normalize-space( concat('␠',.)), 2 )"/>
    </xsl:template>
    
    <xsl:template match="af:lb">
        <xsl:choose>
            <xsl:when test="@break='no'"><span class="original"><xsl:text>=</xsl:text><br /></span></xsl:when>
            <xsl:otherwise><span class="original"><br/></span> </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

    <xsl:template match="af:ab">
        <div class="ab">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
<!--     Phrase level formatting   -->

    <xsl:template match="af:reg | af:corr">  <!-- choice/orig/reg -->
        <span class="regularized"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="af:orig">      
        <xsl:choose>
            <xsl:when test="parent::af:choice"><span class="original"><xsl:apply-templates/></span></xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>      
    </xsl:template>
    
    <xsl:template match="af:sic">      
        <xsl:choose>
            <xsl:when test="parent::af:choice"><span class="original"><xsl:apply-templates/> [sic]</span></xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>      
    </xsl:template>

    <xsl:template match="af:unclear | af:subst | af:add | af:del">
        <span class="{name()}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="af:supplied">
        <span class="original">
            <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
        </span>
        <span class="regularized">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="af:seg[@rend='underline']">
        <xsl:choose>
            <xsl:when test="@hand">
                <span class="underline-{@hand}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="underline"><xsl:apply-templates/></span>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
    
    <xsl:template match="af:seg[@rend='indent']">
        <span class="indent"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="af:hi[@rend='italic'] | af:hi[@rend='superscript']">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="af:note">
        <xsl:choose>
            <xsl:when test="@place='margin' or @place='left-margin'">
                <span class="note-mark">*</span>
                <div class="margin-note">
                    <span class="note-mark">
                        <xsl:text>*</xsl:text>
                    </span>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@place='bottom'">
                <div class="bottom-note">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
        </xsl:choose>
        
    </xsl:template>

    <xsl:template match="af:pc">
        <xsl:choose>
            <xsl:when test="following-sibling::af:lb[1]">
                <!-- it's at the end of a line -->
                <span class="original"><xsl:apply-templates/></span>
            </xsl:when>
        
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@rend='double-hyphen'">
                        <span class="original"><xsl:text>=</xsl:text></span><span class="regularized"><xsl:text>-</xsl:text></span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="{name()}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="af:fw"/> 
    
    <xsl:template match="af:milestone[ancestor::af:div[@type='dedication']]">
        <span class="pb atalanta-fugiens"><xsl:value-of select="@n"/></span>
    </xsl:template>
    
    <xsl:template match="af:milestone[ancestor::af:div[@type='preface']]">
        <span class="pb atalanta-fugiens"><xsl:value-of select="@n"/></span>
    </xsl:template>
    
        

</xsl:stylesheet>
