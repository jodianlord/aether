package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\" class=\"no-js\">\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"UTF-8\" />\n");
      out.write("        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> \n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"> \n");
      out.write("        <title>Aether</title>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/normalize.css\" />\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/loginbox.css\" />\n");
      out.write("        <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet'>\n");
      out.write("\n");
      out.write("        <style type=\"text/css\">\n");
      out.write("            body{\n");
      out.write("                background-image: url(\"img/bg1.png\");\n");
      out.write("                background-repeat: no-repeat;\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <div class=\"container demo-1\">\n");
      out.write("            <div class=\"content\">\n");
      out.write("                <div id=\"large-header\" class=\"large-header\">\n");
      out.write("                    <canvas id=\"demo-canvas\"></canvas>\n");
      out.write("\n");
      out.write("                    <div class=\"form\">\n");
      out.write("                        <img height=\"150\" width=\"285\" src=\"img/aetherlogo_white.png\" style=\"margin-left: 23%;margin-top: -5%;\">\n");
      out.write("                        <ul class=\"tab-group\">\n");
      out.write("                            <li class=\"tab active\"><a href=\"#login\">Log In</a></li>\n");
      out.write("                            <li class=\"tab\"><a href=\"#signup\">Sign Up</a></li>\n");
      out.write("                        </ul>\n");
      out.write("\n");
      out.write("                        <div class=\"tab-content\">\n");
      out.write("                            \n");
      out.write("                            <div id=\"login\">   \n");
      out.write("                                <form action=\"/\" method=\"post\">\n");
      out.write("                                    <div class=\"field-wrap\">\n");
      out.write("                                        <label>\n");
      out.write("                                            Email Address<span class=\"req\">*</span>\n");
      out.write("                                        </label>\n");
      out.write("                                        <input type=\"email\"required autocomplete=\"off\"/>\n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <div class=\"field-wrap\">\n");
      out.write("                                        <label>\n");
      out.write("                                            Password<span class=\"req\">*</span>\n");
      out.write("                                        </label>\n");
      out.write("                                        <input type=\"password\"required autocomplete=\"off\"/>\n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <p class=\"forgot\"><a href=\"#\">Forgot Password?</a></p>\n");
      out.write("\n");
      out.write("                                    <button class=\"button button-block\"/>LOG IN</button>\n");
      out.write("                                </form>\n");
      out.write("                            </div>\n");
      out.write("                            \n");
      out.write("                            \n");
      out.write("                            <div id=\"signup\">   \n");
      out.write("                                <form action=\"SignUpServlet\" method=\"post\">\n");
      out.write("                                    <div class=\"top-row\">\n");
      out.write("                                        <div class=\"field-wrap\">\n");
      out.write("                                            <label>\n");
      out.write("                                                User ID<span class=\"req\">*</span>\n");
      out.write("                                            </label>\n");
      out.write("                                            <input type=\"text\" name='userid' required autocomplete=\"off\" />\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"field-wrap\">\n");
      out.write("                                            <label>\n");
      out.write("                                                Password<span class=\"req\">*</span>\n");
      out.write("                                            </label>\n");
      out.write("                                            <input type=\"password\" name='password' required autocomplete=\"off\"/>\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <div class=\"field-wrap\">\n");
      out.write("                                        <label>\n");
      out.write("                                            Public Key<span class=\"req\">*</span>\n");
      out.write("                                        </label>\n");
      out.write("                                        <input type=\"text\" name='publickey' required autocomplete=\"off\"/>\n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <div class=\"field-wrap\">\n");
      out.write("                                        <label>\n");
      out.write("                                            Private Key<span class=\"req\">*</span>\n");
      out.write("                                        </label>\n");
      out.write("                                        <input type=\"text\" name='privatekey' required autocomplete=\"off\"/>\n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <button type=\"submit\" class=\"button button-block\"/>SIGN UP</button>\n");
      out.write("                                </form>\n");
      out.write("                            </div>\n");
      out.write("                        </div><!-- tab-content -->\n");
      out.write("                    </div> \n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div><!-- /container -->\n");
      out.write("        <script src=\"js/TweenLite.min.js\"></script>\n");
      out.write("        <script src=\"js/EasePack.min.js\"></script>\n");
      out.write("        <script src=\"js/demo-1.js\"></script>\n");
      out.write("        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>\n");
      out.write("        <script>\n");
      out.write("            $('.form').find('input, textarea').on('keyup blur focus', function (e) {\n");
      out.write("\n");
      out.write("                var $this = $(this),\n");
      out.write("                        label = $this.prev('label');\n");
      out.write("\n");
      out.write("                if (e.type === 'keyup') {\n");
      out.write("                    if ($this.val() === '') {\n");
      out.write("                        label.removeClass('active highlight');\n");
      out.write("                    } else {\n");
      out.write("                        label.addClass('active highlight');\n");
      out.write("                    }\n");
      out.write("                } else if (e.type === 'blur') {\n");
      out.write("                    if ($this.val() === '') {\n");
      out.write("                        label.removeClass('active highlight');\n");
      out.write("                    } else {\n");
      out.write("                        label.removeClass('highlight');\n");
      out.write("                    }\n");
      out.write("                } else if (e.type === 'focus') {\n");
      out.write("\n");
      out.write("                    if ($this.val() === '') {\n");
      out.write("                        label.removeClass('highlight');\n");
      out.write("                    } else if ($this.val() !== '') {\n");
      out.write("                        label.addClass('highlight');\n");
      out.write("                    }\n");
      out.write("                }\n");
      out.write("\n");
      out.write("            });\n");
      out.write("\n");
      out.write("            $('.tab a').on('click', function (e) {\n");
      out.write("\n");
      out.write("                e.preventDefault();\n");
      out.write("\n");
      out.write("                $(this).parent().addClass('active');\n");
      out.write("                $(this).parent().siblings().removeClass('active');\n");
      out.write("\n");
      out.write("                target = $(this).attr('href');\n");
      out.write("\n");
      out.write("                $('.tab-content > div').not(target).hide();\n");
      out.write("\n");
      out.write("                $(target).fadeIn(600);\n");
      out.write("\n");
      out.write("            });\n");
      out.write("        </script>\n");
      out.write("    </body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
