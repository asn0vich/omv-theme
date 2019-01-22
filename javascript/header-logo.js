var customLogoUrl = '../images/custom-logo.png';

var me = this;
return Ext.create("Ext.Component", {
    region: "north",
    cls: Ext.baseCSSPrefix + "workspace-header",
    autoEl: {
        tag: "div",
        html: "<div id='header'>" +
              "<img src='" + customLogoUrl + "' class='header-logo' /></div>"
    }
});