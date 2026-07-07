<%@ tag description="Master Layout Template" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Define attributes that pages can pass into this layout --%>
<%@ attribute name="title" required="false" rtexprvalue="true" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width" />
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@300;400;500;700&display=swap" rel="stylesheet" />
    <title>${not empty title ? title : 'Assignment 1 Webapp'}</title>
   
    <%-- referencing tailwind.css --%>
    <link href="${pageContext.request.contextPath}/resources/css/tailwind.css" rel="stylesheet" type="text/css">

  </head>
  <body class="bg-white text-black overflow-x-hidden">
    <div class="absolute z-50 top-0 h-full w-fit flex-none">
      <%-- nav bar --%>
    </div>

    <main class="relative w-full">
      <%-- This tag dynamically injects the body of the target JSP page --%>
      <jsp:doBody />
      <%-- footer --%>
    </main>

    <%-- custom cursor --%>

  </body>
</html>
