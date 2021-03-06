<%--
  ~ Copyright (c) 2014, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>

<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>
<%@include file="localize.jsp" %>

<%
    String app = request.getParameter("application");
    String scopeString = request.getParameter("scope");
    boolean displayScopes = Boolean.parseBoolean(getServletContext().getInitParameter("displayScopes"));
%>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=AuthenticationEndpointUtil.i18n(resourceBundle, "wso2.identity.server")%></title>

    <link rel="icon" href="images/favicon.png" type="image/x-icon"/>
    <link href="libs/bootstrap_3.3.5/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/Roboto.css" rel="stylesheet">
    <link href="css/custom-common.css" rel="stylesheet">

    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<script type="text/javascript">
    function approved() {
        document.getElementById('consent').value = "approve";
        document.getElementById("profile").submit();
    }
    function approvedAlways() {
        document.getElementById('consent').value = "approveAlways";
        document.getElementById("profile").submit();
    }
    function deny() {
        document.getElementById('consent').value = "deny";
        document.getElementById("profile").submit();
    }
</script>

<!-- header -->
<header class="header header-default">
    <div class="container-fluid"><br></div>
    <div class="container-fluid">
        <div class="pull-left brand float-remove-xs text-center-xs">
            <a href="#">
                <img src="images/logo-inverse.svg" alt="wso2" title="wso2" class="logo">
                <h1><em><%=AuthenticationEndpointUtil.i18n(resourceBundle, "identity.server")%> </em></h1>
            </a>
        </div>
    </div>
</header>

<!-- page content -->
<div class="container-fluid body-wrapper">

    <div class="row">
        <div class="col-md-12">

            <!-- content -->
            <div class="container col-xs-10 col-sm-6 col-md-6 col-lg-3 col-centered wr-content wr-login col-centered">
                <div>
                    <h2 class="wr-title uppercase blue-bg padding-double white boarder-bottom-blue margin-none">
                        <%=AuthenticationEndpointUtil.i18n(resourceBundle, "openid.user.claims")%>
                    </h2>
                </div>

                <div class="boarder-all ">
                    <div class="clearfix"></div>
                    <form action="../oauth2/authorize" method="post" id="profile" name="oauth2_authz"
                          class="form-horizontal" >
                        <div class="padding-double login-form">
                            <div class="form-group">
                                <p><strong><%=Encode.forHtml(request.getParameter("application"))%></strong>
                                    <%=AuthenticationEndpointUtil.i18n(resourceBundle, "request.access.profile")%>
                                </p>
                                <%
                                    if (displayScopes && scopeString != null) {
                                %>
                                <ul>
                                <%
                                        String[] scopes = scopeString.split(" ");
                                        for (String scopeID : scopes) {

                                            if ("openid".equals(scopeID)) {
                                                continue;
                                            }
                                %>
                                        <li><%=Encode.forHtml(scopeID)%></li>
                                <%
                                        }
                                %>
                                </ul>
                                <%
                                    }
                                %>
                            </div>
                            <table width="100%" class="styledLeft">
                                <tbody>
                                <tr>
                                    <td class="buttonRow" colspan="2">

                                        <div style="text-align:left;">
                                            <input type="button" class="btn  btn-primary" id="approve" name="approve"
                                                   onclick="javascript: approved(); return false;"
                                                   value="<%=AuthenticationEndpointUtil.i18n(resourceBundle,
                                                    "approve")%>"/>
                                            <input type="button" class="btn" id="chkApprovedAlways"
                                                   onclick="javascript: approvedAlways(); return false;"
                                                   value="<%=AuthenticationEndpointUtil.i18n(resourceBundle,
                                                    "approve.always")%>"/>
                                            <input type="hidden" id="hasApprovedAlways" name="hasApprovedAlways"
                                                   value="false"/>
                                            <input class="btn" type="reset"
                                                   value="<%=AuthenticationEndpointUtil.i18n(resourceBundle,"deny")%>"
                                                   onclick="javascript: deny(); return false;"/>
                                        </div>

                                        <input type="hidden" name="<%=Constants.SESSION_DATA_KEY_CONSENT%>"
                                               value="<%=Encode.forHtmlAttribute(request.getParameter
								(Constants.SESSION_DATA_KEY_CONSENT))%>"/>
                                        <input type="hidden" name="consent" id="consent"
                                               value="deny"/>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </form>

                </div>
            </div>


        </div>
        <!-- /content -->

    </div>
</div>
<!-- /content/body -->

</div>

<!-- footer -->
<footer class="footer">
    <div class="container-fluid">
        <p><%=AuthenticationEndpointUtil.i18n(resourceBundle, "wso2.identity.server")%> | &copy;
            <script>document.write(new Date().getFullYear());</script>
            <a href="http://wso2.com/" target="_blank"><i class="icon fw fw-wso2"></i>
                <%=AuthenticationEndpointUtil.i18n(resourceBundle, "inc")%>
            </a>. <%=AuthenticationEndpointUtil.i18n(resourceBundle, "all.rights.reserved")%>
        </p>
    </div>
</footer>

<script src="libs/jquery_1.11.3/jquery-1.11.3.js"></script>
<script src="libs/bootstrap_3.3.5/js/bootstrap.min.js"></script>
</body>
</html>
