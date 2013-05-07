# NB: By nature, you cannot debug or use alert() on <script>s that you append to the DOM.
# In fact, you cannot even inspect to see if the <script>s have been appended.
# However, if you do append a reference to an external <script>, you'll see
# in the browser's Network tab that the request was indeed made for that <script>.
# And any inline javascript that has been appended does run correctly.  -rich

(->
  trr.pixels =

    postYahooConversion: (event) ->
      # <img src="https://ad.yieldmanager.com/pixel?id=2288114&t=2" width="1" height="1" />
      if trr.config.isProduction and 'join' is event
        pixel = $('<img/>').attr('width', '1')
          .attr('height', '1')
          .attr('src', 'https://ad.yieldmanager.com/pixel?id=2288114&t=2')
        $('body').append pixel


    postShareASaleConversion: () ->
      # <img src="https://shareasale.com/sale.cfm?amount=AMOUNTOFSALE&tracking=TRACKINGNUMBER&transtype=TYPEOFTRANSACTION&merchantID=32926" width="1" height="1">
      # Find amount on page
      if trr.config.isProduction
        amount = $(trr.config.el.totalAmount).text()
        amount = amount.replace(/\$/g, '')

        # Find order number on page
        tracking = $(trr.config.el.orderNumber).text()
        tracking = tracking.replace(/#/, '')
        pixel = $('<img />').attr('width', '1')
          .attr('height', '1')
          .attr('src', 'https://shareasale.com/sale.cfm?amount=' + amount + '&tracking=' + tracking +
                '&transtype=sale&merchantID=32926')
        $('body').append pixel

    postFacebookConversion: (event) ->
      if trr.config.isProduction
        html = ''
        if 'join' is event

          html = '<script type="text/javascript">
                  var fb_param = {};
                  fb_param.pixel_id = "6005795027650";
                  fb_param.value = "0.00";
                  (function(){
                  var fpw = document.createElement("script");
                  fpw.async = true;
                  fpw.src = (location.protocol=="http:"?"http":"https")+"://connect.facebook.net/en_US/fp.js";
                  var ref = document.getElementsByTagName("script")[0];
                  ref.parentNode.insertBefore(fpw, ref);
                  })();
                  </script>
                  <noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/offsite_event.php?id=6005795027650&amp;value=0" /></noscript>
                  '
        # No matching event, so no-op
        else return html

        # Now append the google markup to the page to register the conversion
        $('body').append html

      else '' # just return empty string for not isProduction


    postAdwordsConversion: (event) ->
      # Check to see if we're in production before adding a conversion
      if trr.config.isProduction
      #if !trr.config.isProduction    # <- TO BE USED ONLY FOR TESTING!

        # This is the google analytics html/javascript we want to append to a page via the pixel partial.
        html = ''

        # Cart conversion can happen on a sale page or on a product page
        if 'cart' is event
          html = '
                  <script type="text/javascript">
                    var google_conversion_id = 1036589990;
                    var google_conversion_language = "en";
                    var google_conversion_format = "3";
                    var google_conversion_color = "ffffff";
                    var google_conversion_label = "6sF9COjOtgMQprek7gM";
                    var google_conversion_value = 0;
                  </script>
                  <script id="conversion-script" type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js"></script>
                  <noscript>
                    <div style="display:inline;">
                      <img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/1036589990/?value=0&amp;label=6sF9COjOtgMQprek7gM&amp;guid=ON&amp;script=0"/>
                    </div>
                  </noscript>
                  '


        # One-time-only event when a user first registers.
        # There are two join pixels for two separate google accounts.
        else if 'join' is event
          html = '
                  <script type="text/javascript">
                    var google_conversion_id = 1036589990;
                    var google_conversion_language = "en";
                    var google_conversion_format = "2";
                    var google_conversion_color = "ffffff";
                    var google_conversion_label = "mkgXCIDknQIQprek7gM";
                    var google_conversion_value = 0;
                  </script>
                  <script id="conversion-script" type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js"></script>
                  <noscript>
                    <div style="display:inline;">
                      <img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/1036589990/?value=0&amp;label=mkgXCIDknQIQprek7gM&amp;guid=ON&amp;script=0"/>
                    </div>
                  </noscript>
                  <script type="text/javascript">
                    var google_conversion_id = 1002832660;
                    var google_conversion_language = "en";
                    var google_conversion_format = "3";
                    var google_conversion_color = "ffffff";
                    var google_conversion_label = "NIBZCNSG8wQQlIaY3gM";
                    var google_conversion_value = 0;
                  </script>
                  <script id="conversion-script-2" type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js"></script>
                  <noscript>
                    <div style="display:inline;">
                      <img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/1002832660/?value=0&amp;label=NIBZCNSG8wQQlIaY3gM&amp;guid=ON&amp;script=0"/>
                    </div>
                  </noscript>
                  '


        # Purchase conversion
        else if 'purchase' is event
          html = '
                  <script type="text/javascript">
                    var google_conversion_id = 1036589990;
                    var google_conversion_language = "en";
                    var google_conversion_format = "3";
                    var google_conversion_color = "ffffff";
                    var google_conversion_label = "lfLhCPjMtgMQprek7gM";
                    var google_conversion_value = 0;
                  </script>
                  <script id="conversion-script" type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js"></script>
                  <noscript>
                    <div style="display:inline;">
                      <img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/1036589990/?value=0&amp;label=lfLhCPjMtgMQprek7gM&amp;guid=ON&amp;script=0"/>
                    </div>
                  </noscript>
                  '

        # Consigner conversion
        else if 'consign' is event
          html = '
                  <script type="text/javascript">
                    var google_conversion_id = 1036589990;
                    var google_conversion_language = "en";
                    var google_conversion_format = "3";
                    var google_conversion_color = "ffffff";
                    var google_conversion_label = "G9aoCODPtgMQprek7gM";
                    var google_conversion_value = 0;
                  </script>
                  <script id="conversion-script" type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js"></script>
                  <noscript>
                    <div style="display:inline;">
                      <img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/1036589990/?value=0&amp;label=G9aoCODPtgMQprek7gM&amp;guid=ON&amp;script=0"/>
                    </div>
                  </noscript>
                  '


        # Google remarketing pixel
        else if 'remarketing' is event
          html = '
                  <script type="text/javascript">
                    var google_conversion_id = 1036589990;
                    var google_conversion_label = "5dDGCOjRoQMQprek7gM";
                    var google_custom_params = window.google_tag_params;
                    var google_remarketing_only = true;
                  </script>
                  <script id="conversion-script" type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js"></script>
                  <noscript>
                    <div style="display:inline;">
                      <img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/1036589990/?value=0&amp;label=5dDGCOjRoQMQprek7gM&amp;guid=ON&amp;script=0"/>
                    </div>
                  </noscript>
                  '

        # No matching event, so no-op
        else return false

        # Now append the google markup to the page to register the conversion
        $('body').append html

        # Remove the conversion script from the DOM immediately to prepare the page for another conversion.
        # It's possible to have more than one conversion event per page.
        $(trr.config.el.conversionScript).remove()


      else '' # just return empty string for not isProduction

)()