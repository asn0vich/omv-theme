
    // css for custom header logo
    var css = `
		.header-logo {
		  float: left;
          height: 70px;
          width: auto;
          margin: 5px 20px;
		}
		`,
        head = document.head || document.getElementsByTagName('head')[0],
        style = document.createElement('style');
    style.type = 'text/css';
    style.appendChild(document.createTextNode(css));
    head.appendChild(style);
    // end of custom css

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

