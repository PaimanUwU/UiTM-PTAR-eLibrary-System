<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Browse Books - UiTM PTAR eLibrary</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-slate-50 text-slate-800 min-h-screen flex flex-col">

    <!-- Top Navigation Bar -->
    <nav class="bg-purple-900 text-white shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-16">
                <div class="flex items-center">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="font-bold text-xl tracking-tight">UiTM PTAR <span class="text-purple-300">eLibrary</span></a>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/login" class="bg-purple-700 hover:bg-purple-600 text-white font-medium px-5 py-2 rounded-lg transition duration-200">
                        Sign In
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="flex-grow max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <!-- Welcome Prompt Banner -->
        <div class="bg-indigo-50 border border-indigo-200 rounded-xl p-6 mb-8 flex flex-col md:flex-row items-center justify-between gap-4">
            <div>
                <h3 class="text-lg font-bold text-indigo-900">Want to borrow books or access E-Resources?</h3>
                <p class="text-indigo-700 text-sm mt-1">Sign in with your Borrower credentials to request loans and access full content download links.</p>
            </div>
            <a href="${pageContext.request.contextPath}/login" class="bg-indigo-600 hover:bg-indigo-700 text-white font-semibold px-6 py-3 rounded-lg shadow-sm transition duration-150">
                Sign In Now
            </a>
        </div>

        <div class="mb-8">
            <h1 class="text-3xl font-extrabold text-slate-900">Library Catalogue</h1>
            <p class="text-slate-500 mt-1">Discover available educational materials and resources.</p>
        </div>

        <!-- Search Bar -->
        <form action="${pageContext.request.contextPath}/books" method="GET" class="mb-8">
            <input type="hidden" name="action" value="list">
            <div class="flex flex-col sm:flex-row gap-3">
                <input type="text" name="search" placeholder="Search by title, author, or ISBN..." value="${param.search}"
                       class="flex-grow px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-purple-600 focus:border-purple-600 outline-none transition">
                <button type="submit" class="bg-purple-900 hover:bg-purple-800 text-white font-medium px-6 py-3 rounded-xl transition duration-150">
                    Search
                </button>
            </div>
        </form>

        <!-- Books Grid -->
        <c:choose>
            <c:when test="${empty books}">
                <div class="text-center py-12 bg-white rounded-2xl border border-slate-200">
                    <p class="text-slate-500 text-lg">No books found matching your criteria.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <c:forEach var="book" items="${books}">
                        <div class="bg-white rounded-2xl border border-slate-200 p-6 flex flex-col justify-between hover:shadow-md transition">
                            <div>
                                <div class="flex items-center justify-between mb-4">
                                    <span class="px-3 py-1 text-xs font-semibold rounded-full 
                                        ${book.book_type == 'E-BOOK' ? 'bg-blue-100 text-blue-800' : 'bg-green-100 text-green-800'}">
                                        ${book.book_type}
                                    </span>
                                    <span class="text-sm text-slate-500 font-mono">ISBN: ${book.ISBN}</span>
                                </div>
                                <h3 class="text-xl font-bold text-slate-950 line-clamp-2 mb-1">${book.book_title}</h3>
                                <p class="text-slate-600 text-sm mb-2">by <span class="font-medium">${book.author_name}</span></p>
                                <div class="flex items-center text-xs text-slate-500 gap-2 mb-4">
                                    <span>Publisher: ${book.publisher}</span>
                                    <span>&bull;</span>
                                    <span>Year: ${book.publish_year}</span>
                                </div>
                            </div>
                            <div class="mt-4 pt-4 border-t border-slate-100 flex items-center justify-between">
                                <span class="text-xs font-semibold uppercase tracking-wider 
                                    ${book.book_status == 'AVAILABLE' ? 'text-green-600' : 'text-amber-600'}">
                                    ${book.book_status}
                                </span>
                                <a href="${pageContext.request.contextPath}/books?action=info&id=${book.book_id}" class="text-purple-900 hover:text-purple-700 font-semibold text-sm">
                                    View Details &rarr;
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </main>

    <!-- Footer -->
    <footer class="bg-slate-900 text-slate-400 py-8 text-center text-sm border-t border-slate-800">
        <p>&copy; 2026 UiTM PTAR eLibrary System. All rights reserved.</p>
    </footer>

</body>
</html>
