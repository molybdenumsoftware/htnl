{ lib }: # initially from https://github.com/jozo/all-html-elements-and-attributes/blob/0cbb728b2c8ed1b7699eb875537a29a655e65cd2/html-elements.json
let
  common = {
    attributes = {
      accesskey = {
        list.delimiter = " ";
      };
      anchor = {
        experimental = true;
      };
      aria-controls = {
        list.delimiter = " ";
      };
      aria-describedby = {
        list.delimiter = " ";
      };
      aria-details = {
        list.delimiter = " ";
      };
      aria-dropeffect = {
        deprecated = true;
        list.delimiter = " ";
      };
      aria-flowto = {
        list.delimiter = " ";
      };
      aria-labelledby = {
        list.delimiter = " ";
      };
      aria-owns = {
        list.delimiter = " ";
      };
      aria-relevant = {
        list.delimiter = " ";
      };
      autocapitalize = {
      };
      autofocus = {
        boolean = true;
      };
      class = {
        list.delimiter = " ";
      };
      contenteditable = {
      };
      "data-*" = {
      };
      dir = {
      };
      draggable = {
      };
      enterkeyhint = {
      };
      exportparts = {
      };
      hidden = {
      };
      id = {
      };
      inert = {
        boolean = true;
      };
      inputmode = {
      };
      is = {
      };
      itemid = {
      };
      itemprop = {
        list.delimiter = " ";
      };
      itemref = {
        list.delimiter = " ";
      };
      itemscope = {
        boolean = true;
      };
      itemtype = {
        list.delimiter = " ";
      };
      lang = {
      };
      nonce = {
      };
      part = {
      };
      popover = {
      };
      role = {
        list.delimiter = " ";
      };
      slot = {
      };
      spellcheck = {
      };
      style = {
      };
      tabindex = {
      };
      title = {
      };
      translate = {
      };
      virtualkeyboardpolicy = {
        experimental = true;
      };
      writingsuggestions = {
      };
    };
  };

  elements =
    {
      a = {
        deprecated = false;
        attributes = {
          attributionsrc = {
            deprecated = false;
            experimental = true;
          };
          download = {
            deprecated = false;
          };
          href = {
            deprecated = false;
          };
          hreflang = {
            deprecated = false;
          };
          ping = {
            deprecated = false;
            list.delimiter = " ";
          };
          referrerpolicy = {
            deprecated = false;
          };
          rel = {
            deprecated = false;
            list.delimiter = " ";
          };
          target = {
            deprecated = false;
          };
          type = {
            deprecated = false;
          };
          charset = {
            deprecated = true;
          };
          coords = {
            deprecated = true;
          };
          name = {
            deprecated = true;
          };
          rev = {
            deprecated = true;
          };
          shape = {
            deprecated = true;
          };
        };
      };
      abbr = {
        deprecated = false;
        attributes = { };
      };
      acronym = {
        deprecated = true;
        attributes = { };
      };
      address = {
        deprecated = false;
        attributes = { };
      };
      area = {
        void = true;
        deprecated = false;
        attributes = {
          alt = {
            deprecated = false;
          };
          coords = {
            deprecated = false;
            list.delimiter = ",";
          };
          download = {
            deprecated = false;
          };
          href = {
            deprecated = false;
          };
          ping = {
            deprecated = false;
            list.delimiter = " ";
          };
          referrerpolicy = {
            deprecated = false;
          };
          rel = {
            deprecated = false;
            list.delimiter = " ";
          };
          shape = {
            deprecated = false;
          };
          target = {
            deprecated = false;
          };
        };
      };
      article = {
        deprecated = false;
        attributes = { };
      };
      aside = {
        deprecated = false;
        attributes = { };
      };
      audio = {
        deprecated = false;
        attributes = {
          autoplay = {
            boolean = true;
            deprecated = false;
          };
          controls = {
            boolean = true;
            deprecated = false;
          };
          controlslist = {
            deprecated = false;
          };
          crossorigin = {
            deprecated = false;
          };
          disableremoteplayback = {
            deprecated = false;
          };
          loop = {
            boolean = true;
            deprecated = false;
          };
          muted = {
            boolean = true;
            deprecated = false;
          };
          preload = {
            deprecated = false;
          };
          src = {
            deprecated = false;
          };
        };
      };
      b = {
        deprecated = false;
        attributes = { };
      };
      base = {
        void = true;
        deprecated = false;
        attributes = {
          href = {
            deprecated = false;
          };
          target = {
            deprecated = false;
          };
        };
      };
      bdi = {
        deprecated = false;
        attributes = { };
      };
      bdo = {
        deprecated = false;
        attributes = {
          dir = {
            deprecated = false;
          };
        };
      };
      big = {
        deprecated = true;
        attributes = { };
      };
      blockquote = {
        deprecated = false;
        attributes = {
          cite = {
            deprecated = false;
          };
        };
      };
      body = {
        deprecated = false;
        attributes = {
          alink = {
            deprecated = true;
          };
          background = {
            deprecated = true;
          };
          bgcolor = {
            deprecated = true;
          };
          bottommargin = {
            deprecated = true;
          };
          leftmargin = {
            deprecated = true;
          };
          link = {
            deprecated = true;
          };
          onafterprint = {
            deprecated = false;
          };
          onbeforeprint = {
            deprecated = false;
          };
          onbeforeunload = {
            deprecated = false;
          };
          onblur = {
            deprecated = false;
          };
          onerror = {
            deprecated = false;
          };
          onfocus = {
            deprecated = false;
          };
          onhashchange = {
            deprecated = false;
          };
          onlanguagechange = {
            deprecated = false;
          };
          onload = {
            deprecated = false;
          };
          onmessage = {
            deprecated = false;
          };
          onoffline = {
            deprecated = false;
          };
          ononline = {
            deprecated = false;
          };
          onpopstate = {
            deprecated = false;
          };
          onresize = {
            deprecated = false;
          };
          onstorage = {
            deprecated = false;
          };
          onunload = {
            deprecated = false;
          };
          rightmargin = {
            deprecated = true;
          };
          text = {
            deprecated = true;
          };
          topmargin = {
            deprecated = true;
          };
          vlink = {
            deprecated = true;
          };
        };
      };
      br = {
        void = true;
        deprecated = false;
        attributes = {
          clear = {
            deprecated = true;
          };
        };
      };
      button = {
        deprecated = false;
        attributes = {
          autofocus = {
            boolean = true;
            deprecated = false;
          };
          disabled = {
            boolean = true;
            deprecated = false;
          };
          form = {
            deprecated = false;
          };
          formaction = {
            deprecated = false;
          };
          formenctype = {
            deprecated = false;
          };
          formmethod = {
            deprecated = false;
          };
          formnovalidate = {
            boolean = true;
            deprecated = false;
          };
          formtarget = {
            deprecated = false;
          };
          name = {
            deprecated = false;
          };
          popovertarget = {
            deprecated = false;
          };
          popovertargetaction = {
            deprecated = false;
          };
          type = {
            deprecated = false;
          };
          value = {
            deprecated = false;
          };
        };
      };
      canvas = {
        deprecated = false;
        attributes = {
          height = {
            deprecated = false;
          };
          moz-opaque = {
            deprecated = true;
          };
          width = {
            deprecated = false;
          };
        };
      };
      caption = {
        deprecated = false;
        attributes = {
          align = {
            deprecated = true;
          };
        };
      };
      center = {
        deprecated = true;
        attributes = { };
      };
      cite = {
        deprecated = false;
        attributes = { };
      };
      code = {
        deprecated = false;
        attributes = { };
      };
      col = {
        void = true;
        deprecated = false;
        attributes = {
          span = {
            deprecated = false;
          };
          align = {
            deprecated = true;
          };
          bgcolor = {
            deprecated = true;
          };
          char = {
            deprecated = true;
          };
          charoff = {
            deprecated = true;
          };
          valign = {
            deprecated = true;
          };
          width = {
            deprecated = true;
          };
        };
      };
      colgroup = {
        deprecated = false;
        attributes = {
          span = {
            deprecated = false;
          };
          align = {
            deprecated = true;
          };
          bgcolor = {
            deprecated = true;
          };
          char = {
            deprecated = true;
          };
          charoff = {
            deprecated = true;
          };
          valign = {
            deprecated = true;
          };
          width = {
            deprecated = true;
          };
        };
      };
      data = {
        deprecated = false;
        attributes = {
          value = {
            deprecated = false;
          };
        };
      };
      datalist = {
        deprecated = false;
        attributes = { };
      };
      dd = {
        deprecated = false;
        attributes = { };
      };
      del = {
        deprecated = false;
        attributes = {
          cite = {
            deprecated = false;
          };
          datetime = {
            deprecated = false;
          };
        };
      };
      details = {
        deprecated = false;
        attributes = {
          open = {
            boolean = true;
            deprecated = false;
          };
          name = {
            deprecated = false;
          };
        };
      };
      dfn = {
        deprecated = false;
        attributes = { };
      };
      dialog = {
        deprecated = false;
        attributes = {
          open = {
            boolean = true;
            deprecated = false;
          };
        };
      };
      dir = {
        deprecated = true;
        attributes = {
          compact = {
            deprecated = true;
          };
        };
      };
      div = {
        deprecated = false;
        attributes = { };
      };
      dl = {
        deprecated = false;
        attributes = { };
      };
      dt = {
        deprecated = false;
        attributes = { };
      };
      em = {
        deprecated = false;
        attributes = { };
      };
      embed = {
        void = true;
        deprecated = false;
        attributes = {
          height = {
            deprecated = false;
          };
          src = {
            deprecated = false;
          };
          type = {
            deprecated = false;
          };
          width = {
            deprecated = false;
          };
        };
      };
      fencedframe = {
        deprecated = false;
        experimental = true;
        attributes = {
          allow = {
            deprecated = false;
            experimental = true;
          };
          height = {
            deprecated = false;
            experimental = true;
          };
          width = {
            deprecated = false;
            experimental = true;
          };
        };
      };
      fieldset = {
        deprecated = false;
        attributes = {
          disabled = {
            boolean = true;
            deprecated = false;
          };
          form = {
            deprecated = false;
          };
          name = {
            deprecated = false;
          };
        };
      };
      figcaption = {
        deprecated = false;
        attributes = { };
      };
      figure = {
        deprecated = false;
        attributes = { };
      };
      font = {
        deprecated = true;
        attributes = {
          color = {
            deprecated = true;
          };
          face = {
            deprecated = true;
          };
          size = {
            deprecated = true;
          };
        };
      };
      footer = {
        deprecated = false;
        attributes = { };
      };
      form = {
        deprecated = false;
        attributes = {
          accept = {
            deprecated = true;
            list.delimiter = ",";
          };
          accept-charset = {
            deprecated = false;
          };
          autocapitalize = {
            deprecated = false;
          };
          autocomplete = {
            deprecated = false;
            list.delimiter = " ";
          };
          name = {
            deprecated = false;
          };
          novalidate = {
            boolean = true;
            deprecated = false;
          };
          rel = {
            deprecated = false;
            list.delimiter = " ";
          };
        };
      };
      frame = {
        deprecated = true;
        attributes = {
          src = {
            deprecated = true;
          };
          name = {
            deprecated = true;
          };
          noresize = {
            deprecated = true;
          };
          scrolling = {
            deprecated = true;
          };
          marginheight = {
            deprecated = true;
          };
          marginwidth = {
            deprecated = true;
          };
          frameborder = {
            deprecated = true;
          };
        };
      };
      frameset = {
        deprecated = true;
        attributes = {
          cols = {
            deprecated = true;
          };
          rows = {
            deprecated = true;
          };
        };
      };
      h1 = {
        deprecated = false;
        attributes = { };
      };
      h2 = {
        deprecated = false;
        attributes = { };
      };
      h3 = {
        deprecated = false;
        attributes = { };
      };
      h4 = {
        deprecated = false;
        attributes = { };
      };
      h5 = {
        deprecated = false;
        attributes = { };
      };
      h6 = {
        deprecated = false;
        attributes = { };
      };
      head = {
        deprecated = false;
        attributes = {
          profile = {
            deprecated = true;
          };
        };
      };
      header = {
        deprecated = false;
        attributes = { };
      };
      hgroup = {
        deprecated = false;
        attributes = { };
      };
      hr = {
        void = true;
        deprecated = false;
        attributes = {
          align = {
            deprecated = true;
          };
          color = {
            deprecated = true;
          };
          noshade = {
            deprecated = true;
          };
          size = {
            deprecated = true;
          };
          width = {
            deprecated = true;
          };
        };
      };
      html = {
        deprecated = false;
        attributes = {
          version = {
            deprecated = true;
          };
          xmlns = {
            deprecated = false;
          };
        };
      };
      i = {
        deprecated = false;
        attributes = { };
      };
      iframe = {
        deprecated = false;
        attributes = {
          allow = {
            deprecated = false;
          };
          allowfullscreen = {
            boolean = true;
            deprecated = false;
          };
          allowpaymentrequest = {
            deprecated = true;
          };
          browsingtopics = {
            deprecated = false;
            experimental = true;
          };
          credentialless = {
            deprecated = false;
            experimental = true;
          };
          csp = {
            deprecated = false;
            experimental = true;
          };
          height = {
            deprecated = false;
          };
          loading = {
            deprecated = false;
          };
          name = {
            deprecated = false;
          };
          referrerpolicy = {
            deprecated = false;
          };
          sandbox = {
            deprecated = false;
          };
          src = {
            deprecated = false;
          };
          srcdoc = {
            deprecated = false;
          };
          width = {
            deprecated = false;
          };
          align = {
            deprecated = true;
          };
          frameborder = {
            deprecated = true;
          };
          longdesc = {
            deprecated = true;
          };
          marginheight = {
            deprecated = true;
          };
          marginwidth = {
            deprecated = true;
          };
          scrolling = {
            deprecated = true;
          };
        };
      };
      img = {
        void = true;
        deprecated = false;
        attributes = {
          alt = {
            deprecated = false;
          };
          attributionsrc = {
            deprecated = false;
            experimental = true;
          };
          crossorigin = {
            deprecated = false;
          };
          decoding = {
            deprecated = false;
          };
          elementtiming = {
            deprecated = false;
          };
          fetchpriority = {
            deprecated = false;
          };
          height = {
            deprecated = false;
          };
          ismap = {
            boolean = true;
            deprecated = false;
          };
          loading = {
            deprecated = false;
          };
          referrerpolicy = {
            deprecated = false;
          };
          sizes = {
            deprecated = false;
            list.delimiter = ",";
          };
          src = {
            deprecated = false;
          };
          srcset = {
            deprecated = false;
            list.delimiter = ",";
          };
          width = {
            deprecated = false;
          };
          usemap = {
            deprecated = false;
          };
          align = {
            deprecated = true;
          };
          border = {
            deprecated = true;
          };
          hspace = {
            deprecated = true;
          };
          longdesc = {
            deprecated = true;
          };
          name = {
            deprecated = true;
          };
          vspace = {
            deprecated = true;
          };
        };
      };
      input = {
        void = true;
        deprecated = false;
        attributes = {
          accept = {
            deprecated = false;
            list.delimiter = ",";
          };
          alt = {
            deprecated = false;
          };
          autocapitalize = {
            deprecated = false;
          };
          autocomplete = {
            deprecated = false;
            list.delimiter = " ";
          };
          autofocus = {
            boolean = true;
            deprecated = false;
          };
          capture = {
            deprecated = false;
          };
          checked = {
            boolean = true;
            deprecated = false;
          };
          dirname = {
            deprecated = false;
          };
          disabled = {
            boolean = true;
            deprecated = false;
          };
          form = {
            deprecated = false;
          };
          formaction = {
            deprecated = false;
          };
          formenctype = {
            deprecated = false;
          };
          formmethod = {
            deprecated = false;
          };
          formnovalidate = {
            boolean = true;
            deprecated = false;
          };
          formtarget = {
            deprecated = false;
          };
          height = {
            deprecated = false;
          };
          id = {
            deprecated = false;
          };
          inputmode = {
            deprecated = false;
          };
          list = {
            deprecated = false;
          };
          max = {
            deprecated = false;
          };
          maxlength = {
            deprecated = false;
          };
          min = {
            deprecated = false;
          };
          minlength = {
            deprecated = false;
          };
          multiple = {
            boolean = true;
            deprecated = false;
          };
          name = {
            deprecated = false;
          };
          pattern = {
            deprecated = false;
          };
          placeholder = {
            deprecated = false;
          };
          popovertarget = {
            deprecated = false;
          };
          popovertargetaction = {
            deprecated = false;
          };
          readonly = {
            boolean = true;
            deprecated = false;
          };
          required = {
            boolean = true;
            deprecated = false;
          };
          size = {
            deprecated = false;
          };
          src = {
            deprecated = false;
          };
          step = {
            deprecated = false;
          };
          tabindex = {
            deprecated = false;
          };
          title = {
            deprecated = false;
          };
          type = {
            deprecated = false;
          };
          value = {
            deprecated = false;
          };
          width = {
            deprecated = false;
          };
        };
      };
      ins = {
        deprecated = false;
        attributes = {
          cite = {
            deprecated = false;
          };
          datetime = {
            deprecated = false;
          };
        };
      };
      kbd = {
        deprecated = false;
        attributes = { };
      };
      label = {
        deprecated = false;
        attributes = {
          for = {
            deprecated = false;
          };
        };
      };
      legend = {
        deprecated = false;
        attributes = { };
      };
      li = {
        deprecated = false;
        attributes = {
          value = {
            deprecated = false;
          };
          type = {
            deprecated = true;
          };
        };
      };
      link = {
        void = true;
        deprecated = false;
        attributes = {
          as = {
            deprecated = false;
          };
          blocking = {
            deprecated = false;
            experimental = true;
            list.delimiter = " ";
          };
          crossorigin = {
            deprecated = false;
          };
          disabled = {
            boolean = true;
            deprecated = false;
          };
          fetchpriority = {
            deprecated = false;
          };
          href = {
            deprecated = false;
          };
          hreflang = {
            deprecated = false;
          };
          imagesizes = {
            deprecated = false;
            list.delimiter = ",";
          };
          imagesrcset = {
            deprecated = false;
            list.delimiter = ",";
          };
          integrity = {
            deprecated = false;
          };
          media = {
            deprecated = false;
          };
          referrerpolicy = {
            deprecated = false;
          };
          rel = {
            deprecated = false;
            list.delimiter = " ";
          };
          sizes = {
            deprecated = false;
            list.delimiter = " ";
          };
          title = {
            deprecated = false;
          };
          type = {
            deprecated = false;
          };
        };
      };
      main = {
        deprecated = false;
        attributes = { };
      };
      map = {
        deprecated = false;
        attributes = {
          name = {
            deprecated = false;
          };
        };
      };
      mark = {
        deprecated = false;
        attributes = { };
      };
      marquee = {
        deprecated = true;
        attributes = {
          behavior = {
            deprecated = true;
          };
          bgcolor = {
            deprecated = true;
          };
          direction = {
            deprecated = true;
          };
          height = {
            deprecated = true;
          };
          hspace = {
            deprecated = true;
          };
          loop = {
            deprecated = true;
          };
          scrollamount = {
            deprecated = true;
          };
          scrolldelay = {
            deprecated = true;
          };
          truespeed = {
            deprecated = true;
          };
          vspace = {
            deprecated = true;
          };
          width = {
            deprecated = true;
          };
        };
      };
      menu = {
        deprecated = false;
        attributes = { };
      };
      meta = {
        void = true;
        deprecated = false;
        attributes = {
          charset = {
            deprecated = false;
          };
          content = {
            deprecated = false;
          };
          http-equiv = {
            deprecated = false;
          };
          name = {
            deprecated = false;
          };
        };
      };
      meter = {
        deprecated = false;
        attributes = {
          value = {
            deprecated = false;
          };
          min = {
            deprecated = false;
          };
          max = {
            deprecated = false;
          };
          low = {
            deprecated = false;
          };
          high = {
            deprecated = false;
          };
          optimum = {
            deprecated = false;
          };
          form = {
            deprecated = false;
          };
        };
      };
      nav = {
        deprecated = false;
        attributes = { };
      };
      nobr = {
        deprecated = true;
        attributes = { };
      };
      noembed = {
        deprecated = true;
        attributes = { };
      };
      noframes = {
        deprecated = true;
        attributes = { };
      };
      noscript = {
        deprecated = false;
        attributes = { };
      };
      object = {
        deprecated = false;
        attributes = {
          archive = {
            deprecated = true;
          };
          border = {
            deprecated = true;
          };
          classid = {
            deprecated = true;
          };
          codebase = {
            deprecated = true;
          };
          codetype = {
            deprecated = true;
          };
          data = {
            deprecated = false;
          };
          declare = {
            deprecated = true;
          };
          form = {
            deprecated = false;
          };
          height = {
            deprecated = false;
          };
          name = {
            deprecated = false;
          };
          standby = {
            deprecated = true;
          };
          type = {
            deprecated = false;
          };
          usemap = {
            deprecated = true;
          };
          width = {
            deprecated = false;
          };
        };
      };
      ol = {
        deprecated = false;
        attributes = {
          reversed = {
            boolean = true;
            deprecated = false;
          };
          start = {
            deprecated = false;
          };
          type = {
            deprecated = false;
          };
        };
      };
      optgroup = {
        deprecated = false;
        attributes = {
          disabled = {
            boolean = true;
            deprecated = false;
          };
          label = {
            deprecated = false;
          };
        };
      };
      option = {
        deprecated = false;
        attributes = {
          disabled = {
            boolean = true;
            deprecated = false;
          };
          label = {
            deprecated = false;
          };
          selected = {
            boolean = true;
            deprecated = false;
          };
          value = {
            deprecated = false;
          };
        };
      };
      output = {
        deprecated = false;
        attributes = {
          for = {
            deprecated = false;
            list.delimiter = " ";
          };
          form = {
            deprecated = false;
          };
          name = {
            deprecated = false;
          };
        };
      };
      p = {
        deprecated = false;
        attributes = { };
      };
      param = {
        deprecated = true;
        attributes = {
          name = {
            deprecated = true;
          };
          value = {
            deprecated = true;
          };
          type = {
            deprecated = true;
          };
          valuetype = {
            deprecated = true;
          };
        };
      };
      picture = {
        deprecated = false;
        attributes = { };
      };
      plaintext = {
        deprecated = true;
        attributes = { };
      };
      portal = {
        deprecated = false;
        experimental = true;
        attributes = {
          referrerpolicy = {
            deprecated = false;
          };
          src = {
            deprecated = false;
          };
        };
      };
      pre = {
        deprecated = false;
        attributes = {
          width = {
            deprecated = true;
          };
          wrap = {
            deprecated = true;
          };
        };
      };
      progress = {
        deprecated = false;
        attributes = {
          max = {
            deprecated = false;
          };
          value = {
            deprecated = false;
          };
        };
      };
      q = {
        deprecated = false;
        attributes = {
          cite = {
            deprecated = false;
          };
        };
      };
      rb = {
        deprecated = true;
        attributes = { };
      };
      rp = {
        deprecated = false;
        attributes = { };
      };
      rt = {
        deprecated = false;
        attributes = { };
      };
      rtc = {
        deprecated = true;
        attributes = { };
      };
      ruby = {
        deprecated = false;
        attributes = { };
      };
      s = {
        deprecated = false;
        attributes = { };
      };
      samp = {
        deprecated = false;
        attributes = { };
      };
      script = {
        deprecated = false;
        attributes = {
          async = {
            boolean = true;
            deprecated = false;
          };
          attributionsrc = {
            deprecated = false;
            experimental = true;
          };
          blocking = {
            deprecated = false;
            experimental = true;
            list.delimiter = " ";
          };
          crossorigin = {
            deprecated = false;
          };
          defer = {
            boolean = true;
            deprecated = false;
          };
          fetchpriority = {
            deprecated = false;
          };
          integrity = {
            deprecated = false;
          };
          nomodule = {
            boolean = true;
            deprecated = false;
          };
          nonce = {
            deprecated = false;
          };
          referrerpolicy = {
            deprecated = false;
          };
          src = {
            deprecated = false;
          };
          type = {
            deprecated = false;
          };
          charset = {
            deprecated = true;
          };
          language = {
            deprecated = true;
          };
        };
      };
      search = {
        deprecated = false;
        attributes = { };
      };
      section = {
        deprecated = false;
        attributes = { };
      };
      select = {
        deprecated = false;
        attributes = {
          autocomplete = {
            deprecated = false;
            list.delimiter = " ";
          };
          autofocus = {
            boolean = true;
            deprecated = false;
          };
          disabled = {
            boolean = true;
            deprecated = false;
          };
          form = {
            deprecated = false;
          };
          multiple = {
            boolean = true;
            deprecated = false;
          };
          name = {
            deprecated = false;
          };
          required = {
            boolean = true;
            deprecated = false;
          };
          size = {
            deprecated = false;
          };
        };
      };
      slot = {
        deprecated = false;
        attributes = {
          name = {
            deprecated = false;
          };
        };
      };
      small = {
        deprecated = false;
        attributes = { };
      };
      source = {
        void = true;
        deprecated = false;
        attributes = {
          type = {
            deprecated = false;
          };
          src = {
            deprecated = false;
          };
          srcset = {
            deprecated = false;
            list.delimiter = ",";
          };
          sizes = {
            deprecated = false;
            list.delimiter = ",";
          };
          media = {
            deprecated = false;
          };
          height = {
            deprecated = false;
          };
          width = {
            deprecated = false;
          };
        };
      };
      span = {
        deprecated = false;
        attributes = { };
      };
      strike = {
        deprecated = true;
        attributes = { };
      };
      strong = {
        deprecated = false;
        attributes = { };
      };
      style = {
        deprecated = false;
        attributes = {
          blocking = {
            deprecated = false;
            experimental = true;
            list.delimiter = " ";
          };
          media = {
            deprecated = false;
          };
          nonce = {
            deprecated = false;
          };
          title = {
            deprecated = false;
          };
          type = {
            deprecated = true;
          };
        };
      };
      sub = {
        deprecated = false;
        attributes = { };
      };
      summary = {
        deprecated = false;
        attributes = { };
      };
      sup = {
        deprecated = false;
        attributes = { };
      };
      table = {
        deprecated = false;
        attributes = {
          align = {
            deprecated = true;
          };
          bgcolor = {
            deprecated = true;
          };
          border = {
            deprecated = true;
          };
          cellpadding = {
            deprecated = true;
          };
          cellspacing = {
            deprecated = true;
          };
          frame = {
            deprecated = true;
          };
          rules = {
            deprecated = true;
          };
          summary = {
            deprecated = true;
          };
          width = {
            deprecated = true;
          };
        };
      };
      tbody = {
        deprecated = false;
        attributes = {
          align = {
            deprecated = true;
          };
          bgcolor = {
            deprecated = true;
          };
          char = {
            deprecated = true;
          };
          charoff = {
            deprecated = true;
          };
          valign = {
            deprecated = true;
          };
        };
      };
      td = {
        deprecated = false;
        attributes = {
          colspan = {
            deprecated = false;
          };
          headers = {
            deprecated = false;
            list.delimiter = " ";
          };
          rowspan = {
            deprecated = false;
          };
          abbr = {
            deprecated = true;
          };
          align = {
            deprecated = true;
          };
          axis = {
            deprecated = true;
          };
          bgcolor = {
            deprecated = true;
          };
          char = {
            deprecated = true;
          };
          charoff = {
            deprecated = true;
          };
          height = {
            deprecated = true;
          };
          scope = {
            deprecated = true;
          };
          valign = {
            deprecated = true;
          };
          width = {
            deprecated = true;
          };
        };
      };
      template = {
        deprecated = false;
        attributes = {
          shadowrootmode = {
            deprecated = false;
          };
          shadowrootclonable = {
            boolean = true;
            deprecated = false;
          };
          shadowrootdelegatesfocus = {
            boolean = true;
            deprecated = false;
          };
          shadowrootserializable = {
            boolean = true;
            deprecated = false;
            experimental = true;
          };
        };
      };
      textarea = {
        deprecated = false;
        attributes = {
          autocapitalize = {
            deprecated = false;
          };
          autocomplete = {
            deprecated = false;
            list.delimiter = " ";
          };
          autocorrect = {
            deprecated = false;
          };
          autofocus = {
            boolean = true;
            deprecated = false;
          };
          cols = {
            deprecated = false;
          };
          dirname = {
            deprecated = false;
          };
          disabled = {
            boolean = true;
            deprecated = false;
          };
          form = {
            deprecated = false;
          };
          maxlength = {
            deprecated = false;
          };
          minlength = {
            deprecated = false;
          };
          name = {
            deprecated = false;
          };
          placeholder = {
            deprecated = false;
          };
          readonly = {
            boolean = true;
            deprecated = false;
          };
          required = {
            boolean = true;
            deprecated = false;
          };
          rows = {
            deprecated = false;
          };
          spellcheck = {
            deprecated = false;
          };
          wrap = {
            deprecated = false;
          };
        };
      };
      tfoot = {
        deprecated = false;
        attributes = {
          align = {
            deprecated = true;
          };
          bgcolor = {
            deprecated = true;
          };
          char = {
            deprecated = true;
          };
          charoff = {
            deprecated = true;
          };
          valign = {
            deprecated = true;
          };
        };
      };
      th = {
        deprecated = false;
        attributes = {
          abbr = {
            deprecated = false;
          };
          colspan = {
            deprecated = false;
          };
          headers = {
            deprecated = false;
            list.delimiter = " ";
          };
          rowspan = {
            deprecated = false;
          };
          scope = {
            deprecated = false;
          };
          align = {
            deprecated = true;
          };
          axis = {
            deprecated = true;
          };
          bgcolor = {
            deprecated = true;
          };
          char = {
            deprecated = true;
          };
          charoff = {
            deprecated = true;
          };
          height = {
            deprecated = true;
          };
          valign = {
            deprecated = true;
          };
          width = {
            deprecated = true;
          };
        };
      };
      thead = {
        deprecated = false;
        attributes = {
          align = {
            deprecated = true;
          };
          bgcolor = {
            deprecated = true;
          };
          char = {
            deprecated = true;
          };
          charoff = {
            deprecated = true;
          };
          valign = {
            deprecated = true;
          };
        };
      };
      time = {
        deprecated = false;
        attributes = {
          datetime = {
            deprecated = false;
          };
        };
      };
      title = {
        deprecated = false;
        attributes = { };
      };
      tr = {
        deprecated = false;
        attributes = {
          align = {
            deprecated = true;
          };
          bgcolor = {
            deprecated = true;
          };
          char = {
            deprecated = true;
          };
          charoff = {
            deprecated = true;
          };
          valign = {
            deprecated = true;
          };
        };
      };
      track = {
        void = true;
        deprecated = false;
        attributes = {
          default = {
            boolean = true;
            deprecated = false;
          };
          kind = {
            deprecated = false;
          };
          label = {
            deprecated = false;
          };
          src = {
            deprecated = false;
          };
          srclang = {
            deprecated = false;
          };
        };
      };
      tt = {
        deprecated = true;
        attributes = { };
      };
      u = {
        deprecated = false;
        attributes = { };
      };
      ul = {
        deprecated = false;
        attributes = {
          compact = {
            deprecated = true;
          };
          type = {
            deprecated = true;
          };
        };
      };
      var = {
        deprecated = false;
        attributes = { };
      };
      video = {
        deprecated = false;
        attributes = {
          autoplay = {
            boolean = true;
            deprecated = false;
          };
          controls = {
            boolean = true;
            deprecated = false;
          };
          controlslist = {
            deprecated = false;
          };
          crossorigin = {
            deprecated = false;
          };
          disablepictureinpicture = {
            deprecated = false;
          };
          disableremoteplayback = {
            deprecated = false;
          };
          height = {
            deprecated = false;
          };
          loop = {
            boolean = true;
            deprecated = false;
          };
          muted = {
            boolean = true;
            deprecated = false;
          };
          playsinline = {
            boolean = true;
            deprecated = false;
          };
          poster = {
            deprecated = false;
          };
          preload = {
            deprecated = false;
          };
          src = {
            deprecated = false;
          };
          width = {
            deprecated = false;
          };
        };
      };
      wbr = {
        void = true;
        deprecated = false;
        attributes = { };
      };
      xmp = {
        deprecated = true;
        attributes = { };
      };
    }
    |> lib.mapAttrs (n: v: v // { attributes = common.attributes // v.attributes; });
in
{
  inherit elements;
}
