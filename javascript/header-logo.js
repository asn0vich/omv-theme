
    // css for custom header logo
    var css = `
		.header-logo {
		  float: left;
    	  margin: 30px 25px;
          color: white;
          width: auto;
          height: 40px;
		}
		div#headerlogo {
		  float: right !important;
		  margin-left: unset !important;
          margin-right: 20px;
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
                "<img src='" + customLogoUrl + "' class='header-logo' />" +
                "<a title='" + OMV.PRODUCT_NAME +
                "' href='" + OMV.PRODUCT_URL + "' target='_blank'>" +
                "<div id='headerlogo'></div></a><div id='headerrlogo'>" +
                "</div></div>"
        }
    });

