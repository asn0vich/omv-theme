var customHeaderText = 'MYDOMAIN';

var me = this;
return Ext.create("Ext.Component", {
    region: "north",
    cls: Ext.baseCSSPrefix + "workspace-header",
    autoEl: {
        tag: "div",
        html: "<div id='header'>" +
              "<div class='header-domain'>" + customHeaderText + "</div></div>"
    }
});