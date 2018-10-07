// this is a customized script for text in header
var css = `
		.header-domain {
		  float: left;
    	  margin: 30px 25px;
          color: white;
          font-size: 60px;
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

    var customHeaderText = 'MYDOMAIN';

    var me = this;
    return Ext.create("Ext.Component", {
        region: "north",
        cls: Ext.baseCSSPrefix + "workspace-header",
        autoEl: {
            tag: "div",
            html: "<div id='header'>" +
                "<div class='header-domain'>" + customDomainTitle + "</div>" +
                "<a title='" + OMV.PRODUCT_NAME +
                "' href='" + OMV.PRODUCT_URL + "' target='_blank'>" +
                "<div id='headerlogo'></div></a><div id='headerrlogo'>" +
                "</div></div>"
        }
    });