<?xml version="1.0"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:order="http://com.redhat.demo/order">
    <xsl:output omit-xml-declaration="yes" />
    <xsl:template match="/order:order/order:customer">
        <batch-execution>
            <insert out-identifier="CountryWithRegion"
                return-object="true" entry-point="DEFAULT">
                <com.redhat.rhdm.demo.Country>
                    <countryCode>
                        <xsl:value-of
                            select="order:country" />
                    </countryCode>
                </com.redhat.rhdm.demo.Country>
            </insert>
            <fire-all-rules />
        </batch-execution>
    </xsl:template>
    <xsl:template match="text()" />
</xsl:stylesheet>
