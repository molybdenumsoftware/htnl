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
        attributes = {
          attributionsrc = {
            experimental = true;
          };
          download = {
          };
          href = {
          };
          hreflang = {
          };
          ping = {
            list.delimiter = " ";
          };
          referrerpolicy = {
          };
          rel = {
            list.delimiter = " ";
          };
          target = {
          };
          type = {
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
        attributes = { };
      };
      acronym = {
        deprecated = true;
        attributes = { };
      };
      address = {
        attributes = { };
      };
      area = {
        void = true;
        attributes = {
          alt = {
          };
          coords = {
            list.delimiter = ",";
          };
          download = {
          };
          href = {
          };
          ping = {
            list.delimiter = " ";
          };
          referrerpolicy = {
          };
          rel = {
            list.delimiter = " ";
          };
          shape = {
          };
          target = {
          };
        };
      };
      article = {
        attributes = { };
      };
      aside = {
        attributes = { };
      };
      audio = {
        attributes = {
          autoplay = {
            boolean = true;
          };
          controls = {
            boolean = true;
          };
          controlslist = {
          };
          crossorigin = {
          };
          disableremoteplayback = {
          };
          loop = {
            boolean = true;
          };
          muted = {
            boolean = true;
          };
          preload = {
          };
          src = {
          };
        };
      };
      b = {
        attributes = { };
      };
      base = {
        void = true;
        attributes = {
          href = {
          };
          target = {
          };
        };
      };
      bdi = {
        attributes = { };
      };
      bdo = {
        attributes = {
          dir = {
          };
        };
      };
      big = {
        deprecated = true;
        attributes = { };
      };
      blockquote = {
        attributes = {
          cite = {
          };
        };
      };
      body = {
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
          };
          onbeforeprint = {
          };
          onbeforeunload = {
          };
          onblur = {
          };
          onerror = {
          };
          onfocus = {
          };
          onhashchange = {
          };
          onlanguagechange = {
          };
          onload = {
          };
          onmessage = {
          };
          onoffline = {
          };
          ononline = {
          };
          onpopstate = {
          };
          onresize = {
          };
          onstorage = {
          };
          onunload = {
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
        attributes = {
          clear = {
            deprecated = true;
          };
        };
      };
      button = {
        attributes = {
          autofocus = {
            boolean = true;
          };
          disabled = {
            boolean = true;
          };
          form = {
          };
          formaction = {
          };
          formenctype = {
          };
          formmethod = {
          };
          formnovalidate = {
            boolean = true;
          };
          formtarget = {
          };
          name = {
          };
          popovertarget = {
          };
          popovertargetaction = {
          };
          type = {
          };
          value = {
          };
        };
      };
      canvas = {
        attributes = {
          height = {
          };
          moz-opaque = {
            deprecated = true;
          };
          width = {
          };
        };
      };
      caption = {
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
        attributes = { };
      };
      code = {
        attributes = { };
      };
      col = {
        void = true;
        attributes = {
          span = {
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
        attributes = {
          span = {
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
        attributes = {
          value = {
          };
        };
      };
      datalist = {
        attributes = { };
      };
      dd = {
        attributes = { };
      };
      del = {
        attributes = {
          cite = {
          };
          datetime = {
          };
        };
      };
      details = {
        attributes = {
          open = {
            boolean = true;
          };
          name = {
          };
        };
      };
      dfn = {
        attributes = { };
      };
      dialog = {
        attributes = {
          open = {
            boolean = true;
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
        attributes = { };
      };
      dl = {
        attributes = { };
      };
      dt = {
        attributes = { };
      };
      em = {
        attributes = { };
      };
      embed = {
        void = true;
        attributes = {
          height = {
          };
          src = {
          };
          type = {
          };
          width = {
          };
        };
      };
      fencedframe = {
        experimental = true;
        attributes = {
          allow = {
            experimental = true;
          };
          height = {
            experimental = true;
          };
          width = {
            experimental = true;
          };
        };
      };
      fieldset = {
        attributes = {
          disabled = {
            boolean = true;
          };
          form = {
          };
          name = {
          };
        };
      };
      figcaption = {
        attributes = { };
      };
      figure = {
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
        attributes = { };
      };
      form = {
        attributes = {
          accept = {
            deprecated = true;
            list.delimiter = ",";
          };
          accept-charset = {
          };
          autocapitalize = {
          };
          autocomplete = {
            list.delimiter = " ";
          };
          name = {
          };
          novalidate = {
            boolean = true;
          };
          rel = {
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
        attributes = { };
      };
      h2 = {
        attributes = { };
      };
      h3 = {
        attributes = { };
      };
      h4 = {
        attributes = { };
      };
      h5 = {
        attributes = { };
      };
      h6 = {
        attributes = { };
      };
      head = {
        attributes = {
          profile = {
            deprecated = true;
          };
        };
      };
      header = {
        attributes = { };
      };
      hgroup = {
        attributes = { };
      };
      hr = {
        void = true;
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
        attributes = {
          version = {
            deprecated = true;
          };
          xmlns = {
          };
        };
      };
      i = {
        attributes = { };
      };
      iframe = {
        attributes = {
          allow = {
          };
          allowfullscreen = {
            boolean = true;
          };
          allowpaymentrequest = {
            deprecated = true;
          };
          browsingtopics = {
            experimental = true;
          };
          credentialless = {
            experimental = true;
          };
          csp = {
            experimental = true;
          };
          height = {
          };
          loading = {
          };
          name = {
          };
          referrerpolicy = {
          };
          sandbox = {
          };
          src = {
          };
          srcdoc = {
          };
          width = {
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
        attributes = {
          alt = {
          };
          attributionsrc = {
            experimental = true;
          };
          crossorigin = {
          };
          decoding = {
          };
          elementtiming = {
          };
          fetchpriority = {
          };
          height = {
          };
          ismap = {
            boolean = true;
          };
          loading = {
          };
          referrerpolicy = {
          };
          sizes = {
            list.delimiter = ",";
          };
          src = {
          };
          srcset = {
            list.delimiter = ",";
          };
          width = {
          };
          usemap = {
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
        attributes = {
          accept = {
            list.delimiter = ",";
          };
          alt = {
          };
          autocapitalize = {
          };
          autocomplete = {
            list.delimiter = " ";
          };
          autofocus = {
            boolean = true;
          };
          capture = {
          };
          checked = {
            boolean = true;
          };
          dirname = {
          };
          disabled = {
            boolean = true;
          };
          form = {
          };
          formaction = {
          };
          formenctype = {
          };
          formmethod = {
          };
          formnovalidate = {
            boolean = true;
          };
          formtarget = {
          };
          height = {
          };
          id = {
          };
          inputmode = {
          };
          list = {
          };
          max = {
          };
          maxlength = {
          };
          min = {
          };
          minlength = {
          };
          multiple = {
            boolean = true;
          };
          name = {
          };
          pattern = {
          };
          placeholder = {
          };
          popovertarget = {
          };
          popovertargetaction = {
          };
          readonly = {
            boolean = true;
          };
          required = {
            boolean = true;
          };
          size = {
          };
          src = {
          };
          step = {
          };
          tabindex = {
          };
          title = {
          };
          type = {
          };
          value = {
          };
          width = {
          };
        };
      };
      ins = {
        attributes = {
          cite = {
          };
          datetime = {
          };
        };
      };
      kbd = {
        attributes = { };
      };
      label = {
        attributes = {
          for = {
          };
        };
      };
      legend = {
        attributes = { };
      };
      li = {
        attributes = {
          value = {
          };
          type = {
            deprecated = true;
          };
        };
      };
      link = {
        void = true;
        attributes = {
          as = {
          };
          blocking = {
            experimental = true;
            list.delimiter = " ";
          };
          crossorigin = {
          };
          disabled = {
            boolean = true;
          };
          fetchpriority = {
          };
          href = {
          };
          hreflang = {
          };
          imagesizes = {
            list.delimiter = ",";
          };
          imagesrcset = {
            list.delimiter = ",";
          };
          integrity = {
          };
          media = {
          };
          referrerpolicy = {
          };
          rel = {
            list.delimiter = " ";
          };
          sizes = {
            list.delimiter = " ";
          };
          title = {
          };
          type = {
          };
        };
      };
      main = {
        attributes = { };
      };
      map = {
        attributes = {
          name = {
          };
        };
      };
      mark = {
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
        attributes = { };
      };
      meta = {
        void = true;
        attributes = {
          charset = {
          };
          content = {
          };
          http-equiv = {
          };
          name = {
          };
        };
      };
      meter = {
        attributes = {
          value = {
          };
          min = {
          };
          max = {
          };
          low = {
          };
          high = {
          };
          optimum = {
          };
          form = {
          };
        };
      };
      nav = {
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
        attributes = { };
      };
      object = {
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
          };
          declare = {
            deprecated = true;
          };
          form = {
          };
          height = {
          };
          name = {
          };
          standby = {
            deprecated = true;
          };
          type = {
          };
          usemap = {
            deprecated = true;
          };
          width = {
          };
        };
      };
      ol = {
        attributes = {
          reversed = {
            boolean = true;
          };
          start = {
          };
          type = {
          };
        };
      };
      optgroup = {
        attributes = {
          disabled = {
            boolean = true;
          };
          label = {
          };
        };
      };
      option = {
        attributes = {
          disabled = {
            boolean = true;
          };
          label = {
          };
          selected = {
            boolean = true;
          };
          value = {
          };
        };
      };
      output = {
        attributes = {
          for = {
            list.delimiter = " ";
          };
          form = {
          };
          name = {
          };
        };
      };
      p = {
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
        attributes = { };
      };
      plaintext = {
        deprecated = true;
        attributes = { };
      };
      portal = {
        experimental = true;
        attributes = {
          referrerpolicy = {
          };
          src = {
          };
        };
      };
      pre = {
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
        attributes = {
          max = {
          };
          value = {
          };
        };
      };
      q = {
        attributes = {
          cite = {
          };
        };
      };
      rb = {
        deprecated = true;
        attributes = { };
      };
      rp = {
        attributes = { };
      };
      rt = {
        attributes = { };
      };
      rtc = {
        deprecated = true;
        attributes = { };
      };
      ruby = {
        attributes = { };
      };
      s = {
        attributes = { };
      };
      samp = {
        attributes = { };
      };
      script = {
        attributes = {
          async = {
            boolean = true;
          };
          attributionsrc = {
            experimental = true;
          };
          blocking = {
            experimental = true;
            list.delimiter = " ";
          };
          crossorigin = {
          };
          defer = {
            boolean = true;
          };
          fetchpriority = {
          };
          integrity = {
          };
          nomodule = {
            boolean = true;
          };
          nonce = {
          };
          referrerpolicy = {
          };
          src = {
          };
          type = {
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
        attributes = { };
      };
      section = {
        attributes = { };
      };
      select = {
        attributes = {
          autocomplete = {
            list.delimiter = " ";
          };
          autofocus = {
            boolean = true;
          };
          disabled = {
            boolean = true;
          };
          form = {
          };
          multiple = {
            boolean = true;
          };
          name = {
          };
          required = {
            boolean = true;
          };
          size = {
          };
        };
      };
      slot = {
        attributes = {
          name = {
          };
        };
      };
      small = {
        attributes = { };
      };
      source = {
        void = true;
        attributes = {
          type = {
          };
          src = {
          };
          srcset = {
            list.delimiter = ",";
          };
          sizes = {
            list.delimiter = ",";
          };
          media = {
          };
          height = {
          };
          width = {
          };
        };
      };
      span = {
        attributes = { };
      };
      strike = {
        deprecated = true;
        attributes = { };
      };
      strong = {
        attributes = { };
      };
      style = {
        attributes = {
          blocking = {
            experimental = true;
            list.delimiter = " ";
          };
          media = {
          };
          nonce = {
          };
          title = {
          };
          type = {
            deprecated = true;
          };
        };
      };
      sub = {
        attributes = { };
      };
      summary = {
        attributes = { };
      };
      sup = {
        attributes = { };
      };
      table = {
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
        attributes = {
          colspan = {
          };
          headers = {
            list.delimiter = " ";
          };
          rowspan = {
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
        attributes = {
          shadowrootmode = {
          };
          shadowrootclonable = {
            boolean = true;
          };
          shadowrootdelegatesfocus = {
            boolean = true;
          };
          shadowrootserializable = {
            boolean = true;
            experimental = true;
          };
        };
      };
      textarea = {
        attributes = {
          autocapitalize = {
          };
          autocomplete = {
            list.delimiter = " ";
          };
          autocorrect = {
          };
          autofocus = {
            boolean = true;
          };
          cols = {
          };
          dirname = {
          };
          disabled = {
            boolean = true;
          };
          form = {
          };
          maxlength = {
          };
          minlength = {
          };
          name = {
          };
          placeholder = {
          };
          readonly = {
            boolean = true;
          };
          required = {
            boolean = true;
          };
          rows = {
          };
          spellcheck = {
          };
          wrap = {
          };
        };
      };
      tfoot = {
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
        attributes = {
          abbr = {
          };
          colspan = {
          };
          headers = {
            list.delimiter = " ";
          };
          rowspan = {
          };
          scope = {
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
        attributes = {
          datetime = {
          };
        };
      };
      title = {
        attributes = { };
      };
      tr = {
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
        attributes = {
          default = {
            boolean = true;
          };
          kind = {
          };
          label = {
          };
          src = {
          };
          srclang = {
          };
        };
      };
      tt = {
        deprecated = true;
        attributes = { };
      };
      u = {
        attributes = { };
      };
      ul = {
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
        attributes = { };
      };
      video = {
        attributes = {
          autoplay = {
            boolean = true;
          };
          controls = {
            boolean = true;
          };
          controlslist = {
          };
          crossorigin = {
          };
          disablepictureinpicture = {
          };
          disableremoteplayback = {
          };
          height = {
          };
          loop = {
            boolean = true;
          };
          muted = {
            boolean = true;
          };
          playsinline = {
            boolean = true;
          };
          poster = {
          };
          preload = {
          };
          src = {
          };
          width = {
          };
        };
      };
      wbr = {
        void = true;
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
