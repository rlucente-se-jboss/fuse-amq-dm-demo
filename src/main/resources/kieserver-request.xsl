<?xml version="1.0"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:order="http://com.redhat.demo/order">
    <xsl:strip-space elements="*"/>
    <xsl:output omit-xml-declaration="yes" indent="no" />
    <xsl:template match="/order:order">
        <batch-execution>
            <insert out-identifier="CountryWithRegion" return-object="true" entry-point="DEFAULT">
                <com.redhat.rhdm.demo.Customer>
                    <id><xsl:value-of select="order:customer/@id" /></id>
                    <city><xsl:value-of select="order:customer/order:city" /></city>
                    <countryCode><xsl:value-of select="order:customer/order:country" /></countryCode>
                </com.redhat.rhdm.demo.Customer>
            </insert>
            <insert out-identifier="OrderWithHandling" return-object="true" entry-point="DEFAULT">
                <com.redhat.rhdm.demo.Order>
                    <id><xsl:value-of select="@id" /></id>
                    <date><xsl:value-of select="order:date" /><xsl:text>T00:00:00Z</xsl:text></date>
                    <orderlines>
                        <xsl:apply-templates select="order:orderlines/order:orderline" />
                    </orderlines>
                </com.redhat.rhdm.demo.Order>
            </insert>
            <fire-all-rules />
        </batch-execution>
    </xsl:template>
    <xsl:template match="order:orderline">
        <com.redhat.rhdm.demo.OrderLine>
            <article>
                <id><xsl:value-of select="order:article/@id" /></id>
                <description><xsl:value-of select="order:article/order:description" /></description>
            </article>
            <quantity><xsl:value-of select="order:quantity" /></quantity>
        </com.redhat.rhdm.demo.OrderLine>
    </xsl:template>
    <xsl:template match="text()" />
</xsl:stylesheet>
