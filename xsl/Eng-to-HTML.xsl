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
                <link rel="stylesheet" type="text/css" href="atalantaProof-color-reading.css"/>
            </head>

            <body>
                <xsl:apply-templates/>
            </body>
        </html>

    </xsl:template>

    <xsl:template match="af:teiHeader"/>

    <xsl:template match="text">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="af:body">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="af:div[@type='emblem']">
        <h2 class="pageTitle">Atalanta Fugiens: Emblem <xsl:value-of select="@n"/></h2>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="af:div[@type='title' or @type='epigram' or @type='discourse']">
        <div class="{@type}">
            <!--<h3 class="label"><xsl:value-of select="upper-case(@type)"/></h3>-->
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="af:head">
        <h3 class="{parent::af:div/@type}">
            <xsl:apply-templates/>
        </h3>
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
        <br/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="af:milestone">
        <span class="milestone">
            <xsl:value-of select="@n"/>
        </span>
    </xsl:template>
    
    <xsl:template match="text()[following-sibling::node()[1][self::af:lb[@break eq 'no']]]">
        <xsl:value-of select="substring( normalize-space( concat('␠',.)), 2 )"/>
    </xsl:template>

    <xsl:template match="af:pb">
        <span class="pb"><xsl:value-of select="@n"/></span>
    </xsl:template>
    
    <xsl:template match="af:lb">
        <xsl:if test="@break='no'"><span class="original"><xsl:text>=</xsl:text><br /></span></xsl:if>
    </xsl:template>

    <xsl:template match="af:ab">
        <div class="ab">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="af:reg | af:corr">  <!-- choice/orig/reg -->
        <span class="regularized"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="af:orig | af:sic">      
        <xsl:choose>
            <xsl:when test="parent::af:choice"><span class="original"><xsl:apply-templates/><xsl:text> </xsl:text></span></xsl:when>
            <xsl:otherwise><span class="orig-solo"><xsl:apply-templates/></span></xsl:otherwise>
        </xsl:choose>      
    </xsl:template>

    <xsl:template match="af:unclear | af:supplied | af:subst | af:add | af:del">
        <span class="{name()}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="af:seg[@rend='underline']">
        <xsl:choose>
            <xsl:when test="@hand">
                <span class="underline{@hand}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="underline">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="af:seg[@rend='italics']">
        <span class="italics">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="af:hi[@rend='superscript']">
        <span class="superscript">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="af:note">
        <xsl:if test="@place='margin'">
            <span class="note-mark">*</span>
            <div class="margin-note">
                <span class="note-mark">
                    <xsl:text>*</xsl:text>
                </span>
                <xsl:apply-templates/>
            </div>
        </xsl:if>
        <xsl:if test="@type='GE'">
            <span class="help">[<xsl:apply-templates/>]</span>
        </xsl:if>
    </xsl:template>

    <xsl:template match="af:pc">
        <xsl:choose>
            <xsl:when test="following-sibling::af:lb[1]"/>
            <!-- ignore if it's at the end of a line -->
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@rend='double-hyphen'">
                        <xsl:text>=</xsl:text>
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
    
    <xsl:template match="af:fw">
        <span class="fw original">
            <xsl:apply-templates/>
        </span>
        <!-- fw only visible in original view. Otherwise show nothing. -->
    </xsl:template>

</xsl:stylesheet>
